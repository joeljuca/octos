# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Octos.Repo.insert!(%Octos.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

import Octos.Factory
alias Octos.Accounts
alias Octos.Cameras

gen_user = fn ->
  date = DateTime.now!("Etc/UTC") |> DateTime.truncate(:second)

  params_for(:user)
  |> Map.put(:inserted_at, date)
  |> Map.put(:updated_at, date)
end

gen_camera = fn %{user_id: user_id} ->
  date = DateTime.now!("Etc/UTC") |> DateTime.truncate(:second)

  params_for(:camera, user_id: user_id)
  |> Map.put(:inserted_at, date)
  |> Map.put(:updated_at, date)
end

gen_users = fn qty -> 1..qty |> Enum.map(fn _ -> gen_user.() end) end

gen_cameras = fn uid, qty -> 1..qty |> Enum.map(fn _ -> gen_camera.(%{user_id: uid}) end) end

# Gen 1K users
users =
  gen_users.(1000)
  |> Accounts.User.insert_all(returning: true)
  |> elem(1)

# Gen 50K cams (50 per user)
cameras =
  users
  |> Enum.flat_map(fn user -> gen_cameras.(user.id, 50) end)
  |> Enum.chunk_every(500)
  |> Enum.map(&(Cameras.Camera.insert_all(&1, returning: true) |> elem(1)))
  |> List.flatten()

IO.puts("#{Enum.count(users)} users generated.")
IO.puts("#{Enum.count(cameras)} cameras generated.")
