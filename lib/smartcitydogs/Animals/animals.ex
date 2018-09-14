defmodule Smartcitydogs.Animals do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Smartcitydogs.{DataAnimals, Animals, AnimalImages, Repo}

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "animals" do
    field(:address, :string)
    field(:address_B, :float)
    field(:address_F, :float)
    field(:description, :string)
    field(:chip_number, :string)
    field(:deleted_at, :naive_datetime)
    field(:sex, :string)
    has_many(:animals_image, Smartcitydogs.AnimalImages, on_delete: :delete_all)
    has_many(:performed_procedure, Smartcitydogs.PerformedProcedures, on_delete: :delete_all)
    has_many(:rescues, Smartcitydogs.Rescues, on_delete: :delete_all)
    belongs_to(:animals_status, Smartcitydogs.AnimalStatus)
    has_many(:adopt, Smartcitydogs.Adopt, on_delete: :delete_all)

    timestamps()
  end

  @doc false
  def changeset(animals, attrs \\ %{}) do
    animals
    |> cast(attrs, [
      :address_B,
      :address_F,
      :description,
      :sex,
      :chip_number,
      :address,
      :deleted_at,
      :animals_status_id
    ])
    |> validate_required([:sex, :chip_number, :address])
  end

  ###### Send E-mail ########

  def adopt(animal, user) do
    DataAnimals.insert_adopt(user.id, animal.id)
    Smartcitydogs.Email.send_adopt_email(animal, user)
  end

  def create_animal(args \\ %{}) do
    %Animals{}
    |> Animals.changeset(args)
    |> Repo.insert()
  end
end
