defmodule SmartCityDogsWeb.AnimalImageControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.AnimalImages
  alias SmartCityDogs.AnimalImages.AnimalImage

  @create_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], url: "some url"}
  @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], url: "some updated url"}
  @invalid_attrs %{deleted_at: nil, url: nil}

  def fixture(:animal_image) do
    {:ok, animal_image} = AnimalImages.create_animal_image(@create_attrs)
    animal_image
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all animal_images", %{conn: conn} do
      conn = get conn, animal_image_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create animal_image" do
    test "renders animal_image when data is valid", %{conn: conn} do
      conn = post conn, animal_image_path(conn, :create), animal_image: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, animal_image_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "deleted_at" => ~N[2010-04-17 14:00:00.000000],
        "url" => "some url"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, animal_image_path(conn, :create), animal_image: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update animal_image" do
    setup [:create_animal_image]

    test "renders animal_image when data is valid", %{conn: conn, animal_image: %AnimalImage{id: id} = animal_image} do
      conn = put conn, animal_image_path(conn, :update, animal_image), animal_image: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, animal_image_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "deleted_at" => ~N[2011-05-18 15:01:01.000000],
        "url" => "some updated url"}
    end

    test "renders errors when data is invalid", %{conn: conn, animal_image: animal_image} do
      conn = put conn, animal_image_path(conn, :update, animal_image), animal_image: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete animal_image" do
    setup [:create_animal_image]

    test "deletes chosen animal_image", %{conn: conn, animal_image: animal_image} do
      conn = delete conn, animal_image_path(conn, :delete, animal_image)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, animal_image_path(conn, :show, animal_image)
      end
    end
  end

  defp create_animal_image(_) do
    animal_image = fixture(:animal_image)
    {:ok, animal_image: animal_image}
  end
end
