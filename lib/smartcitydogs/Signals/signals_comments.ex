defmodule Smartcitydogs.SignalsComments do
  use Ecto.Schema
  import Ecto.Changeset

  schema "signals_comments" do
    field(:comment, :string)
    field(:deleted_at, :naive_datetime)
    # field(:signals_id, :id)
    # field(:users_id, :id)
    belongs_to(:users, Smartcitydogs.User)
    belongs_to(:signals, Smartcitydogs.Signals)

    timestamps()
  end

  @doc false
  def changeset(signals_comments, attrs) do
    signals_comments
    |> cast(attrs, [:comment, :deleted_at, :signals_id, :users_id])
    |> validate_required([:comment, :signals_id]) #, :users_id
  end
end
