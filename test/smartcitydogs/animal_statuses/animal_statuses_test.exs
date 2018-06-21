defmodule SmartCityDogs.AnimalStatusesTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.AnimalStatuses

  describe "animal_statuses" do
    alias SmartCityDogs.AnimalStatuses.AnimalStatus

    @valid_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], name: "some name"}
    @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], name: "some updated name"}
    @invalid_attrs %{deleted_at: nil, name: nil}

    def animal_status_fixture(attrs \\ %{}) do
      {:ok, animal_status} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AnimalStatuses.create_animal_status()

      animal_status
    end

    test "list_animal_statuses/0 returns all animal_statuses" do
      animal_status = animal_status_fixture()
      assert AnimalStatuses.list_animal_statuses() == [animal_status]
    end

    test "get_animal_status!/1 returns the animal_status with given id" do
      animal_status = animal_status_fixture()
      assert AnimalStatuses.get_animal_status!(animal_status.id) == animal_status
    end

    test "create_animal_status/1 with valid data creates a animal_status" do
      assert {:ok, %AnimalStatus{} = animal_status} =
               AnimalStatuses.create_animal_status(@valid_attrs)

      assert animal_status.deleted_at == ~N[2010-04-17 14:00:00.000000]
      assert animal_status.name == "some name"
    end

    test "create_animal_status/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AnimalStatuses.create_animal_status(@invalid_attrs)
    end

    test "update_animal_status/2 with valid data updates the animal_status" do
      animal_status = animal_status_fixture()

      assert {:ok, animal_status} =
               AnimalStatuses.update_animal_status(animal_status, @update_attrs)

      assert %AnimalStatus{} = animal_status
      assert animal_status.deleted_at == ~N[2011-05-18 15:01:01.000000]
      assert animal_status.name == "some updated name"
    end

    test "update_animal_status/2 with invalid data returns error changeset" do
      animal_status = animal_status_fixture()

      assert {:error, %Ecto.Changeset{}} =
               AnimalStatuses.update_animal_status(animal_status, @invalid_attrs)

      assert animal_status == AnimalStatuses.get_animal_status!(animal_status.id)
    end

    test "delete_animal_status/1 deletes the animal_status" do
      animal_status = animal_status_fixture()
      assert {:ok, %AnimalStatus{}} = AnimalStatuses.delete_animal_status(animal_status)

      assert_raise Ecto.NoResultsError, fn ->
        AnimalStatuses.get_animal_status!(animal_status.id)
      end
    end

    test "change_animal_status/1 returns a animal_status changeset" do
      animal_status = animal_status_fixture()
      assert %Ecto.Changeset{} = AnimalStatuses.change_animal_status(animal_status)
    end
  end
end
