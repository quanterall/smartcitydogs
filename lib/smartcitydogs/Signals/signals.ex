defmodule Smartcitydogs.Signals do
  use Ecto.Schema
  import Ecto.Changeset

  schema "signals" do
    field(:address, :string)
    field(:chip_number, :string)
    field(:deleted_at, :naive_datetime)
    field(:description, :string)
    field(:support_count, :integer)
    field(:title, :string)
    field(:view_count, :integer)
    #field(:signals_types_id, :id)
    #field(:signals_categories_id, :id)
    has_many :signals_comments, Smartcitydogs.SignalsComments
    belongs_to :signals_categories, Smartcitydogs.SignalsCategories
    belongs_to :signals_types, Smartcitydogs.SignalsTypes

    timestamps()
  end

  @doc false
  def changeset(signals, attrs) do
    signals
    |> cast(attrs, [
      :title,
      :view_count,
      :address,
      :support_count,
      :chip_number,
      :description,
      :deleted_at
    ])
    |> validate_required([
      :title,
      :view_count,
      :address,
      :support_count,
      :chip_number,
      :description,
      :deleted_at
    ])
  end
end
