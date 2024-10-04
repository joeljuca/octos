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
    field :name, :string, virtual: true
    field :status, :boolean, default: true

    timestamps(type: :utc_datetime)
  end

  @spec changeset(struct :: t(), params :: %{optional(atom()) => term()}) ::
          Ecto.Changeset.t()
  def changeset(camera, attrs) do
    camera
    |> cast(attrs, [:user_id, :brand, :model, :status])
    |> validate_required([:user_id, :brand, :model, :status])
    |> validate_inclusion(:brand, @brands)
    |> validate_length(:model, min: 1)
  end

  @spec brands() ::
          list(atom())
  def brands, do: @brands

  @spec compute_name(struct :: t()) ::
          String.t()
  def compute_name(%{__struct__: __MODULE__} = camera) do
    "##{camera.id} (#{camera.brand} #{camera.model})"
  end

  @spec compute_name(struct :: t()) ::
          t()
  def put_name(%{__struct__: __MODULE__} = camera) do
    %{camera | name: compute_name(camera)}
  end
end
