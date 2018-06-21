defmodule SmartCityDogsWeb.SignalImageControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.SignalImages
  alias SmartCityDogs.SignalImages.SignalImage

  @create_attrs %{signals_id: 42, url: "some url"}
  @update_attrs %{signals_id: 43, url: "some updated url"}
  @invalid_attrs %{signals_id: nil, url: nil}

  def fixture(:signal_image) do
    {:ok, signal_image} = SignalImages.create_signal_image(@create_attrs)
    signal_image
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all signal_images", %{conn: conn} do
      conn = get(conn, signal_image_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create signal_image" do
    test "renders signal_image when data is valid", %{conn: conn} do
      conn = post(conn, signal_image_path(conn, :create), signal_image: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, signal_image_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "signals_id" => 42,
               "url" => "some url"
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, signal_image_path(conn, :create), signal_image: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update signal_image" do
    setup [:create_signal_image]

    test "renders signal_image when data is valid", %{
      conn: conn,
      signal_image: %SignalImage{id: id} = signal_image
    } do
      conn =
        put(conn, signal_image_path(conn, :update, signal_image), signal_image: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, signal_image_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "signals_id" => 43,
               "url" => "some updated url"
             }
    end

    test "renders errors when data is invalid", %{conn: conn, signal_image: signal_image} do
      conn =
        put(conn, signal_image_path(conn, :update, signal_image), signal_image: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete signal_image" do
    setup [:create_signal_image]

    test "deletes chosen signal_image", %{conn: conn, signal_image: signal_image} do
      conn = delete(conn, signal_image_path(conn, :delete, signal_image))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, signal_image_path(conn, :show, signal_image))
      end)
    end
  end

  defp create_signal_image(_) do
    signal_image = fixture(:signal_image)
    {:ok, signal_image: signal_image}
  end
end
