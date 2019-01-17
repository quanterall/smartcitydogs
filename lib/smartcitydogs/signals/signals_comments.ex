defmodule Smartcitydogs.SignalComment do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "signal_comments" do
    field(:comment, :string)
    field(:deleted_at, :naive_datetime)
    field(:likes_number, :integer, default: 0)
    belongs_to(:user, Smartcitydogs.User)
    belongs_to(:signal, Smartcitydogs.Signal)

    timestamps()
  end

  @doc false
  def changeset(signal_comments, attrs) do
    signal_comments
    |> cast(attrs, [:comment, :deleted_at, :likes_number, :signal_id, :user_id])
    |> validate_required([:comment, :signal_id])
  end
end
