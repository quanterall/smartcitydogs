defmodule Smartcitydogs.User do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "users" do
    field(:deleted_at, :naive_datetime)
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:phone, :string)
    field(:username, :string)
    field(:reset_password_token, :string)
    field(:reset_token_sent_at, :naive_datetime)
    field(:liked_signals, {:array, :integer}, default: [])
    field(:liked_comments, {:array, :integer}, default: [])
    field(:disliked_comments, {:array, :integer}, default: [])
    field(:agreed_to_terms, :boolean, default: [], virtual: true)

    has_many(:signal_comments, Smartcitydogs.SignalComment)
    belongs_to(:user_type, Smartcitydogs.UserType)
    has_many(:signals, Smartcitydogs.Signal)
    has_many(:contacts, Smartcitydogs.Contact)
    has_many(:adopts, Smartcitydogs.Adopt)
    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [
      :username,
      :password_hash,
      :first_name,
      :last_name,
      :email,
      :phone,
      :reset_password_token,
      :reset_token_sent_at,
      :deleted_at,
      :user_type_id,
      :liked_signals,
      :liked_comments,
      :disliked_comments,
      :agreed_to_terms
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :agreed_to_terms,
      :email,
      :phone
    ])
    |> validate_acceptance(:agreed_to_terms)
    |> cast(attrs, ~w(password)a, [])
    |> validate_length(:password, min: 6, max: 100)
    |> unique_constraint(:email, name: "users_email")
    |> hash_password
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(
          changeset,
          :password_hash,
          Comeonin.Bcrypt.hashpwsalt(password)
        )

      _ ->
        changeset
    end
  end
end
