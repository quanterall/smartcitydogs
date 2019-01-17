defmodule Smartcitydogs.SignalsLikes do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :naive_datetime, usec: false]

  schema "signal_likes" do
    field(:deleted_at, :naive_datetime)
    belongs_to(:signal, Smartcitydogs.Signals)
    belongs_to(:user, Smartcitydogs.User)
    timestamps()
  end

  @doc false
  def changeset(signals_like, attrs) do
    signals_like
    |> cast(attrs, [:deleted_at, :signal_id, :user_id])
    |> validate_required([:signal_id, :user_id])
    |> unique_constraint(:users_signals_unique_like, name: :users_signals_unique_like)
  end
end
