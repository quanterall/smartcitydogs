defmodule Smartcitydogs.Adopt do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smartcitydogs.{Repo, Animal, User}
  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "adopt" do
    belongs_to(:user, User)
    belongs_to(:animal, Animal)
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

  def exist(%Animal{id: animal_id}, %User{id: user_id}) do
    Repo.get_by(__MODULE__, animal_id: animal_id, user_id: user_id) != nil
  end

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end
end
