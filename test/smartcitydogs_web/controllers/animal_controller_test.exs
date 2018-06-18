defmodule SmartCityDogsWeb.AnimalControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.Animals
  alias SmartCityDogs.Animals.Animal

  @create_attrs %{address: "some address", adopted_at: ~N[2010-04-17 14:00:00.000000], chip_number: "some chip_number", deleted_at: ~N[2010-04-17 14:00:00.000000], registered_at: ~N[2010-04-17 14:00:00.000000], sex: "some sex"}
  @update_attrs %{address: "some updated address", adopted_at: ~N[2011-05-18 15:01:01.000000], chip_number: "some updated chip_number", deleted_at: ~N[2011-05-18 15:01:01.000000], registered_at: ~N[2011-05-18 15:01:01.000000], sex: "some updated sex"}
  @invalid_attrs %{address: nil, adopted_at: nil, chip_number: nil, deleted_at: nil, registered_at: nil, sex: nil}

  def fixture(:animal) do
    {:ok, animal} = Animals.create_animal(@create_attrs)
    animal
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all animals", %{conn: conn} do
      conn = get conn, animal_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create animal" do
    test "renders animal when data is valid", %{conn: conn} do
      conn = post conn, animal_path(conn, :create), animal: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, animal_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "address" => "some address",
        "adopted_at" => ~N[2010-04-17 14:00:00.000000],
        "chip_number" => "some chip_number",
        "deleted_at" => ~N[2010-04-17 14:00:00.000000],
        "registered_at" => ~N[2010-04-17 14:00:00.000000],
        "sex" => "some sex"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, animal_path(conn, :create), animal: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update animal" do
    setup [:create_animal]

    test "renders animal when data is valid", %{conn: conn, animal: %Animal{id: id} = animal} do
      conn = put conn, animal_path(conn, :update, animal), animal: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, animal_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "address" => "some updated address",
        "adopted_at" => ~N[2011-05-18 15:01:01.000000],
        "chip_number" => "some updated chip_number",
        "deleted_at" => ~N[2011-05-18 15:01:01.000000],
        "registered_at" => ~N[2011-05-18 15:01:01.000000],
        "sex" => "some updated sex"}
    end

    test "renders errors when data is invalid", %{conn: conn, animal: animal} do
      conn = put conn, animal_path(conn, :update, animal), animal: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete animal" do
    setup [:create_animal]

    test "deletes chosen animal", %{conn: conn, animal: animal} do
      conn = delete conn, animal_path(conn, :delete, animal)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, animal_path(conn, :show, animal)
      end
    end
  end

  defp create_animal(_) do
    animal = fixture(:animal)
    {:ok, animal: animal}
  end
end
