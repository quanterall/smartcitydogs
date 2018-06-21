defmodule SmartCityDogsWeb.ProcedureTypeControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.ProcedureTypes
  alias SmartCityDogs.ProcedureTypes.ProcedureType

  @create_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], name: "some name"}
  @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], name: "some updated name"}
  @invalid_attrs %{deleted_at: nil, name: nil}

  def fixture(:procedure_type) do
    {:ok, procedure_type} = ProcedureTypes.create_procedure_type(@create_attrs)
    procedure_type
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all procedure_types", %{conn: conn} do
      conn = get(conn, procedure_type_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create procedure_type" do
    test "renders procedure_type when data is valid", %{conn: conn} do
      conn = post(conn, procedure_type_path(conn, :create), procedure_type: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, procedure_type_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "deleted_at" => ~N[2010-04-17 14:00:00.000000],
               "name" => "some name"
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, procedure_type_path(conn, :create), procedure_type: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update procedure_type" do
    setup [:create_procedure_type]

    test "renders procedure_type when data is valid", %{
      conn: conn,
      procedure_type: %ProcedureType{id: id} = procedure_type
    } do
      conn =
        put(
          conn,
          procedure_type_path(conn, :update, procedure_type),
          procedure_type: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, procedure_type_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "deleted_at" => ~N[2011-05-18 15:01:01.000000],
               "name" => "some updated name"
             }
    end

    test "renders errors when data is invalid", %{conn: conn, procedure_type: procedure_type} do
      conn =
        put(
          conn,
          procedure_type_path(conn, :update, procedure_type),
          procedure_type: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete procedure_type" do
    setup [:create_procedure_type]

    test "deletes chosen procedure_type", %{conn: conn, procedure_type: procedure_type} do
      conn = delete(conn, procedure_type_path(conn, :delete, procedure_type))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, procedure_type_path(conn, :show, procedure_type))
      end)
    end
  end

  defp create_procedure_type(_) do
    procedure_type = fixture(:procedure_type)
    {:ok, procedure_type: procedure_type}
  end
end
