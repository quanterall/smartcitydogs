defmodule SmartCityDogs.UsersTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.Users

  describe "users" do
    alias SmartCityDogs.Users.User

    @valid_attrs %{ deleted_at: ~N[2010-04-17 14:00:00.000000], email: "some email", first_name: "some first_name", last_name: "some last_name", password_hash: "some password_hash", phone: "some phone", reset_password_token: "some reset_password_token", reset_password_token_sent_at: ~N[2010-04-17 14:00:00.000000], username: "some username", users_types_id: 42}
    @update_attrs %{ deleted_at: ~N[2011-05-18 15:01:01.000000], email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", password_hash: "some updated password_hash", phone: "some updated phone", reset_password_token: "some updated reset_password_token", reset_password_token_sent_at: ~N[2011-05-18 15:01:01.000000], username: "some updated username", users_types_id: 43}
    @invalid_attrs %{ deleted_at: nil, email: nil, first_name: nil, last_name: nil, password_hash: nil, phone: nil, reset_password_token: nil, reset_password_token_sent_at: nil, username: nil, users_types_id: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.deleted_at == ~N[2010-04-17 14:00:00.000000]
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.password_hash == "some password_hash"
      assert user.phone == "some phone"
      assert user.reset_password_token == "some reset_password_token"
      assert user.reset_password_token_sent_at == ~N[2010-04-17 14:00:00.000000]
      assert user.username == "some username"
      assert user.users_types_id == 42
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Users.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.deleted_at == ~N[2011-05-18 15:01:01.000000]
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.password_hash == "some updated password_hash"
      assert user.phone == "some updated phone"
      assert user.reset_password_token == "some updated reset_password_token"
      assert user.reset_password_token_sent_at == ~N[2011-05-18 15:01:01.000000]
      assert user.username == "some updated username"
      assert user.users_types_id == 43
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
