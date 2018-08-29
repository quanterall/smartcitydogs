defmodule Smartcitydogs.DataUsers do
  import Ecto.Query, warn: false
  alias Smartcitydogs.Repo

  alias Smartcitydogs.User
  alias Smartcitydogs.UsersType
  alias Smartcitydogs.Contact


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
    
    user = Repo.get!(User, id)
    
    changeset = Ecto.Changeset.change(user)
    
    changeset = Ecto.Changeset.put_embed(changeset, :contact, args)
    
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

  def add_like(user_id, signal_id) do
    %Smartcitydogs.SignalsLikes{}
    |> Smartcitydogs.SignalsLikes.changeset(%{users_id: user_id,signals_id: signal_id})
    |> Repo.insert()
  end

  def remove_like(user_id, signal_id) do
    from(l in Smartcitydogs.SignalsLikes, where: l.users_id == ^user_id and l.signals_id == ^signal_id )
|> Repo.delete_all

  end

  def get_likes(signal_id) do
    Repo.one(from l in Smartcitydogs.SignalsLikes,select: count(l.id), where: l.signals_id == ^signal_id )
  end

  def add_liked_signal_comment(user_id, comment_id) do
    user = Repo.get!(User, user_id)
    
    User.changeset(user, %{liked_comments: user.liked_comments ++ [comment_id]})
    |> Repo.update()
  end

  def add_disliked_signal_comment(user_id, comment_id) do
    user = Repo.get!(User, user_id)
    User.changeset(user, %{disliked_comments: user.disliked_comments ++ [comment_id]})
    |> Repo.update()
  end

  def remove_liked_signal_comment(user_id, comment_id) do
    user = Repo.get!(User, user_id)
    User.changeset(user, %{liked_comments: user.liked_comments -- [comment_id]})
    |> Repo.update()
  end

  def remove_disliked_signal_comment(user_id, comment_id) do
    user = Repo.get!(User, user_id)
    User.changeset(user, %{disliked_comments: user.disliked_comments -- [comment_id]})
    |> Repo.update()
  end

  # Users types functions

  def list_users_types do
    Repo.all(UsersType)
  end

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
    |> UsersType.changeset(args)
    |> Repo.update()
  end

  def delete_user_type(%UsersType{} = users_type) do
    Repo.delete(users_type)
  end

  def change_user_type(%UsersType{} = users_type) do
    UsersType.changeset(users_type, %{})
  end

  # Contact functions
  def list_contacts do
    Repo.all(Contact)
  end

  def get_contact!(id), do: Repo.get!(Contact, id)

  def create_contact(attrs \\ %{}) do
    %Contact{}
    |> Contact.changeset(attrs)
    |> Repo.insert()
  end

  def delete_contact(%Contact{} = contact) do
    Repo.delete(contact)
  end

  def change_contact(%Contact{} = contact) do
    Contact.changeset(contact, %{})
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
