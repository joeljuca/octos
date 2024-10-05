defmodule OctosWeb.CameraController do
  use OctosWeb, :controller

  alias Octos.Accounts
  alias Octos.Accounts.User

  action_fallback OctosWeb.FallbackController

  def index(conn, _params) do
    with {:ok, users} <- Accounts.list_users(),
         users <- users |> Enum.map(&User.to_json/1) do
      json(conn, %{users: users})
    end
  end
end
