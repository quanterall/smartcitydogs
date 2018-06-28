defmodule Smartcitydogs.SignalsComments do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "signals_comments" do
    field(:comment, :string)
    field(:deleted_at, :naive_datetime)
    belongs_to(:users, Smartcitydogs.User)
    belongs_to(:signals, Smartcitydogs.Signals)

    timestamps()
  end

  @doc false
  def changeset(signals_comments, attrs) do
    signals_comments
    |> cast(attrs, [:comment, :deleted_at, :signals_id, :users_id])
    # , :users_id
    |> validate_required([:comment, :signals_id])
  end
end
