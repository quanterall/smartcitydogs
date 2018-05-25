defmodule Smartcitydogs.DataUsers do
  import Ecto.Query, warn: false
  alias Smartcitydogs.Repo

  alias Smartcitydogs.User
  alias Smartcitydogs.UsersType

  import Plug.Conn

  def list_users do
    Repo.all(User)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def create_user(args \\ %{}) do
    unless Repo.get_by(User, username: args[:username]) do
      %User{}
      |> User.changeset(args)
      |> Repo.insert()
    end
  end

  def update_user(%User{} = user, args) do
    user
    |> User.changeset(args)
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
end
