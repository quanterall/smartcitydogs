defmodule Smartcitydogs.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :naive_datetime, usec: false]

  schema "contacts" do
    field(:text, :string)
    field(:topic, :string)
    belongs_to(:users, Smartcitydogs.User)

    timestamps()
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:topic, :text, :users_id])
    |> validate_required([:topic, :text])
  end
end