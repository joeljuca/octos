defmodule OctosWeb.UserJSON do
  @moduledoc """
  """

  alias Octos.Accounts.User

  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  def show(%{} = user) do
    %{data: data(user)}
  end

  defp data(%User{} = user), do: User.to_json(user)
end
