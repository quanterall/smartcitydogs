defmodule SmartCityDogsWeb.AnimalStatusControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.AnimalStatuses
  alias SmartCityDogs.AnimalStatuses.AnimalStatus

  @create_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], name: "some name"}
  @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], name: "some updated name"}
  @invalid_attrs %{deleted_at: nil, name: nil}

  def fixture(:animal_status) do
    {:ok, animal_status} = AnimalStatuses.create_animal_status(@create_attrs)
    animal_status
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all animal_statuses", %{conn: conn} do
      conn = get conn, animal_status_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create animal_status" do
    test "renders animal_status when data is valid", %{conn: conn} do
      conn = post conn, animal_status_path(conn, :create), animal_status: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, animal_status_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "deleted_at" => ~N[2010-04-17 14:00:00.000000],
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, animal_status_path(conn, :create), animal_status: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update animal_status" do
    setup [:create_animal_status]

    test "renders animal_status when data is valid", %{conn: conn, animal_status: %AnimalStatus{id: id} = animal_status} do
      conn = put conn, animal_status_path(conn, :update, animal_status), animal_status: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, animal_status_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "deleted_at" => ~N[2011-05-18 15:01:01.000000],
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, animal_status: animal_status} do
      conn = put conn, animal_status_path(conn, :update, animal_status), animal_status: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete animal_status" do
    setup [:create_animal_status]

    test "deletes chosen animal_status", %{conn: conn, animal_status: animal_status} do
      conn = delete conn, animal_status_path(conn, :delete, animal_status)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, animal_status_path(conn, :show, animal_status)
      end
    end
  end

  defp create_animal_status(_) do
    animal_status = fixture(:animal_status)
    {:ok, animal_status: animal_status}
  end
end
