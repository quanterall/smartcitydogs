defmodule SmartCityDogs.AnimalImagesTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.AnimalImages

  describe "animal_images" do
    alias SmartCityDogs.AnimalImages.AnimalImage

    @valid_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], url: "some url"}
    @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], url: "some updated url"}
    @invalid_attrs %{deleted_at: nil, url: nil}

    def animal_image_fixture(attrs \\ %{}) do
      {:ok, animal_image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AnimalImages.create_animal_image()

      animal_image
    end

    test "list_animal_images/0 returns all animal_images" do
      animal_image = animal_image_fixture()
      assert AnimalImages.list_animal_images() == [animal_image]
    end

    test "get_animal_image!/1 returns the animal_image with given id" do
      animal_image = animal_image_fixture()
      assert AnimalImages.get_animal_image!(animal_image.id) == animal_image
    end

    test "create_animal_image/1 with valid data creates a animal_image" do
      assert {:ok, %AnimalImage{} = animal_image} = AnimalImages.create_animal_image(@valid_attrs)
      assert animal_image.deleted_at == ~N[2010-04-17 14:00:00.000000]
      assert animal_image.url == "some url"
    end

    test "create_animal_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AnimalImages.create_animal_image(@invalid_attrs)
    end

    test "update_animal_image/2 with valid data updates the animal_image" do
      animal_image = animal_image_fixture()
      assert {:ok, animal_image} = AnimalImages.update_animal_image(animal_image, @update_attrs)
      assert %AnimalImage{} = animal_image
      assert animal_image.deleted_at == ~N[2011-05-18 15:01:01.000000]
      assert animal_image.url == "some updated url"
    end

    test "update_animal_image/2 with invalid data returns error changeset" do
      animal_image = animal_image_fixture()
      assert {:error, %Ecto.Changeset{}} = AnimalImages.update_animal_image(animal_image, @invalid_attrs)
      assert animal_image == AnimalImages.get_animal_image!(animal_image.id)
    end

    test "delete_animal_image/1 deletes the animal_image" do
      animal_image = animal_image_fixture()
      assert {:ok, %AnimalImage{}} = AnimalImages.delete_animal_image(animal_image)
      assert_raise Ecto.NoResultsError, fn -> AnimalImages.get_animal_image!(animal_image.id) end
    end

    test "change_animal_image/1 returns a animal_image changeset" do
      animal_image = animal_image_fixture()
      assert %Ecto.Changeset{} = AnimalImages.change_animal_image(animal_image)
    end
  end
end
