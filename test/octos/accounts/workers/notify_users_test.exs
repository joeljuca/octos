defmodule Octos.Accounts.Workers.NotifyUsersTest do
  use Octos.DataCase
  use Oban.Testing, repo: Octos.Repo
  import Octos.Factory
  alias Octos.Accounts
  alias Octos.Accounts.Workers.NotifyUsers

  setup do
    for m <- [Accounts.User, Oban.Job], do: Octos.Repo.delete_all(m)
    :ok
  end

  describe "Accounts.Workers.NotifyUsers.perform/1" do
    test "no-ops when there's no user" do
      Oban.Testing.with_testing_mode(:manual, fn ->
        args = %{"notification" => %{}}

        perform_job(NotifyUsers, args)
        refute_enqueued(worker: NotifyUsers, args: args)
      end)
    end

    test "enqueues itself recursively to notify remaining users" do
      insert_list(2, :user)
      user = insert(:user)

      Oban.Testing.with_testing_mode(:manual, fn ->
        args = %{"notification" => %{}, "batch" => 2}

        perform_job(NotifyUsers, args)
        assert_enqueued(worker: NotifyUsers, args: args |> Map.put("from", user.id))
      end)
    end
  end
end
