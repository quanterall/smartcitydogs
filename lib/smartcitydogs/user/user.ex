defmodule Smartcitydogs.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:deleted_at, :naive_datetime)
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:password_hash, :string)
    field(:phone, :string)
    field(:username, :string)
    field(:users_types_id, :id)

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
      :deleted_at
    ])
    |> validate_required([
      :username,
      :password_hash,
      :first_name,
      :last_name,
      :email,
      :phone,
      :deleted_at
    ])
  end
end
