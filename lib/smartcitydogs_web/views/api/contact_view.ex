defmodule SmartcitydogsWeb.ContactControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.ContactControllerAPIView

  def render("index.json", %{contacts: contacts}) do
    %{data: render_many(contacts, ContactControllerAPIView, "contact.json")}
  end

  def render("show.json", %{contact: contact}) do
    %{data: render_one(contact, ContactControllerAPIView, "contact.json")}
  end

  def render("contact.json", %{contact_controller_api: contact}) do
    %{id: contact.id, topic: contact.topic, text: contact.text}
  end
end
