defmodule SmartCityDogs.SignalsLikes.SignalsLike do
  use Ecto.Schema
  import Ecto.Changeset

<<<<<<< HEAD
=======
  @timestamps_opts [type: :naive_datetime, usec: false]

>>>>>>> bc631faaf8e88bed50caf154fb13d5f2412bfe89
  schema "signals_likes" do
    field(:deleted_at, :naive_datetime)
    field(:like, :integer)
    # field :signals_id, :integer
    # field :users_id, :integer
    belongs_to(:signals, SmartCityDogs.Signals.Signal)
    belongs_to(:users, SmartCityDogs.Users.User)

    timestamps()
  end

  @doc false
  def changeset(signals_like, attrs) do
    signals_like
    |> cast(attrs, [:like, :deleted_at, :signals_id, :users_id])
    |> validate_required([:like, :signals_id, :users_id])
  end
end
