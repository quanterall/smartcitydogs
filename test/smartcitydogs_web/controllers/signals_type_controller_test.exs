defmodule SmartCityDogsWeb.SignalsTypeControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.SignalsTypes
  alias SmartCityDogs.SignalsTypes.SignalsType

  @create_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], name: "some name"}
  @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], name: "some updated name"}
  @invalid_attrs %{deleted_at: nil, name: nil}

  def fixture(:signals_type) do
    {:ok, signals_type} = SignalsTypes.create_signals_type(@create_attrs)
    signals_type
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all signals_types", %{conn: conn} do
      conn = get(conn, signals_type_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create signals_type" do
    test "renders signals_type when data is valid", %{conn: conn} do
      conn = post(conn, signals_type_path(conn, :create), signals_type: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, signals_type_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "deleted_at" => ~N[2010-04-17 14:00:00.000000],
               "name" => "some name"
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, signals_type_path(conn, :create), signals_type: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update signals_type" do
    setup [:create_signals_type]

    test "renders signals_type when data is valid", %{
      conn: conn,
      signals_type: %SignalsType{id: id} = signals_type
    } do
      conn =
        put(conn, signals_type_path(conn, :update, signals_type), signals_type: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, signals_type_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "deleted_at" => ~N[2011-05-18 15:01:01.000000],
               "name" => "some updated name"
             }
    end

    test "renders errors when data is invalid", %{conn: conn, signals_type: signals_type} do
      conn =
        put(conn, signals_type_path(conn, :update, signals_type), signals_type: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete signals_type" do
    setup [:create_signals_type]

    test "deletes chosen signals_type", %{conn: conn, signals_type: signals_type} do
      conn = delete(conn, signals_type_path(conn, :delete, signals_type))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, signals_type_path(conn, :show, signals_type))
      end)
    end
  end

  defp create_signals_type(_) do
    signals_type = fixture(:signals_type)
    {:ok, signals_type: signals_type}
  end
end
