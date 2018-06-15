defmodule SmartCityDogs.Signals.Signal do
  use Ecto.Schema
  import Ecto.Changeset


  schema "signals" do
    field :address, :string
    field :chip_number, :string
    field :deleted_at, :naive_datetime
    field :description, :string
    field :signals_categories_id, :integer
    field :signals_types_id, :integer
    field :support_count, :integer
    field :title, :string
    field :users_id, :integer
    field :view_count, :integer

    timestamps()
  end

  @doc false
  def changeset(signal, attrs) do
    signal
    |> cast(attrs, [:title, :view_count, :address, :support_count, :chip_number, :description, :deleted_at, :signals_types_id, :signals_categories_id, :users_id])
    |> validate_required([:title, :view_count, :address, :support_count, :chip_number, :description, :deleted_at, :signals_types_id, :signals_categories_id, :users_id])
  end
end
