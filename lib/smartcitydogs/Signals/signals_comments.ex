defmodule Smartcitydogs.SignalsComments do
  use Ecto.Schema
  import Ecto.Changeset


  schema "signals_comments" do
    field :comment, :string
    field :deleted_at, :naive_datetime
    field :signals_id, :id
    field :users_id, :id

    timestamps()
  end

  @doc false
  def changeset(signals_comments, attrs) do
    signals_comments
    |> cast(attrs, [:comment, :deleted_at])
    |> validate_required([:comment, :deleted_at])
  end
end
