defmodule SmartCityDogs.UsersTypesTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.UsersTypes

  describe "users_types" do
    alias SmartCityDogs.UsersTypes.UsersType

    @valid_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], name: "some name"}
    @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], name: "some updated name"}
    @invalid_attrs %{deleted_at: nil, name: nil}

    def users_type_fixture(attrs \\ %{}) do
      {:ok, users_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UsersTypes.create_users_type()

      users_type
    end

    test "list_users_types/0 returns all users_types" do
      users_type = users_type_fixture()
      assert UsersTypes.list_users_types() == [users_type]
    end

    test "get_users_type!/1 returns the users_type with given id" do
      users_type = users_type_fixture()
      assert UsersTypes.get_users_type!(users_type.id) == users_type
    end

    test "create_users_type/1 with valid data creates a users_type" do
      assert {:ok, %UsersType{} = users_type} = UsersTypes.create_users_type(@valid_attrs)
      assert users_type.deleted_at == ~N[2010-04-17 14:00:00.000000]
      assert users_type.name == "some name"
    end

    test "create_users_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UsersTypes.create_users_type(@invalid_attrs)
    end

    test "update_users_type/2 with valid data updates the users_type" do
      users_type = users_type_fixture()
      assert {:ok, users_type} = UsersTypes.update_users_type(users_type, @update_attrs)
      assert %UsersType{} = users_type
      assert users_type.deleted_at == ~N[2011-05-18 15:01:01.000000]
      assert users_type.name == "some updated name"
    end

    test "update_users_type/2 with invalid data returns error changeset" do
      users_type = users_type_fixture()

      assert {:error, %Ecto.Changeset{}} =
               UsersTypes.update_users_type(users_type, @invalid_attrs)

      assert users_type == UsersTypes.get_users_type!(users_type.id)
    end

    test "delete_users_type/1 deletes the users_type" do
      users_type = users_type_fixture()
      assert {:ok, %UsersType{}} = UsersTypes.delete_users_type(users_type)
      assert_raise Ecto.NoResultsError, fn -> UsersTypes.get_users_type!(users_type.id) end
    end

    test "change_users_type/1 returns a users_type changeset" do
      users_type = users_type_fixture()
      assert %Ecto.Changeset{} = UsersTypes.change_users_type(users_type)
    end
  end
end
