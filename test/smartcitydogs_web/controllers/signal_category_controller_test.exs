defmodule SmartCityDogsWeb.SignalCategoryControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.SignalsCategories
  alias SmartCityDogs.SignalsCategories.SignalCategory

  @create_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], name: "some name"}
  @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], name: "some updated name"}
  @invalid_attrs %{deleted_at: nil, name: nil}

  def fixture(:signal_category) do
    {:ok, signal_category} = SignalsCategories.create_signal_category(@create_attrs)
    signal_category
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all signals_categories", %{conn: conn} do
      conn = get(conn, signal_category_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create signal_category" do
    test "renders signal_category when data is valid", %{conn: conn} do
      conn = post(conn, signal_category_path(conn, :create), signal_category: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, signal_category_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "deleted_at" => ~N[2010-04-17 14:00:00.000000],
               "name" => "some name"
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, signal_category_path(conn, :create), signal_category: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update signal_category" do
    setup [:create_signal_category]

    test "renders signal_category when data is valid", %{
      conn: conn,
      signal_category: %SignalCategory{id: id} = signal_category
    } do
      conn =
        put(
          conn,
          signal_category_path(conn, :update, signal_category),
          signal_category: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, signal_category_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "deleted_at" => ~N[2011-05-18 15:01:01.000000],
               "name" => "some updated name"
             }
    end

    test "renders errors when data is invalid", %{conn: conn, signal_category: signal_category} do
      conn =
        put(
          conn,
          signal_category_path(conn, :update, signal_category),
          signal_category: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete signal_category" do
    setup [:create_signal_category]

    test "deletes chosen signal_category", %{conn: conn, signal_category: signal_category} do
      conn = delete(conn, signal_category_path(conn, :delete, signal_category))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, signal_category_path(conn, :show, signal_category))
      end)
    end
  end

  defp create_signal_category(_) do
    signal_category = fixture(:signal_category)
    {:ok, signal_category: signal_category}
  end
end
