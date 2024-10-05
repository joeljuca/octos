defmodule OctosWeb.CameraControllerTest do
  use OctosWeb.ConnCase
  import Octos.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET /api/cameras" do
    setup do
      users = insert_list(3, :user)
      for u <- users, do: insert_list(3, :camera, user_id: u.id)

      on_exit(fn ->
        for m <- [Octos.Accounts.User, Octos.Cameras.Camera], do: Octos.Repo.delete_all(m)
      end)

      :ok
    end

    test "lists users with their cameras", %{conn: conn} do
      conn = get(conn, ~p"/api/cameras")
      assert conn.status == 200

      assert body = json_response(conn, 200)
      assert is_list(body["users"])

      Enum.each(body["users"], fn user ->
        assert is_integer(user["id"])
        assert is_binary(user["name"])
        assert is_binary(user["email"])

        assert is_list(user["cameras"])

        Enum.each(user["cameras"], fn camera ->
          assert is_integer(camera["id"])
          assert is_binary(camera["brand"])
          assert is_binary(camera["model"])
          assert is_binary(camera["name"])
        end)
      end)
    end
  end
end
