defmodule SmartCityDogs.Contacts do
  @moduledoc """
  The Contacts context.
  """

  import Ecto.Query, warn: false
  alias SmartCityDogs.Repo

  alias SmartCityDogs.Contacts.Contact
  alias SmartCityDogs.Email
  def list_contacts do
    Repo.all(Contact)
  end


  def get_contact!(id), do: Repo.get!(Contact, id)


  def create_contact(attrs \\ %{}) do
    %Contact{}
    |> Contact.changeset(attrs)
    |> Repo.insert()
    topic = Map.get(attrs,"topic")
    text = Map.get(attrs, "text")
    Email.send_unauth_contact_email(topic, text, attrs)
    |> SmartCityDogs.Mailer.deliver_now()
  end

  ##def update_contact(%Contact{} = contact, attrs) do
  ##  contact
  ##  |> Contact.changeset(attrs)
  ##  |> Repo.update()
  ##end


  def delete_contact(%Contact{} = contact) do
    Repo.delete(contact)
  end


  def change_contact(%Contact{} = contact) do
    Contact.changeset(contact, %{})
  end
end
