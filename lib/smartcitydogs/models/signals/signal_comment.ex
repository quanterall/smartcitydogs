defmodule Smartcitydogs.SignalComment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smartcitydogs.Repo

  @timestamps_opts [type: :utc_datetime, usec: true]

  schema "signal_comments" do
    field(:comment, :string)
    belongs_to(:user, Smartcitydogs.User)
    belongs_to(:signal, Smartcitydogs.Signal)

    timestamps()
  end

  @doc false
  def changeset(signal_comments, attrs) do
    signal_comments
    |> cast(attrs, [:comment, :signal_id, :user_id])
    |> validate_required([:comment, :signal_id])
  end

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end
end
