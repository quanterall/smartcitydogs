defmodule SmartCityDogs.RescuesTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.Rescues

  describe "rescues" do
    alias SmartCityDogs.Rescues.Rescue

    @valid_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], name: "some name"}
    @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], name: "some updated name"}
    @invalid_attrs %{deleted_at: nil, name: nil}

    def rescue_fixture(attrs \\ %{}) do
      {:ok, rescue} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rescues.create_rescue()

      rescue
    end

    test "list_rescues/0 returns all rescues" do
      rescue = rescue_fixture()
      assert Rescues.list_rescues() == [rescue]
    end

    test "get_rescue!/1 returns the rescue with given id" do
      rescue = rescue_fixture()
      assert Rescues.get_rescue!(rescue.id) == rescue
    end

    test "create_rescue/1 with valid data creates a rescue" do
      assert {:ok, %Rescue{} = rescue} = Rescues.create_rescue(@valid_attrs)
      assert rescue.deleted_at == ~N[2010-04-17 14:00:00.000000]
      assert rescue.name == "some name"
    end

    test "create_rescue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rescues.create_rescue(@invalid_attrs)
    end

    test "update_rescue/2 with valid data updates the rescue" do
      rescue = rescue_fixture()
      assert {:ok, rescue} = Rescues.update_rescue(rescue, @update_attrs)
      assert %Rescue{} = rescue
      assert rescue.deleted_at == ~N[2011-05-18 15:01:01.000000]
      assert rescue.name == "some updated name"
    end

    test "update_rescue/2 with invalid data returns error changeset" do
      rescue = rescue_fixture()
      assert {:error, %Ecto.Changeset{}} = Rescues.update_rescue(rescue, @invalid_attrs)
      assert rescue == Rescues.get_rescue!(rescue.id)
    end

    test "delete_rescue/1 deletes the rescue" do
      rescue = rescue_fixture()
      assert {:ok, %Rescue{}} = Rescues.delete_rescue(rescue)
      assert_raise Ecto.NoResultsError, fn -> Rescues.get_rescue!(rescue.id) end
    end

    test "change_rescue/1 returns a rescue changeset" do
      rescue = rescue_fixture()
      assert %Ecto.Changeset{} = Rescues.change_rescue(rescue)
    end
  end
end
