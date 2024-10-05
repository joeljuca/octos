defmodule OctosWeb.CameraControllerTest do
  use OctosWeb.ConnCase
  import Octos.Factory
  alias Octos.Accounts.User
  alias Octos.Cameras.Camera

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET /api/cameras" do
    setup do
      for s <- [Camera, User], do: Octos.Repo.delete_all(s)

      insert_list(3, :user)
      |> then(&for u <- &1, do: insert_list(2, :camera, user_id: u.id))

      :ok
    end

    test "lists users with their cameras", %{conn: conn} do
      conn = get(conn, ~p"/api/cameras")
      assert conn.status == 200

      assert body = json_response(conn, 200)
      assert is_list(body["users"])

      for user <- body["users"] do
        assert is_integer(user["id"])
        assert is_binary(user["name"])
        assert is_binary(user["email"])
        assert is_list(user["cameras"])

        for camera <- user["cameras"] do
          assert is_integer(camera["id"])
          assert is_binary(camera["brand"])
          assert is_binary(camera["model"])
          assert is_binary(camera["name"])
        end
      end
    end

    test "allows ordering by name (asc)", %{conn: conn} do
      insert_list(100, :user)

      sorted_names = for(u <- User.all(), do: u.name) |> Enum.sort()

      conn = get(conn, ~p"/api/cameras?order_by=name&order=asc")
      assert conn.status == 200

      assert body = json_response(conn, 200)
      assert sorted_names == for(u <- body["users"], do: u["name"])
    end

    test "allows ordering by name (desc)", %{conn: conn} do
      insert_list(100, :user)

      sorted_names = for(u <- User.all(), do: u.name) |> Enum.sort(:desc)

      conn = get(conn, ~p"/api/cameras?order_by=name&order=desc")
      assert conn.status == 200

      assert body = json_response(conn, 200)
      assert sorted_names == for(u <- body["users"], do: u["name"])
    end
  end
end
