defmodule SmartCityDogsWeb.StaticPageControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.StaticPages
  alias SmartCityDogs.StaticPages.StaticPage

  @create_attrs %{content: "some content", deleted_at: ~N[2010-04-17 14:00:00.000000], keywords: "some keywords", meta: "some meta", title: "some title"}
  @update_attrs %{content: "some updated content", deleted_at: ~N[2011-05-18 15:01:01.000000], keywords: "some updated keywords", meta: "some updated meta", title: "some updated title"}
  @invalid_attrs %{content: nil, deleted_at: nil, keywords: nil, meta: nil, title: nil}

  def fixture(:static_page) do
    {:ok, static_page} = StaticPages.create_static_page(@create_attrs)
    static_page
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all static_pages", %{conn: conn} do
      conn = get conn, static_page_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create static_page" do
    test "renders static_page when data is valid", %{conn: conn} do
      conn = post conn, static_page_path(conn, :create), static_page: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, static_page_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "content" => "some content",
        "deleted_at" => ~N[2010-04-17 14:00:00.000000],
        "keywords" => "some keywords",
        "meta" => "some meta",
        "title" => "some title"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, static_page_path(conn, :create), static_page: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update static_page" do
    setup [:create_static_page]

    test "renders static_page when data is valid", %{conn: conn, static_page: %StaticPage{id: id} = static_page} do
      conn = put conn, static_page_path(conn, :update, static_page), static_page: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, static_page_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "content" => "some updated content",
        "deleted_at" => ~N[2011-05-18 15:01:01.000000],
        "keywords" => "some updated keywords",
        "meta" => "some updated meta",
        "title" => "some updated title"}
    end

    test "renders errors when data is invalid", %{conn: conn, static_page: static_page} do
      conn = put conn, static_page_path(conn, :update, static_page), static_page: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete static_page" do
    setup [:create_static_page]

    test "deletes chosen static_page", %{conn: conn, static_page: static_page} do
      conn = delete conn, static_page_path(conn, :delete, static_page)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, static_page_path(conn, :show, static_page)
      end
    end
  end

  defp create_static_page(_) do
    static_page = fixture(:static_page)
    {:ok, static_page: static_page}
  end
end
