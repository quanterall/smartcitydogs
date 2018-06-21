defmodule SmartCityDogsWeb.HeaderSlideControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.HeaderSlides
  alias SmartCityDogs.HeaderSlides.HeaderSlide

  @create_attrs %{
    deleted_at: ~N[2010-04-17 14:00:00.000000],
    image_url: "some image_url",
    text: "some text"
  }
  @update_attrs %{
    deleted_at: ~N[2011-05-18 15:01:01.000000],
    image_url: "some updated image_url",
    text: "some updated text"
  }
  @invalid_attrs %{deleted_at: nil, image_url: nil, text: nil}

  def fixture(:header_slide) do
    {:ok, header_slide} = HeaderSlides.create_header_slide(@create_attrs)
    header_slide
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all header_slides", %{conn: conn} do
      conn = get(conn, header_slide_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create header_slide" do
    test "renders header_slide when data is valid", %{conn: conn} do
      conn = post(conn, header_slide_path(conn, :create), header_slide: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, header_slide_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "deleted_at" => ~N[2010-04-17 14:00:00.000000],
               "image_url" => "some image_url",
               "text" => "some text"
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, header_slide_path(conn, :create), header_slide: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update header_slide" do
    setup [:create_header_slide]

    test "renders header_slide when data is valid", %{
      conn: conn,
      header_slide: %HeaderSlide{id: id} = header_slide
    } do
      conn =
        put(conn, header_slide_path(conn, :update, header_slide), header_slide: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, header_slide_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "deleted_at" => ~N[2011-05-18 15:01:01.000000],
               "image_url" => "some updated image_url",
               "text" => "some updated text"
             }
    end

    test "renders errors when data is invalid", %{conn: conn, header_slide: header_slide} do
      conn =
        put(conn, header_slide_path(conn, :update, header_slide), header_slide: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete header_slide" do
    setup [:create_header_slide]

    test "deletes chosen header_slide", %{conn: conn, header_slide: header_slide} do
      conn = delete(conn, header_slide_path(conn, :delete, header_slide))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, header_slide_path(conn, :show, header_slide))
      end)
    end
  end

  defp create_header_slide(_) do
    header_slide = fixture(:header_slide)
    {:ok, header_slide: header_slide}
  end
end
