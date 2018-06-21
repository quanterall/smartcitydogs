defmodule SmartCityDogsWeb.UsersTypeControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.UsersTypes
  alias SmartCityDogs.UsersTypes.UsersType

  @create_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], name: "some name"}
  @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], name: "some updated name"}
  @invalid_attrs %{deleted_at: nil, name: nil}

  def fixture(:users_type) do
    {:ok, users_type} = UsersTypes.create_users_type(@create_attrs)
    users_type
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users_types", %{conn: conn} do
      conn = get(conn, users_type_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create users_type" do
    test "renders users_type when data is valid", %{conn: conn} do
      conn = post(conn, users_type_path(conn, :create), users_type: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, users_type_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "deleted_at" => ~N[2010-04-17 14:00:00.000000],
               "name" => "some name"
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, users_type_path(conn, :create), users_type: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update users_type" do
    setup [:create_users_type]

    test "renders users_type when data is valid", %{
      conn: conn,
      users_type: %UsersType{id: id} = users_type
    } do
      conn = put(conn, users_type_path(conn, :update, users_type), users_type: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, users_type_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "deleted_at" => ~N[2011-05-18 15:01:01.000000],
               "name" => "some updated name"
             }
    end

    test "renders errors when data is invalid", %{conn: conn, users_type: users_type} do
      conn = put(conn, users_type_path(conn, :update, users_type), users_type: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete users_type" do
    setup [:create_users_type]

    test "deletes chosen users_type", %{conn: conn, users_type: users_type} do
      conn = delete(conn, users_type_path(conn, :delete, users_type))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, users_type_path(conn, :show, users_type))
      end)
    end
  end

  defp create_users_type(_) do
    users_type = fixture(:users_type)
    {:ok, users_type: users_type}
  end
end
