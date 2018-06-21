defmodule SmartCityDogsWeb.PerformedProcedureControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.PerformedProcedures
  alias SmartCityDogs.PerformedProcedures.PerformedProcedure

  @create_attrs %{
    date: ~N[2010-04-17 14:00:00.000000],
    deleted_at: ~N[2010-04-17 14:00:00.000000]
  }
  @update_attrs %{
    date: ~N[2011-05-18 15:01:01.000000],
    deleted_at: ~N[2011-05-18 15:01:01.000000]
  }
  @invalid_attrs %{date: nil, deleted_at: nil}

  def fixture(:performed_procedure) do
    {:ok, performed_procedure} = PerformedProcedures.create_performed_procedure(@create_attrs)
    performed_procedure
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all performed_procedure", %{conn: conn} do
      conn = get(conn, performed_procedure_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create performed_procedure" do
    test "renders performed_procedure when data is valid", %{conn: conn} do
      conn =
        post(conn, performed_procedure_path(conn, :create), performed_procedure: @create_attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, performed_procedure_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "date" => ~N[2010-04-17 14:00:00.000000],
               "deleted_at" => ~N[2010-04-17 14:00:00.000000]
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, performed_procedure_path(conn, :create), performed_procedure: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update performed_procedure" do
    setup [:create_performed_procedure]

    test "renders performed_procedure when data is valid", %{
      conn: conn,
      performed_procedure: %PerformedProcedure{id: id} = performed_procedure
    } do
      conn =
        put(
          conn,
          performed_procedure_path(conn, :update, performed_procedure),
          performed_procedure: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, performed_procedure_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "date" => ~N[2011-05-18 15:01:01.000000],
               "deleted_at" => ~N[2011-05-18 15:01:01.000000]
             }
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      performed_procedure: performed_procedure
    } do
      conn =
        put(
          conn,
          performed_procedure_path(conn, :update, performed_procedure),
          performed_procedure: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete performed_procedure" do
    setup [:create_performed_procedure]

    test "deletes chosen performed_procedure", %{
      conn: conn,
      performed_procedure: performed_procedure
    } do
      conn = delete(conn, performed_procedure_path(conn, :delete, performed_procedure))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, performed_procedure_path(conn, :show, performed_procedure))
      end)
    end
  end

  defp create_performed_procedure(_) do
    performed_procedure = fixture(:performed_procedure)
    {:ok, performed_procedure: performed_procedure}
  end
end
