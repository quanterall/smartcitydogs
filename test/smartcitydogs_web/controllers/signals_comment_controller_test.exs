defmodule SmartCityDogsWeb.SignalsCommentControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.SignalsComments
  alias SmartCityDogs.SignalsComments.SignalsComment

  @create_attrs %{comment: "some comment", deleted_at: ~N[2010-04-17 14:00:00.000000], signals_id: 42, users_id: 42}
  @update_attrs %{comment: "some updated comment", deleted_at: ~N[2011-05-18 15:01:01.000000], signals_id: 43, users_id: 43}
  @invalid_attrs %{comment: nil, deleted_at: nil, signals_id: nil, users_id: nil}

  def fixture(:signals_comment) do
    {:ok, signals_comment} = SignalsComments.create_signals_comment(@create_attrs)
    signals_comment
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all signals_comments", %{conn: conn} do
      conn = get conn, signals_comment_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create signals_comment" do
    test "renders signals_comment when data is valid", %{conn: conn} do
      conn = post conn, signals_comment_path(conn, :create), signals_comment: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, signals_comment_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "comment" => "some comment",
        "deleted_at" => ~N[2010-04-17 14:00:00.000000],
        "signals_id" => 42,
        "users_id" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, signals_comment_path(conn, :create), signals_comment: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update signals_comment" do
    setup [:create_signals_comment]

    test "renders signals_comment when data is valid", %{conn: conn, signals_comment: %SignalsComment{id: id} = signals_comment} do
      conn = put conn, signals_comment_path(conn, :update, signals_comment), signals_comment: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, signals_comment_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "comment" => "some updated comment",
        "deleted_at" => ~N[2011-05-18 15:01:01.000000],
        "signals_id" => 43,
        "users_id" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, signals_comment: signals_comment} do
      conn = put conn, signals_comment_path(conn, :update, signals_comment), signals_comment: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete signals_comment" do
    setup [:create_signals_comment]

    test "deletes chosen signals_comment", %{conn: conn, signals_comment: signals_comment} do
      conn = delete conn, signals_comment_path(conn, :delete, signals_comment)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, signals_comment_path(conn, :show, signals_comment)
      end
    end
  end

  defp create_signals_comment(_) do
    signals_comment = fixture(:signals_comment)
    {:ok, signals_comment: signals_comment}
  end
end
