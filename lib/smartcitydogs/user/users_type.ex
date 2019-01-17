defmodule Smartcitydogs.UsersType do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "user_types" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)
    field(:prefix, :string)
    has_many(:users, Smartcitydogs.User)

    timestamps()
  end

  @doc false
  def changeset(users_type, attrs) do
    users_type
    |> cast(attrs, [:name, :prefix, :deleted_at])
    |> validate_required([:name])
  end
end
