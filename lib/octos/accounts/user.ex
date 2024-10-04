defmodule Octos.Accounts.User do
  use Ecto.Schema
  use SwissSchema, repo: Octos.Repo
  import Ecto.Changeset

  @type t :: %{
          __struct__: __MODULE__,
          name: String.t(),
          email: String.t()
        }

  schema "user" do
    field :name, :string
    field :email, :string, redact: true

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
end
