defmodule SmartCityDogs.SignalsCategoriesTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.SignalsCategories

  describe "signals_categories" do
    alias SmartCityDogs.SignalsCategories.SignalCategory

    @valid_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], name: "some name"}
    @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], name: "some updated name"}
    @invalid_attrs %{deleted_at: nil, name: nil}

    def signal_category_fixture(attrs \\ %{}) do
      {:ok, signal_category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> SignalsCategories.create_signal_category()

      signal_category
    end

    test "list_signals_categories/0 returns all signals_categories" do
      signal_category = signal_category_fixture()
      assert SignalsCategories.list_signals_categories() == [signal_category]
    end

    test "get_signal_category!/1 returns the signal_category with given id" do
      signal_category = signal_category_fixture()
      assert SignalsCategories.get_signal_category!(signal_category.id) == signal_category
    end

    test "create_signal_category/1 with valid data creates a signal_category" do
      assert {:ok, %SignalCategory{} = signal_category} =
               SignalsCategories.create_signal_category(@valid_attrs)

      assert signal_category.deleted_at == ~N[2010-04-17 14:00:00.000000]
      assert signal_category.name == "some name"
    end

    test "create_signal_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               SignalsCategories.create_signal_category(@invalid_attrs)
    end

    test "update_signal_category/2 with valid data updates the signal_category" do
      signal_category = signal_category_fixture()

      assert {:ok, signal_category} =
               SignalsCategories.update_signal_category(signal_category, @update_attrs)

      assert %SignalCategory{} = signal_category
      assert signal_category.deleted_at == ~N[2011-05-18 15:01:01.000000]
      assert signal_category.name == "some updated name"
    end

    test "update_signal_category/2 with invalid data returns error changeset" do
      signal_category = signal_category_fixture()

      assert {:error, %Ecto.Changeset{}} =
               SignalsCategories.update_signal_category(signal_category, @invalid_attrs)

      assert signal_category == SignalsCategories.get_signal_category!(signal_category.id)
    end

    test "delete_signal_category/1 deletes the signal_category" do
      signal_category = signal_category_fixture()
      assert {:ok, %SignalCategory{}} = SignalsCategories.delete_signal_category(signal_category)

      assert_raise Ecto.NoResultsError, fn ->
        SignalsCategories.get_signal_category!(signal_category.id)
      end
    end

    test "change_signal_category/1 returns a signal_category changeset" do
      signal_category = signal_category_fixture()
      assert %Ecto.Changeset{} = SignalsCategories.change_signal_category(signal_category)
    end
  end
end
