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
        if is_nil(order_by), do: query, else: query |> order_by([u], [{^order, ^order_by}])
      end)

    {:ok, Repo.all(query)}
  rescue
    error -> {:error, error}
  end
end
