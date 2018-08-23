defmodule Smartcitydogs.SignalsLikes do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :naive_datetime, usec: false]

  schema "signals_likes" do
    field(:deleted_at, :naive_datetime)
    belongs_to(:signals, Smartcitydogs.Signals)
    belongs_to(:users, Smartcitydogs.User)
    timestamps()
  end

  @doc false
  def changeset(signals_like, attrs) do
    signals_like
    |> cast(attrs, [ :deleted_at, :signals_id, :users_id])
    |> validate_required([:signals_id, :users_id])
    |> unique_constraint(:users_signals_unique_like,name: :users_signals_unique_like)
  end
end
