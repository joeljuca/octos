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
    user_id =
      case Map.get(params, :user_id) do
        user_id when not is_nil(user_id) -> user_id
        _ -> insert(:user).id
      end

    %Octos.Cameras.Camera{
      user_id: user_id,
      brand: Octos.Cameras.Camera.brands() |> Enum.random(),
      model: "#{Faker.Lorem.word() |> String.upcase()}#{1..9 |> Enum.random()}",
      name: "#{Faker.Cat.name()}",
      status: [true, false] |> Enum.random()
    }
  end

  # Misc

  def notification_factory do
    %{
      "title" => Faker.Company.bullshit(),
      "body" => Faker.Lorem.sentence()
    }
  end
end
