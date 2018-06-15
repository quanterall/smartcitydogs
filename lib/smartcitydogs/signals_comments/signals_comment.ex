defmodule SmartCityDogs.SignalsComments.SignalsComment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "signals_comments" do
    field :comment, :string
    field :deleted_at, :naive_datetime
    field :signals_id, :integer
    field :users_id, :integer

    timestamps()
  end

  @doc false
  def changeset(signals_comment, attrs) do
    signals_comment
    |> cast(attrs, [:comment, :deleted_at, :signals_id, :users_id])
    |> validate_required([:comment, :deleted_at, :signals_id, :users_id])
  end
end
