defmodule Smartcitydogs.DataUsers do
  import Ecto.Query, warn: false
  alias Smartcitydogs.Repo

  alias Smartcitydogs.User
  alias Smartcitydogs.UsersType

  import Plug.Conn

  def list_users do
    Repo.all(User) |> Repo.preload(:users_types)
  end

  def get_user!(id) do
    Repo.get!(User, id) |> Repo.preload(:users_types)
  end

  def get_user_by_email!(email) do
    Repo.get_by(User, email: email)
  end

  def create_user(args \\ %{}) do
    %User{}
    |> User.changeset(args)
    |> Repo.insert()
  end

  def create_user_contact(id, args) do
    ##  IO.inspect args
    user = Repo.get!(User, id)
    ##  IO.inspect user
    changeset = Ecto.Changeset.change(user)
    ##   IO.inspect changeset
    changeset = Ecto.Changeset.put_embed(changeset, :contact, args)
    ##  IO.inspect changeset
    Repo.update!(changeset).contact
    Repo.get!(User, id)
  end

  # todo: some users don't have phone
  def create_user_from_auth(auth) do
    create_user(%{
      username: auth.info.email,
      password_hash: "pass",
      first_name: String.split(auth.info.name, " ") |> List.first(),
      last_name: String.split(auth.info.name, " ") |> List.first(),
      email: auth.info.email,
      phone: "0000000000000",
      users_types_id: 1
    })
  end

  def update_user(%User{} = user, args) do
    user
    |> User.registration_changeset(args)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  # Users types functions
  def create_user_type(args \\ %{}) do
    %UsersType{}
    |> UsersType.changeset(args)
    |> Repo.insert()
  end

  def get_user_type(id) do
    Repo.get!(UsersType, id)
  end

  def update_users_type(%UsersType{} = users_type, args) do
    users_type
    |> User.changeset(args)
    |> Repo.update()
  end

  def delete_user_type(%UsersType{} = users_type) do
    Repo.delete(users_type)
  end

  def change_user_type(%UsersType{} = users_type) do
    UsersType.changeset(users_type, %{})
  end



  def authenticate_user(email, password) do
    query = from(u in User, where: u.email == ^email)
    query |> Repo.one() |> verify_password(password)
  end

  defp verify_password(nil, _) do
    # Perform a dummy check to make user enumeration more difficult
    Bcrypt.no_user_verify()
    {:error, "Wrong email or password"}
  end

  defp verify_password(user, password) do
    if Bcrypt.verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, "Wrong email or password"}
    end
  end
end
