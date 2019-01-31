defmodule Smartcitydogs.SignalLike do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smartcitydogs.Repo
  @timestamps_opts [type: :utc_datetime, usec: true]
  schema "signal_likes" do
    belongs_to(:signal, Smartcitydogs.Signal)
    belongs_to(:user, Smartcitydogs.User)
    timestamps()
  end

  @doc false
  def changeset(signal_like, attrs) do
    signal_like
    |> cast(attrs, [:signal_id, :user_id])
    |> validate_required([:signal_id, :user_id])
    |> unique_constraint(:users_signal_unique_like, name: :users_signal_unique_like)
  end

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end

  def delete(like_id) do
    get(like_id)
    |> Repo.delete()
  end

  def get(like_id) do
    Repo.get!(__MODULE__, like_id)
  end
end
