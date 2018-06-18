defmodule SmartCityDogs.NewsTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.News

  describe "news" do
    alias SmartCityDogs.News.NewsSchema

    @valid_attrs %{content: "some content", date: ~N[2010-04-17 14:00:00.000000], deleted_at: ~N[2010-04-17 14:00:00.000000], image_url: "some image_url", keywords: "some keywords", meta: "some meta", short_content: "some short_content", title: "some title"}
    @update_attrs %{content: "some updated content", date: ~N[2011-05-18 15:01:01.000000], deleted_at: ~N[2011-05-18 15:01:01.000000], image_url: "some updated image_url", keywords: "some updated keywords", meta: "some updated meta", short_content: "some updated short_content", title: "some updated title"}
    @invalid_attrs %{content: nil, date: nil, deleted_at: nil, image_url: nil, keywords: nil, meta: nil, short_content: nil, title: nil}

    def news_schema_fixture(attrs \\ %{}) do
      {:ok, news_schema} =
        attrs
        |> Enum.into(@valid_attrs)
        |> News.create_news_schema()

      news_schema
    end

    test "list_news/0 returns all news" do
      news_schema = news_schema_fixture()
      assert News.list_news() == [news_schema]
    end

    test "get_news_schema!/1 returns the news_schema with given id" do
      news_schema = news_schema_fixture()
      assert News.get_news_schema!(news_schema.id) == news_schema
    end

    test "create_news_schema/1 with valid data creates a news_schema" do
      assert {:ok, %NewsSchema{} = news_schema} = News.create_news_schema(@valid_attrs)
      assert news_schema.content == "some content"
      assert news_schema.date == ~N[2010-04-17 14:00:00.000000]
      assert news_schema.deleted_at == ~N[2010-04-17 14:00:00.000000]
      assert news_schema.image_url == "some image_url"
      assert news_schema.keywords == "some keywords"
      assert news_schema.meta == "some meta"
      assert news_schema.short_content == "some short_content"
      assert news_schema.title == "some title"
    end

    test "create_news_schema/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = News.create_news_schema(@invalid_attrs)
    end

    test "update_news_schema/2 with valid data updates the news_schema" do
      news_schema = news_schema_fixture()
      assert {:ok, news_schema} = News.update_news_schema(news_schema, @update_attrs)
      assert %NewsSchema{} = news_schema
      assert news_schema.content == "some updated content"
      assert news_schema.date == ~N[2011-05-18 15:01:01.000000]
      assert news_schema.deleted_at == ~N[2011-05-18 15:01:01.000000]
      assert news_schema.image_url == "some updated image_url"
      assert news_schema.keywords == "some updated keywords"
      assert news_schema.meta == "some updated meta"
      assert news_schema.short_content == "some updated short_content"
      assert news_schema.title == "some updated title"
    end

    test "update_news_schema/2 with invalid data returns error changeset" do
      news_schema = news_schema_fixture()
      assert {:error, %Ecto.Changeset{}} = News.update_news_schema(news_schema, @invalid_attrs)
      assert news_schema == News.get_news_schema!(news_schema.id)
    end

    test "delete_news_schema/1 deletes the news_schema" do
      news_schema = news_schema_fixture()
      assert {:ok, %NewsSchema{}} = News.delete_news_schema(news_schema)
      assert_raise Ecto.NoResultsError, fn -> News.get_news_schema!(news_schema.id) end
    end

    test "change_news_schema/1 returns a news_schema changeset" do
      news_schema = news_schema_fixture()
      assert %Ecto.Changeset{} = News.change_news_schema(news_schema)
    end
  end
end
