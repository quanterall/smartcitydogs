defmodule SmartCityDogs.RescuesTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.Rescues

  describe "rescues" do
    alias SmartCityDogs.Rescues.Rescue

    @valid_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], name: "some name"}
    @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], name: "some updated name"}
    @invalid_attrs %{deleted_at: nil, name: nil}

    def rescue_fixture(attrs \\ %{}) do
      {:ok, rescues} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rescues.create_rescue()

      rescues
    end

    test "list_rescues/0 returns all rescues" do
      rescues = rescue_fixture()
      assert Rescues.list_rescues() == [rescues]
    end

    test "get_rescue!/1 returns the rescue with given id" do
      rescues = rescue_fixture()
      assert Rescues.get_rescue!(rescues.id) == rescues
    end

    test "create_rescue/1 with valid data creates a rescue" do
      assert {:ok, %Rescue{} = rescues} = Rescues.create_rescue(@valid_attrs)
      assert rescues.deleted_at == ~N[2010-04-17 14:00:00.000000]
      assert rescues.name == "some name"
    end

    test "create_rescue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rescues.create_rescue(@invalid_attrs)
    end

    test "update_rescue/2 with valid data updates the rescue" do
      rescues = rescue_fixture()
      assert {:ok, rescues} = Rescues.update_rescue(rescues, @update_attrs)
      assert %Rescue{} = rescues
      assert rescues.deleted_at == ~N[2011-05-18 15:01:01.000000]
      assert rescues.name == "some updated name"
    end

    test "update_rescue/2 with invalid data returns error changeset" do
      rescues = rescue_fixture()
      assert {:error, %Ecto.Changeset{}} = Rescues.update_rescue(rescues, @invalid_attrs)
      assert rescues == Rescues.get_rescue!(rescues.id)
    end

    test "delete_rescue/1 deletes the rescue" do
      rescues = rescue_fixture()
      assert {:ok, %Rescue{}} = Rescues.delete_rescue(rescues)
      assert_raise Ecto.NoResultsError, fn -> Rescues.get_rescue!(rescues.id) end
    end

    test "change_rescue/1 returns a rescue changeset" do
      rescues = rescue_fixture()
      assert %Ecto.Changeset{} = Rescues.change_rescue(rescues)
    end
  end
end
