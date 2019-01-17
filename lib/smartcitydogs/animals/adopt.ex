defmodule Smartcitydogs.Adopt do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Smartcitydogs.{Adopt, Repo}
  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "adopt" do
    belongs_to(:user, Smartcitydogs.User)
    belongs_to(:animal, Smartcitydogs.Animals)
    timestamps()
  end

  def changeset(adopt, attrs \\ %{}) do
    adopt
    |> cast(
      attrs,
      [
        :user_id,
        :animal_id
      ]
    )
    |> validate_required([:user_id, :animal_id])
  end

  def adopt_exist(animal, user) do
    adopt =
      Adopt
      |> where([p], p.animal_id == ^animal.id)
      |> where([p], p.user_id == ^user.id)
      |> Repo.all()

    if adopt == [] do
      true
    else
      false
    end
  end
end
