defmodule Octos.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query
  alias Octos.Accounts
  alias Octos.Cameras
  alias Octos.Repo

  @spec list_users() ::
          {:ok, list(Accounts.User.t())} | {:error, term()}
  def list_users() do
    query =
      from(u in Accounts.User)
      |> join(:left, [u], c in Cameras.Camera, on: u.id == c.user_id)
      |> preload([u], [:cameras])

    {:ok, Repo.all(query)}
  rescue
    error -> {:error, error}
  end
end
