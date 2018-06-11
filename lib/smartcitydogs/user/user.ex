defmodule Smartcitydogs.User do
  use Ecto.Schema
  import Ecto.Changeset

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
    # checkbox(form, :famous)

    has_many(:signals_comments, Smartcitydogs.SignalsComments)
    belongs_to(:users_types, Smartcitydogs.UsersType)
    has_many(:signals, Smartcitydogs.Signals)

    timestamps()

    embeds_many :contact, Contact, on_replace: :delete do
      field :topic, :string
      field :text,  :string
    end


  end

  @required_fields ~w(email)a
  @optional_fields ~w(name is_admin)a

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
      :users_types_id
    ])
    |> cast_embed(:contact, with: &contact_changeset/2)
    |> validate_required([
      :username,
      :first_name,
      :last_name,
      :email,
      :phone,
      :users_types_id
    ])
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, ~w(password)a, [])
    |> validate_length(:password, min: 6, max: 100)
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

  def password_token_changeset(struct, params) do
    IO.inspect(struct)
  end

  defp contact_changeset(schema, params) do
    schema
    |> cast(params, [:topic, :text])
  end

end
