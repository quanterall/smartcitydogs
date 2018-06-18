defmodule SmartCityDogsWeb.NewsSchemaControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.News
  alias SmartCityDogs.News.NewsSchema

  @create_attrs %{content: "some content", date: ~N[2010-04-17 14:00:00.000000], deleted_at: ~N[2010-04-17 14:00:00.000000], image_url: "some image_url", keywords: "some keywords", meta: "some meta", short_content: "some short_content", title: "some title"}
  @update_attrs %{content: "some updated content", date: ~N[2011-05-18 15:01:01.000000], deleted_at: ~N[2011-05-18 15:01:01.000000], image_url: "some updated image_url", keywords: "some updated keywords", meta: "some updated meta", short_content: "some updated short_content", title: "some updated title"}
  @invalid_attrs %{content: nil, date: nil, deleted_at: nil, image_url: nil, keywords: nil, meta: nil, short_content: nil, title: nil}

  def fixture(:news_schema) do
    {:ok, news_schema} = News.create_news_schema(@create_attrs)
    news_schema
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all news", %{conn: conn} do
      conn = get conn, news_schema_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create news_schema" do
    test "renders news_schema when data is valid", %{conn: conn} do
      conn = post conn, news_schema_path(conn, :create), news_schema: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, news_schema_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "content" => "some content",
        "date" => ~N[2010-04-17 14:00:00.000000],
        "deleted_at" => ~N[2010-04-17 14:00:00.000000],
        "image_url" => "some image_url",
        "keywords" => "some keywords",
        "meta" => "some meta",
        "short_content" => "some short_content",
        "title" => "some title"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, news_schema_path(conn, :create), news_schema: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update news_schema" do
    setup [:create_news_schema]

    test "renders news_schema when data is valid", %{conn: conn, news_schema: %NewsSchema{id: id} = news_schema} do
      conn = put conn, news_schema_path(conn, :update, news_schema), news_schema: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, news_schema_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "content" => "some updated content",
        "date" => ~N[2011-05-18 15:01:01.000000],
        "deleted_at" => ~N[2011-05-18 15:01:01.000000],
        "image_url" => "some updated image_url",
        "keywords" => "some updated keywords",
        "meta" => "some updated meta",
        "short_content" => "some updated short_content",
        "title" => "some updated title"}
    end

    test "renders errors when data is invalid", %{conn: conn, news_schema: news_schema} do
      conn = put conn, news_schema_path(conn, :update, news_schema), news_schema: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete news_schema" do
    setup [:create_news_schema]

    test "deletes chosen news_schema", %{conn: conn, news_schema: news_schema} do
      conn = delete conn, news_schema_path(conn, :delete, news_schema)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, news_schema_path(conn, :show, news_schema)
      end
    end
  end

  defp create_news_schema(_) do
    news_schema = fixture(:news_schema)
    {:ok, news_schema: news_schema}
  end
end
