defmodule Octos.Accounts.User do
  use Ecto.Schema
  use SwissSchema, repo: Octos.Repo
  import Ecto.Changeset
  alias Octos.Cameras.Camera

  @type t :: %{
          __struct__: __MODULE__,
          name: String.t(),
          email: String.t(),
          cameras: list(Camera.t())
        }

  schema "user" do
    field :name, :string
    field :email, :string, redact: true

    has_many :cameras, Camera

    timestamps(type: :utc_datetime)
  end

  @spec changeset(struct :: t(), params :: %{optional(atom()) => term()}) ::
          Ecto.Changeset.t()
  def changeset(%{__struct__: __MODULE__} = struct, params) do
    struct
    |> cast(params, [:name, :email])
    |> validate_required([:name, :email])
    |> validate_length(:name, min: 2)
    |> validate_format(:email, ~r/^\w[\w-.+]*@[a-z0-9]+(?:\.[a-z0-9-]+)+$/i)
  end

  @spec to_json(struct :: t()) ::
          map()
  def to_json(%{__struct__: __MODULE__} = struct) do
    cameras =
      case Map.get(struct, :cameras) do
        cameras when is_list(cameras) -> cameras |> Enum.map(&Camera.to_json/1)
        cameras -> cameras
      end

    struct
    |> Map.put(:cameras, cameras)
    |> Map.take([:id, :name, :email, :cameras])
  end
end
