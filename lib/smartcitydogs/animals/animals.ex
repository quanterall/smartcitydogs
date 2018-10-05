defmodule Smartcitydogs.Animals do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Smartcitydogs.{DataAnimals, Animals, AnimalImages, Repo}

  @required_fields [:sex, :chip_number, :address]
  @fields [
            :address_B,
            :address_F,
            :description,
            :deleted_at,
            :animals_status_id
          ] ++ @required_fields

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
    has_many(:TXHashAnimals, Smartcitydogs.TXHashAnimals, on_delete: :delete_all)

    timestamps()
  end

  @doc false
  def changeset(animals, attrs \\ %{}) do
    animals
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
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

  def animal_to_string_for_blockchain_tx(id) do
    DataAnimals.get_animal(id)
    |> Map.take(@fields)
    |> Poison.encode!()
  end
end
