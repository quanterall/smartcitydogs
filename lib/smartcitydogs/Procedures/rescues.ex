defmodule Smartcitydogs.Rescues do
  use Ecto.Schema
  import Ecto.Changeset


  schema "rescues" do
    field :deleted_at, :naive_datetime
    field :name, :string
    field :animals_id, :id

    timestamps()
  end

  @doc false
  def changeset(rescues, attrs) do
    rescues
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name, :deleted_at])
  end
end
