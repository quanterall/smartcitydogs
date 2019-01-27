defmodule Smartcitydogs.SignalCategory do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smartcitydogs.Repo
  @timestamps_opts [type: :utc_datetime, usec: true]
  schema "signal_categories" do
    field(:name, :string)
    field(:prefix, :string)
    has_many(:signals, Smartcitydogs.Signal)

    timestamps()
  end

  @doc false
  def changeset(signal_category, attrs) do
    signal_category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end
end
