defmodule SmartcitydogsWeb.ContactControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.DataUsers
  alias Smartcitydogs.Contact

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    contacts = DataUsers.list_contacts()
    render(conn, "index.json", contacts: contacts)
  end

  def create(conn, %{"contact" => contact_params}) do
    id = contact_params["id"]
    topic =  contact_params["topic"]
    text = contact_params["text"]
    IO.inspect text
    if id != "" do
      user_sender = Smartcitydogs.DataUsers.get_user!(id)
      user_email = Map.get(user_sender, :email)
      Smartcitydogs.Email.send_contact_email(user_sender, contact_params)
      |> Smartcitydogs.Mailer.deliver_now()
    else
      Smartcitydogs.Email.send_unauth_contact_email(topic, text, contact_params)
      |> Smartcitydogs.Mailer.deliver_now()
    end
    contactt_params = for {key, val} <- contact_params, into: %{}, do: {String.to_atom(key), val} 
    render(conn, "show.json", contact: contactt_params)
  end

  def show(conn, %{"id" => id}) do
    contact = DataUsers.get_contact!(id)
    render(conn, "show.json", contact: contact)
  end

end
