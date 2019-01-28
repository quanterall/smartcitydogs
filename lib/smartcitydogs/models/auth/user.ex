defmodule Smartcitydogs.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smartcitydogs.Repo

  import Ecto.Query, warn: false

  alias Smartcitydogs.Guardian
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  @timestamps_opts [type: :utc_datetime, usec: false]
  schema "users" do
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:phone, :string)
    field(:user_type, :string)
    field(:reset_password_token, :string)
    field(:reset_token_sent_at, :naive_datetime)
    field(:agreed_to_terms, :boolean, default: false)
    has_many(:signals, Smartcitydogs.Signal)

    # has_many(:signal_comments, Smartcitydogs.SignalComment)
    #
    # has_many(:contacts, Smartcitydogs.Contact)
    # has_many(:adopts, Smartcitydogs.Adopt)
    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [
      :password,
      :first_name,
      :last_name,
      :email,
      :phone,
      :reset_password_token,
      :reset_token_sent_at,
      :user_type,
      :agreed_to_terms
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :agreed_to_terms,
      :email,
      :phone,
      :user_type
    ])
    |> validate_acceptance(:agreed_to_terms)
    |> cast(attrs, ~w(password)a, [])
    |> validate_length(:password, min: 6, max: 100)
    |> validate_inclusion(:user_type, ["admin", "citizen", "shelter", "police"])
    |> unique_constraint(:email, name: "users_email")
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))

      _ ->
        changeset
    end
  end

  def create(params) do
    %__MODULE__{}
    |> Map.put(:user_type, "citizen")
    |> changeset(params)
    |> Repo.insert()
  end

  def token_sign_in(email, password) do
    case email_password_auth(email, password) do
      {:ok, user} ->
        Guardian.encode_and_sign(user)

      _ ->
        {:error, :unauthorized}
    end
  end

  def email_password_auth(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, user} <- get_by_email(email),
         do: verify_password(password, user)
  end

  def get_by_email(email) when is_binary(email) do
    case Repo.get_by(__MODULE__, email: email) do
      nil ->
        dummy_checkpw()
        {:error, "Login error."}

      user ->
        {:ok, user}
    end
  end

  defp verify_password(password, %__MODULE__{} = user) when is_binary(password) do
    if checkpw(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end
end
