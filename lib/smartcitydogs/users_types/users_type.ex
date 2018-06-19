defmodule SmartCityDogs.UsersTypes.UsersType do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users_types" do
    field :deleted_at, :naive_datetime
    field :name, :string
    has_many :users, SmartCityDogs.Users.User

    timestamps()
  end

  @doc false
  def changeset(users_type, attrs) do
    users_type
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name])
  end
end
