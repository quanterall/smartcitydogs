defmodule SmartCityDogsWeb.SignalsLikeControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.SignalsLikes
  alias SmartCityDogs.SignalsLikes.SignalsLike

  @create_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], like: 42, signals_id: 42, users_id: 42}
  @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], like: 43, signals_id: 43, users_id: 43}
  @invalid_attrs %{deleted_at: nil, like: nil, signals_id: nil, users_id: nil}

  def fixture(:signals_like) do
    {:ok, signals_like} = SignalsLikes.create_signals_like(@create_attrs)
    signals_like
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all signals_likes", %{conn: conn} do
      conn = get conn, signals_like_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create signals_like" do
    test "renders signals_like when data is valid", %{conn: conn} do
      conn = post conn, signals_like_path(conn, :create), signals_like: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, signals_like_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "deleted_at" => ~N[2010-04-17 14:00:00.000000],
        "like" => 42,
        "signals_id" => 42,
        "users_id" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, signals_like_path(conn, :create), signals_like: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update signals_like" do
    setup [:create_signals_like]

    test "renders signals_like when data is valid", %{conn: conn, signals_like: %SignalsLike{id: id} = signals_like} do
      conn = put conn, signals_like_path(conn, :update, signals_like), signals_like: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, signals_like_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "deleted_at" => ~N[2011-05-18 15:01:01.000000],
        "like" => 43,
        "signals_id" => 43,
        "users_id" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, signals_like: signals_like} do
      conn = put conn, signals_like_path(conn, :update, signals_like), signals_like: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete signals_like" do
    setup [:create_signals_like]

    test "deletes chosen signals_like", %{conn: conn, signals_like: signals_like} do
      conn = delete conn, signals_like_path(conn, :delete, signals_like)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, signals_like_path(conn, :show, signals_like)
      end
    end
  end

  defp create_signals_like(_) do
    signals_like = fixture(:signals_like)
    {:ok, signals_like: signals_like}
  end
end
