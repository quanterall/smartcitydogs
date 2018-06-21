defmodule SmartCityDogs.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :naive_datetime, usec: false]

  schema "users" do
    field(:deleted_at, :naive_datetime)
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:password_hash, :string)
    field(:phone, :string)
    field(:reset_password_token, :string)
    field(:reset_password_token_sent_at, :naive_datetime)
    field(:username, :string)
    # field :users_types_id, :integer
    # yes
    has_many(:signals, SmartCityDogs.Signals.Signal)
    # yes
    has_many(:signals_likes, SmartCityDogs.SignalsLikes.SignalsLike)
    # yes
    has_many(:signals_comments, SmartCityDogs.SignalsComments.SignalsComment)
    # has_many :signals_likes, SmartCityDogs.SignalsLikes.SignalsLike   #yes
    # yes
    has_many(:contacts, SmartCityDogs.Contacts.Contact)
    # yes
    belongs_to(:users_types, SmartCityDogs.UsersTypes.UsersType)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :username,
      :password_hash,
      :first_name,
      :last_name,
      :email,
      :phone,
      :reset_password_token,
      :reset_password_token_sent_at,
      :deleted_at,
      :users_types_id
    ])
    |> validate_required([
      :username,
      :password_hash,
      :first_name,
      :last_name,
      :email,
      :phone,
      :users_types_id
    ])
  end
end
