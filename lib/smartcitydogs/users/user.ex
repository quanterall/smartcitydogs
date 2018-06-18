defmodule SmartCityDogs.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :contact_id, :integer
    field :deleted_at, :naive_datetime
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :phone, :string
    field :reset_password_token, :string
    field :reset_password_token_sent_at, :naive_datetime
    field :username, :string
    #field :users_types_id, :integer
    has_many :signals_likes , SmartCityDogs.SignalsLikes.SignalsLike
    has_many :signals_comments , SmartCityDogs.SignalsComments.SignalsComment
    belongs_to :signals_types, SmartCityDogs.SignalsTypes.SignalsTypes
    belongs_to :contacts, SmartCityDogs.Contacts.Contact
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password_hash, :first_name, :last_name, :email, :phone, :reset_password_token, :reset_password_token_sent_at, :deleted_at, :contact_id, :users_types_id])
    |> validate_required([:username, :password_hash, :first_name, :last_name, :email, :phone, :reset_password_token, :reset_password_token_sent_at, :deleted_at, :contact_id, :users_types_id])
  end
end
