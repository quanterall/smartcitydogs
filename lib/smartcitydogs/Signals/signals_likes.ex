defmodule Smartcitydogs.SignalsLikes do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :naive_datetime, usec: false]

  schema "signals_likes" do
    field(:deleted_at, :naive_datetime)
    field(:like, :integer)
    belongs_to(:signals, Smartcitydogs.Signals)
    belongs_to(:users, Smartcitydogs.User)

    timestamps()
  end

  @doc false
  def changeset(signals_like, attrs) do
    signals_like
    |> cast(attrs, [:like, :deleted_at, :signals_id, :users_id])
    |> validate_required([:like, :signals_id, :users_id])
  end
end
