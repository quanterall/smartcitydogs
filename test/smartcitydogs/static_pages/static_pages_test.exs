defmodule SmartCityDogs.StaticPagesTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.StaticPages

  describe "static_pages" do
    alias SmartCityDogs.StaticPages.StaticPage

    @valid_attrs %{content: "some content", deleted_at: ~N[2010-04-17 14:00:00.000000], keywords: "some keywords", meta: "some meta", title: "some title"}
    @update_attrs %{content: "some updated content", deleted_at: ~N[2011-05-18 15:01:01.000000], keywords: "some updated keywords", meta: "some updated meta", title: "some updated title"}
    @invalid_attrs %{content: nil, deleted_at: nil, keywords: nil, meta: nil, title: nil}

    def static_page_fixture(attrs \\ %{}) do
      {:ok, static_page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> StaticPages.create_static_page()

      static_page
    end

    test "list_static_pages/0 returns all static_pages" do
      static_page = static_page_fixture()
      assert StaticPages.list_static_pages() == [static_page]
    end

    test "get_static_page!/1 returns the static_page with given id" do
      static_page = static_page_fixture()
      assert StaticPages.get_static_page!(static_page.id) == static_page
    end

    test "create_static_page/1 with valid data creates a static_page" do
      assert {:ok, %StaticPage{} = static_page} = StaticPages.create_static_page(@valid_attrs)
      assert static_page.content == "some content"
      assert static_page.deleted_at == ~N[2010-04-17 14:00:00.000000]
      assert static_page.keywords == "some keywords"
      assert static_page.meta == "some meta"
      assert static_page.title == "some title"
    end

    test "create_static_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = StaticPages.create_static_page(@invalid_attrs)
    end

    test "update_static_page/2 with valid data updates the static_page" do
      static_page = static_page_fixture()
      assert {:ok, static_page} = StaticPages.update_static_page(static_page, @update_attrs)
      assert %StaticPage{} = static_page
      assert static_page.content == "some updated content"
      assert static_page.deleted_at == ~N[2011-05-18 15:01:01.000000]
      assert static_page.keywords == "some updated keywords"
      assert static_page.meta == "some updated meta"
      assert static_page.title == "some updated title"
    end

    test "update_static_page/2 with invalid data returns error changeset" do
      static_page = static_page_fixture()
      assert {:error, %Ecto.Changeset{}} = StaticPages.update_static_page(static_page, @invalid_attrs)
      assert static_page == StaticPages.get_static_page!(static_page.id)
    end

    test "delete_static_page/1 deletes the static_page" do
      static_page = static_page_fixture()
      assert {:ok, %StaticPage{}} = StaticPages.delete_static_page(static_page)
      assert_raise Ecto.NoResultsError, fn -> StaticPages.get_static_page!(static_page.id) end
    end

    test "change_static_page/1 returns a static_page changeset" do
      static_page = static_page_fixture()
      assert %Ecto.Changeset{} = StaticPages.change_static_page(static_page)
    end
  end
end
