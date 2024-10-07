defmodule Octos.Accounts.Workers.NotifyUsers do
  require Logger
  use Oban.Worker, queue: :default
  import Ecto.Query
  alias Octos.Accounts

  @impl Oban.Worker
  def perform(%Oban.Job{args: args}) do
    notification = args |> Map.fetch!("notification")
    from_id = args |> Map.get("from")
    batch = args |> Map.get("batch", 1000)

    limit = batch + 1

    users =
      from(u in Accounts.User)
      |> then(fn query ->
        if is_nil(from_id) do
          query
        else
          query |> where([u], u.id >= ^from_id)
        end
      end)
      |> order_by([u], asc: u.id)
      |> limit(^limit)
      |> Octos.Repo.all()

    count = Enum.count(users)

    last = if count < limit, do: nil, else: List.last(users)
    users = if is_nil(last), do: users, else: Enum.split(users, count - 1) |> elem(0)

    for user <- users, do: notify_user(user, notification)

    if not is_nil(last) do
      %{
        notification: notification,
        batch: batch,
        from: last.id
      }
      |> __MODULE__.new()
      |> Oban.insert!()
    end

    :ok
  end

  defp notify_user(%Accounts.User{} = user, %{} = notification) do
    # The "notification" thing is implemented as a simple log msg,
    # but IRL it would be an email, a mobile notification, etc.
    Logger.info("Notify user #{user.id}: #{inspect(notification)}")
  end
end
