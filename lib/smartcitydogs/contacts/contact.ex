defmodule SmartCityDogs.Contacts.Contact do
  use Ecto.Schema
  import Ecto.Changeset


  schema "contacts" do
    field :text, :string
    field :topic, :string
    has_many :signals , SmartCityDogs.Signals.Signal

    timestamps()
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:topic, :text])
    |> validate_required([:topic, :text])
  end
end
