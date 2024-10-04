defmodule Octos.Factory do
  use ExMachina.Ecto, repo: Octos.Repo

  # Accounts ctx

  def user_factory do
    %Octos.Accounts.User{
      name: Faker.Person.name(),
      email: Faker.Internet.free_email()
    }
  end

  # Cameras ctx

  def camera_factory(params) do
    user_id = Map.get(params, :user_id, insert(:user).id)

    %Octos.Cameras.Camera{
      user_id: user_id,
      brand: Octos.Cameras.Camera.brands() |> Enum.random(),
      model: "#{Faker.Cat.name()}#{1..9 |> Enum.random()}",
      status: [true, false] |> Enum.random()
    }
  end
end
