defmodule OctosWeb.CameraController do
  use OctosWeb, :controller

  alias Octos.Accounts
  alias Octos.Accounts.User

  action_fallback OctosWeb.FallbackController

  def index(conn, params) do
    with params <- params |> Map.take(["order_by", "order"]),
         {:ok, users} <- Accounts.list_users(params),
         users <- users |> Enum.map(&User.to_json/1) do
      json(conn, %{users: users})
    end
  end
end
