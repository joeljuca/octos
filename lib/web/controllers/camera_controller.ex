defmodule OctosWeb.CameraController do
  use OctosWeb, :controller

  alias Octos.Accounts
  alias Octos.Accounts.User
  alias Octos.Cameras.Camera

  action_fallback OctosWeb.FallbackController

  def index(conn, _params) do
    with {:ok, users} <- Accounts.list_users(),
         users <- put_camera_names(users),
         users <- users |> Enum.map(&User.to_json/1) do
      json(conn, %{users: users})
    end
  end

  defp put_camera_names(users) do
    users
    |> Enum.map(fn user ->
      cameras = user.cameras |> Enum.map(&Camera.put_name/1)
      user |> Map.put(:cameras, cameras)
    end)
  end
end
