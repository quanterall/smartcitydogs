defmodule SmartcitydogsWeb.ContactControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.DataUsers
  alias Smartcitydogs.Contact

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    contacts = DataUsers.list_contacts()
    render(conn, "index.json", contacts: contacts)
  end

  def create(conn, params) do
    IO.inspect params
    user_params = Map.get(params, "contact")
    topic = Map.get(user_params, "topic")
    text = Map.get(user_params, "text")
    Smartcitydogs.Email.send_unauth_contact_email(topic, text, user_params)
    |> Smartcitydogs.Mailer.deliver_now()
    contactt_params = for {key, val} <- user_params, into: %{}, do: {String.to_atom(key), val}
    render(conn, "show.json", contact: contactt_params)
  end

  def show(conn, %{"id" => id}) do
    contact = DataUsers.get_contact!(id)
    render(conn, "show.json", contact: contact)
  end
end
