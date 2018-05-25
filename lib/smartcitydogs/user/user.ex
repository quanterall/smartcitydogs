defmodule Smartcitydogs.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:deleted_at, :naive_datetime)
    field(:email, :string)
    field(:fist_name, :string)
    field(:last_name, :string)
    field :password, :string, virtual: true
    field(:password_hash, :string)
    field(:phone, :string)
    field(:username, :string)

    has_many :signals_comments, Smartcitydogs.SignalsComments
    belongs_to :users_types, Smartcitydogs.UsersType

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :username,
      :password_hash,
      :fist_name,
      :last_name,
      :email,
      :phone,
      :deleted_at,
      :users_types_id
    ])
    |> validate_required([
      :username,
      :password_hash,
      :fist_name,
      :last_name,
      :email,
      :phone,
      :users_types_id
    ])
  end
end
