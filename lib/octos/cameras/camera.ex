defmodule Octos.Cameras.Camera do
  use Ecto.Schema
  use SwissSchema, repo: Octos.Repo
  import Ecto.Changeset
  alias Octos.Accounts

  @type brand :: :intelbras | :giga | :hikvision | :vivotek
  @brands [:intelbras, :hikvision, :giga, :vivotek]

  @type t :: %{
          __struct__: __MODULE__,
          user_id: integer(),
          brand: brand(),
          model: String.t(),
          name: String.t(),
          status: boolean()
        }

  schema "camera" do
    belongs_to :user, Accounts.User

    field :brand, Ecto.Enum, values: @brands
    field :model, :string
    field :name, :string
    field :status, :boolean, default: true

    timestamps(type: :utc_datetime)
  end

  @spec changeset(struct :: t(), params :: %{optional(atom()) => term()}) ::
          Ecto.Changeset.t()
  def changeset(camera, attrs) do
    camera
    |> cast(attrs, [:user_id, :brand, :model, :name, :status])
    |> validate_required([:user_id, :brand, :model, :name, :status])
    |> validate_inclusion(:brand, @brands)
    |> validate_length(:model, min: 1)
  end

  @spec brands() ::
          list(atom())
  def brands, do: @brands

  @spec to_json(struct :: t()) ::
          map()
  def to_json(%{__struct__: __MODULE__} = struct) do
    struct |> Map.take([:id, :brand, :model, :name, :status])
  end
end
