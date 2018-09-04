defmodule Smartcitydogs.Adopt do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "adopt" do
    belongs_to(:users, Smartcitydogs.User)
    belongs_to(:animals, Smartcitydogs.Animals)
    timestamps()
  end

  def changeset(adopt, attrs \\ %{}) do
    adopt
    |> cast(attrs, [
      :users_id,
      :animals_id
    ])
    |> validate_required([:users_id, :animals_id])
  end
end
