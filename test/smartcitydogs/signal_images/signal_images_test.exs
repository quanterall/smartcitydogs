defmodule SmartCityDogs.SignalImagesTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.SignalImages

  describe "signal_images" do
    alias SmartCityDogs.SignalImages.SignalImage

    @valid_attrs %{signals_id: 42, url: "some url"}
    @update_attrs %{signals_id: 43, url: "some updated url"}
    @invalid_attrs %{signals_id: nil, url: nil}

    def signal_image_fixture(attrs \\ %{}) do
      {:ok, signal_image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> SignalImages.create_signal_image()

      signal_image
    end

    test "list_signal_images/0 returns all signal_images" do
      signal_image = signal_image_fixture()
      assert SignalImages.list_signal_images() == [signal_image]
    end

    test "get_signal_image!/1 returns the signal_image with given id" do
      signal_image = signal_image_fixture()
      assert SignalImages.get_signal_image!(signal_image.id) == signal_image
    end

    test "create_signal_image/1 with valid data creates a signal_image" do
      assert {:ok, %SignalImage{} = signal_image} = SignalImages.create_signal_image(@valid_attrs)
      assert signal_image.signals_id == 42
      assert signal_image.url == "some url"
    end

    test "create_signal_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SignalImages.create_signal_image(@invalid_attrs)
    end

    test "update_signal_image/2 with valid data updates the signal_image" do
      signal_image = signal_image_fixture()
      assert {:ok, signal_image} = SignalImages.update_signal_image(signal_image, @update_attrs)
      assert %SignalImage{} = signal_image
      assert signal_image.signals_id == 43
      assert signal_image.url == "some updated url"
    end

    test "update_signal_image/2 with invalid data returns error changeset" do
      signal_image = signal_image_fixture()

      assert {:error, %Ecto.Changeset{}} =
               SignalImages.update_signal_image(signal_image, @invalid_attrs)

      assert signal_image == SignalImages.get_signal_image!(signal_image.id)
    end

    test "delete_signal_image/1 deletes the signal_image" do
      signal_image = signal_image_fixture()
      assert {:ok, %SignalImage{}} = SignalImages.delete_signal_image(signal_image)
      assert_raise Ecto.NoResultsError, fn -> SignalImages.get_signal_image!(signal_image.id) end
    end

    test "change_signal_image/1 returns a signal_image changeset" do
      signal_image = signal_image_fixture()
      assert %Ecto.Changeset{} = SignalImages.change_signal_image(signal_image)
    end
  end
end
