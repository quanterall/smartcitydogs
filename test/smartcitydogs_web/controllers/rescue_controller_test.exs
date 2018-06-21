defmodule SmartCityDogsWeb.RescueControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.Rescues
  alias SmartCityDogs.Rescues.Rescue

  @create_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], name: "some name"}
  @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], name: "some updated name"}
  @invalid_attrs %{deleted_at: nil, name: nil}

  def fixture(:rescue) do
    {:ok, rescues} = Rescues.create_rescue(@create_attrs)
    rescues
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all rescues", %{conn: conn} do
      conn = get(conn, rescue_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create rescue" do
    test "renders rescue when data is valid", %{conn: conn} do
      conn = post(conn, rescue_path(conn, :create), rescue: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, rescue_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "deleted_at" => ~N[2010-04-17 14:00:00.000000],
               "name" => "some name"
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, rescue_path(conn, :create), rescue: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update rescue" do
    setup [:create_rescue]

    test "renders rescue when data is valid", %{conn: conn, rescue: %Rescue{id: id} = rescues} do
      conn = put(conn, rescue_path(conn, :update, rescues), rescue: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, rescue_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "deleted_at" => ~N[2011-05-18 15:01:01.000000],
               "name" => "some updated name"
             }
    end

    test "renders errors when data is invalid", %{conn: conn, rescue: rescues} do
      conn = put(conn, rescue_path(conn, :update, rescues), rescue: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete rescue" do
    setup [:create_rescue]

    test "deletes chosen rescue", %{conn: conn, rescue: rescues} do
      conn = delete(conn, rescue_path(conn, :delete, rescues))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, rescue_path(conn, :show, rescues))
      end)
    end
  end

  defp create_rescue(_) do
    rescues = fixture(:rescue)
    {:ok, rescue: rescues}
  end
end
