defmodule SmartCityDogs.HeaderSlidesTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.HeaderSlides

  describe "header_slides" do
    alias SmartCityDogs.HeaderSlides.HeaderSlide

    @valid_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], image_url: "some image_url", text: "some text"}
    @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], image_url: "some updated image_url", text: "some updated text"}
    @invalid_attrs %{deleted_at: nil, image_url: nil, text: nil}

    def header_slide_fixture(attrs \\ %{}) do
      {:ok, header_slide} =
        attrs
        |> Enum.into(@valid_attrs)
        |> HeaderSlides.create_header_slide()

      header_slide
    end

    test "list_header_slides/0 returns all header_slides" do
      header_slide = header_slide_fixture()
      assert HeaderSlides.list_header_slides() == [header_slide]
    end

    test "get_header_slide!/1 returns the header_slide with given id" do
      header_slide = header_slide_fixture()
      assert HeaderSlides.get_header_slide!(header_slide.id) == header_slide
    end

    test "create_header_slide/1 with valid data creates a header_slide" do
      assert {:ok, %HeaderSlide{} = header_slide} = HeaderSlides.create_header_slide(@valid_attrs)
      assert header_slide.deleted_at == ~N[2010-04-17 14:00:00.000000]
      assert header_slide.image_url == "some image_url"
      assert header_slide.text == "some text"
    end

    test "create_header_slide/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HeaderSlides.create_header_slide(@invalid_attrs)
    end

    test "update_header_slide/2 with valid data updates the header_slide" do
      header_slide = header_slide_fixture()
      assert {:ok, header_slide} = HeaderSlides.update_header_slide(header_slide, @update_attrs)
      assert %HeaderSlide{} = header_slide
      assert header_slide.deleted_at == ~N[2011-05-18 15:01:01.000000]
      assert header_slide.image_url == "some updated image_url"
      assert header_slide.text == "some updated text"
    end

    test "update_header_slide/2 with invalid data returns error changeset" do
      header_slide = header_slide_fixture()
      assert {:error, %Ecto.Changeset{}} = HeaderSlides.update_header_slide(header_slide, @invalid_attrs)
      assert header_slide == HeaderSlides.get_header_slide!(header_slide.id)
    end

    test "delete_header_slide/1 deletes the header_slide" do
      header_slide = header_slide_fixture()
      assert {:ok, %HeaderSlide{}} = HeaderSlides.delete_header_slide(header_slide)
      assert_raise Ecto.NoResultsError, fn -> HeaderSlides.get_header_slide!(header_slide.id) end
    end

    test "change_header_slide/1 returns a header_slide changeset" do
      header_slide = header_slide_fixture()
      assert %Ecto.Changeset{} = HeaderSlides.change_header_slide(header_slide)
    end
  end
end
