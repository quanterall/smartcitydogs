defmodule SmartCityDogsWeb.SignalControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.Signals
  alias SmartCityDogs.Signals.Signal

  @create_attrs %{address: "some address", chip_number: "some chip_number", deleted_at: ~N[2010-04-17 14:00:00.000000], description: "some description", signals_categories_id: 42, signals_types_id: 42, support_count: 42, title: "some title", users_id: 42, view_count: 42}
  @update_attrs %{address: "some updated address", chip_number: "some updated chip_number", deleted_at: ~N[2011-05-18 15:01:01.000000], description: "some updated description", signals_categories_id: 43, signals_types_id: 43, support_count: 43, title: "some updated title", users_id: 43, view_count: 43}
  @invalid_attrs %{address: nil, chip_number: nil, deleted_at: nil, description: nil, signals_categories_id: nil, signals_types_id: nil, support_count: nil, title: nil, users_id: nil, view_count: nil}

  def fixture(:signal) do
    {:ok, signal} = Signals.create_signal(@create_attrs)
    signal
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all signals", %{conn: conn} do
      conn = get conn, signal_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create signal" do
    test "renders signal when data is valid", %{conn: conn} do
      conn = post conn, signal_path(conn, :create), signal: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, signal_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "address" => "some address",
        "chip_number" => "some chip_number",
        "deleted_at" => ~N[2010-04-17 14:00:00.000000],
        "description" => "some description",
        "signals_categories_id" => 42,
        "signals_types_id" => 42,
        "support_count" => 42,
        "title" => "some title",
        "users_id" => 42,
        "view_count" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, signal_path(conn, :create), signal: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update signal" do
    setup [:create_signal]

    test "renders signal when data is valid", %{conn: conn, signal: %Signal{id: id} = signal} do
      conn = put conn, signal_path(conn, :update, signal), signal: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, signal_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "address" => "some updated address",
        "chip_number" => "some updated chip_number",
        "deleted_at" => ~N[2011-05-18 15:01:01.000000],
        "description" => "some updated description",
        "signals_categories_id" => 43,
        "signals_types_id" => 43,
        "support_count" => 43,
        "title" => "some updated title",
        "users_id" => 43,
        "view_count" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, signal: signal} do
      conn = put conn, signal_path(conn, :update, signal), signal: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete signal" do
    setup [:create_signal]

    test "deletes chosen signal", %{conn: conn, signal: signal} do
      conn = delete conn, signal_path(conn, :delete, signal)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, signal_path(conn, :show, signal)
      end
    end
  end

  defp create_signal(_) do
    signal = fixture(:signal)
    {:ok, signal: signal}
  end
end
