defmodule Octos.AccountsTest do
  use Octos.DataCase
  import Octos.Factory
  alias Octos.Accounts

  setup do
    for m <- [Octos.Cameras.Camera, Octos.Accounts.User], do: Octos.Repo.delete_all(m)

    insert(:user)
    |> then(&insert_list(2, :camera, user_id: &1.id))

    :ok
  end

  describe "Accounts.list_users/1" do
    test "lists users with their cameras" do
      assert {:ok, users} = Accounts.list_users()
      assert is_list(users)
      for user <- users, do: assert(%Octos.Accounts.User{} = user)
    end

    test "allows ordering by name (asc)" do
      insert(:user)

      user_names = Octos.Accounts.User.all() |> Enum.map(& &1.name)

      assert {:ok, users} = Accounts.list_users(%{"order_by" => "name"})
      assert is_list(users)

      assert user_names == for(u <- users, do: u.name)
    end

    test "allows ordering by name (desc)" do
      insert(:user)

      user_names = Octos.Accounts.User.all() |> Enum.map(& &1.name) |> Enum.sort(:desc)

      assert {:ok, users} = Accounts.list_users(%{"order_by" => "name", "order" => "desc"})
      assert is_list(users)

      assert user_names == for(u <- users, do: u.name)
    end
  end
end
