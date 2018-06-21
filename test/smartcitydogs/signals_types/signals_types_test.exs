defmodule SmartCityDogs.SignalsTypesTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.SignalsTypes

  describe "signals_types" do
    alias SmartCityDogs.SignalsTypes.SignalsType

    @valid_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], name: "some name"}
    @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], name: "some updated name"}
    @invalid_attrs %{deleted_at: nil, name: nil}

    def signals_type_fixture(attrs \\ %{}) do
      {:ok, signals_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> SignalsTypes.create_signals_type()

      signals_type
    end

    test "list_signals_types/0 returns all signals_types" do
      signals_type = signals_type_fixture()
      assert SignalsTypes.list_signals_types() == [signals_type]
    end

    test "get_signals_type!/1 returns the signals_type with given id" do
      signals_type = signals_type_fixture()
      assert SignalsTypes.get_signals_type!(signals_type.id) == signals_type
    end

    test "create_signals_type/1 with valid data creates a signals_type" do
      assert {:ok, %SignalsType{} = signals_type} = SignalsTypes.create_signals_type(@valid_attrs)
      assert signals_type.deleted_at == ~N[2010-04-17 14:00:00.000000]
      assert signals_type.name == "some name"
    end

    test "create_signals_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SignalsTypes.create_signals_type(@invalid_attrs)
    end

    test "update_signals_type/2 with valid data updates the signals_type" do
      signals_type = signals_type_fixture()
      assert {:ok, signals_type} = SignalsTypes.update_signals_type(signals_type, @update_attrs)
      assert %SignalsType{} = signals_type
      assert signals_type.deleted_at == ~N[2011-05-18 15:01:01.000000]
      assert signals_type.name == "some updated name"
    end

    test "update_signals_type/2 with invalid data returns error changeset" do
      signals_type = signals_type_fixture()

      assert {:error, %Ecto.Changeset{}} =
               SignalsTypes.update_signals_type(signals_type, @invalid_attrs)

      assert signals_type == SignalsTypes.get_signals_type!(signals_type.id)
    end

    test "delete_signals_type/1 deletes the signals_type" do
      signals_type = signals_type_fixture()
      assert {:ok, %SignalsType{}} = SignalsTypes.delete_signals_type(signals_type)
      assert_raise Ecto.NoResultsError, fn -> SignalsTypes.get_signals_type!(signals_type.id) end
    end

    test "change_signals_type/1 returns a signals_type changeset" do
      signals_type = signals_type_fixture()
      assert %Ecto.Changeset{} = SignalsTypes.change_signals_type(signals_type)
    end
  end
end
