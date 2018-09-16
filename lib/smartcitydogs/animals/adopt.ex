defmodule Smartcitydogs.Adopt do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Smartcitydogs.{Adopt, Repo}
  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "adopt" do
    belongs_to(:users, Smartcitydogs.User)
    belongs_to(:animals, Smartcitydogs.Animals)
    timestamps()
  end

  def changeset(adopt, attrs \\ %{}) do
    adopt
    |> cast(
      attrs,
      [
        :users_id,
        :animals_id
      ]
    )
    |> validate_required([:users_id, :animals_id])
  end

  def adopt_exist(animal, user) do
    adopt =
      Adopt
      |> where([p], p.animals_id == ^animal.id)
      |> where([p], p.users_id == ^user.id)
      |> Repo.all()

    if adopt == [] do
      true
    else
      false
    end
  end
end
