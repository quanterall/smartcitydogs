defmodule SmartCityDogsWeb.ContactView do
  use SmartCityDogsWeb, :view
  alias SmartCityDogsWeb.ContactView

  def render("index.json", %{contacts: contacts}) do
    %{data: render_many(contacts, ContactView, "contact.json")}
  end

  def render("show.json", %{contact: contact}) do
    %{data: render_one(contact, ContactView, "contact.json")}
  end

  def render("contact.json", %{contact: contact}) do
    %{id: contact.id,
      topic: contact.topic,
      text: contact.text}
  end
end
