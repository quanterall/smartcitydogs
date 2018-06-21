defmodule SmartCityDogsWeb.ContactControllerTest do
  use SmartCityDogsWeb.ConnCase

  alias SmartCityDogs.Contacts
  alias SmartCityDogs.Contacts.Contact

  @create_attrs %{text: "some text", topic: "some topic"}
  @update_attrs %{text: "some updated text", topic: "some updated topic"}
  @invalid_attrs %{text: nil, topic: nil}

  def fixture(:contact) do
    {:ok, contact} = Contacts.create_contact(@create_attrs)
    contact
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all contacts", %{conn: conn} do
      conn = get(conn, contact_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create contact" do
    test "renders contact when data is valid", %{conn: conn} do
      conn = post(conn, contact_path(conn, :create), contact: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, contact_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "text" => "some text",
               "topic" => "some topic"
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, contact_path(conn, :create), contact: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update contact" do
    setup [:create_contact]

    test "renders contact when data is valid", %{conn: conn, contact: %Contact{id: id} = contact} do
      conn = put(conn, contact_path(conn, :update, contact), contact: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, contact_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "text" => "some updated text",
               "topic" => "some updated topic"
             }
    end

    test "renders errors when data is invalid", %{conn: conn, contact: contact} do
      conn = put(conn, contact_path(conn, :update, contact), contact: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete contact" do
    setup [:create_contact]

    test "deletes chosen contact", %{conn: conn, contact: contact} do
      conn = delete(conn, contact_path(conn, :delete, contact))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, contact_path(conn, :show, contact))
      end)
    end
  end

  defp create_contact(_) do
    contact = fixture(:contact)
    {:ok, contact: contact}
  end
end
