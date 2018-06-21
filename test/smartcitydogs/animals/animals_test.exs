defmodule SmartCityDogs.AnimalsTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.Animals

  describe "animals" do
    alias SmartCityDogs.Animals.Animal

    @valid_attrs %{
      address: "some address",
      adopted_at: ~N[2010-04-17 14:00:00.000000],
      chip_number: "some chip_number",
      deleted_at: ~N[2010-04-17 14:00:00.000000],
      registered_at: ~N[2010-04-17 14:00:00.000000],
      sex: "some sex"
    }
    @update_attrs %{
      address: "some updated address",
      adopted_at: ~N[2011-05-18 15:01:01.000000],
      chip_number: "some updated chip_number",
      deleted_at: ~N[2011-05-18 15:01:01.000000],
      registered_at: ~N[2011-05-18 15:01:01.000000],
      sex: "some updated sex"
    }
    @invalid_attrs %{
      address: nil,
      adopted_at: nil,
      chip_number: nil,
      deleted_at: nil,
      registered_at: nil,
      sex: nil
    }

    def animal_fixture(attrs \\ %{}) do
      {:ok, animal} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Animals.create_animal()

      animal
    end

    test "list_animals/0 returns all animals" do
      animal = animal_fixture()
      assert Animals.list_animals() == [animal]
    end

    test "get_animal!/1 returns the animal with given id" do
      animal = animal_fixture()
      assert Animals.get_animal!(animal.id) == animal
    end

    test "create_animal/1 with valid data creates a animal" do
      assert {:ok, %Animal{} = animal} = Animals.create_animal(@valid_attrs)
      assert animal.address == "some address"
      assert animal.adopted_at == ~N[2010-04-17 14:00:00.000000]
      assert animal.chip_number == "some chip_number"
      assert animal.deleted_at == ~N[2010-04-17 14:00:00.000000]
      assert animal.registered_at == ~N[2010-04-17 14:00:00.000000]
      assert animal.sex == "some sex"
    end

    test "create_animal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Animals.create_animal(@invalid_attrs)
    end

    test "update_animal/2 with valid data updates the animal" do
      animal = animal_fixture()
      assert {:ok, animal} = Animals.update_animal(animal, @update_attrs)
      assert %Animal{} = animal
      assert animal.address == "some updated address"
      assert animal.adopted_at == ~N[2011-05-18 15:01:01.000000]
      assert animal.chip_number == "some updated chip_number"
      assert animal.deleted_at == ~N[2011-05-18 15:01:01.000000]
      assert animal.registered_at == ~N[2011-05-18 15:01:01.000000]
      assert animal.sex == "some updated sex"
    end

    test "update_animal/2 with invalid data returns error changeset" do
      animal = animal_fixture()
      assert {:error, %Ecto.Changeset{}} = Animals.update_animal(animal, @invalid_attrs)
      assert animal == Animals.get_animal!(animal.id)
    end

    test "delete_animal/1 deletes the animal" do
      animal = animal_fixture()
      assert {:ok, %Animal{}} = Animals.delete_animal(animal)
      assert_raise Ecto.NoResultsError, fn -> Animals.get_animal!(animal.id) end
    end

    test "change_animal/1 returns a animal changeset" do
      animal = animal_fixture()
      assert %Ecto.Changeset{} = Animals.change_animal(animal)
    end
  end
end
