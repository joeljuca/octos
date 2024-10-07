defmodule OctosWeb.UserController do
  use OctosWeb, :controller
  alias Octos.Accounts

  action_fallback OctosWeb.FallbackController

  def notify_users(conn, params) do
    with params <- params |> Map.take(["notification"]),
         :ok <- Accounts.notify_users(params) do
      send_resp(conn)
    end
  end
end
