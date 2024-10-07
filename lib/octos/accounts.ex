defmodule Octos.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query
  alias Octos.Accounts
  alias Octos.Cameras
  alias Octos.Repo

  @spec list_users(params :: map()) ::
          {:ok, list(Accounts.User.t())} | {:error, term()}
  def list_users(%{} = params \\ %{}) do
    order_by = Map.get(params, "order_by")
    order_by = if order_by not in ["name"], do: nil, else: String.to_atom(order_by)
    order = Map.get(params, "order")
    order = if order not in ["asc", "desc"], do: :asc, else: String.to_atom(order)

    query =
      from(u in Accounts.User)
      |> join(:left, [u], c in Cameras.Camera, on: u.id == c.user_id)
      |> preload([u], [:cameras])
      |> distinct(true)
      |> then(fn query ->
        if is_nil(order_by),
          do: query |> order_by([u], asc: :id),
          else: query |> order_by([u], [{^order, ^order_by}])
      end)

    {:ok, Repo.all(query)}
  rescue
    error -> {:error, error}
  end

  @spec notify_users(params :: map()) ::
          :ok | {:error, term()}
  def notify_users(%{"notification" => %{}} = params \\ %{}) do
    batch = params |> Map.get("batch", 2)
    notification = params |> Map.fetch!("notification")

    t = fn ->
      first_id =
        from(u in Accounts.User)
        |> select([u], u.id)
        |> order_by([u], asc: u.id)
        |> limit(1)
        |> Octos.Repo.one()

      if is_nil(first_id) do
        # No user in database
        :ok
      else
        params = %{
          notification: notification,
          batch: batch,
          from: first_id
        }

        with changeset <- Accounts.Workers.NotifyUsers.new(params),
             {:ok, job} <- Oban.insert(changeset),
             do: job
      end
    end

    with {:ok, _} <- Octos.Repo.transaction(t), do: :ok
  rescue
    error -> {:error, error}
  end
end
