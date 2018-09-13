defmodule SmartcitydogsWeb.Municipality.AnimalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.{Animals, Repo, AnimalsFilters, DataAnimals, AnimalImages}
  import Ecto.Query
  alias Smartcitydogs.PerformedProcedures

  def index(conn, params) do
    page =
      Animals
      |> order_by(desc: :inserted_at)
      |> preload([:animals_status])

    page =
      if params["animals_filters"]["animals_status_id"] &&
           params["animals_filters"]["animals_status_id"] != "" do
        page
        |> where(
          [animal],
          animal.animals_status_id == ^params["animals_filters"]["animals_status_id"]
        )
      else
        page
      end
IO.inspect params
    page =
      if params["animals_filters"]["adopted"] == "true" do
        page
        |> join(:inner, [animal], c in assoc(animal, :adopt))
      else
        page
      end

    filter_changeset =
      if params["animals_filters"] != nil do
        AnimalsFilters.changeset(%AnimalsFilters{}, params["animals_filters"])
      else
        AnimalsFilters.changeset(%AnimalsFilters{}, %{})
      end

    pagination_params = [
      {
        :animals_filters,
        [
          {:animals_status_id, params["animals_filters"]["animals_status_id"]},
          {:adopted, params["animals_filters"]["adopted"]}
        ]
      }
    ]

    page = Repo.paginate(page, params)

    render(
      conn,
      "index.html",
      filter_changeset: filter_changeset,
      page: page,
      animals: page.entries,
      pagination_params: pagination_params
    )
  end

  def edit(conn, %{"id" => id}) do
    animal =
      Animals
      |> Repo.get(id)
      |> Repo.preload([
        :performed_procedure
      ])

    changeset = DataAnimals.change_animal(animal)

    render(conn, "edit.html", animals: animal, changeset: changeset)
  end

  def update(conn, %{"id" => id, "animals" => animal_params}) do
    animal = DataAnimals.get_animal(id)

    case DataAnimals.update_animal(animal, animal_params) do
      {:ok, animal} ->
        conn
        |> put_flash(:info, "Animal updated successfully.")
        |> redirect(to: animal_path(conn, :show, animal))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", animal: animal, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    animal =
      Animals
      |> Repo.get(id)
      |> Repo.delete()

    conn
    |> redirect(to: municipality_animal_path(conn, :index))
  end

  def create(conn, %{"animals" => animal_params}) do
    case Animals.create_animal(animal_params) do
      {:ok, animal} ->
        if animal_params["animal_image"] != nil do
          AnimalImages.store_images(animal, animal_params["animal_image"])
        end

        if animal_params["procedure_type_ids"] != nil do
          for id <- animal_params["procedure_type_ids"] do
            PerformedProcedures.create_procedure(%{procedure_type_id: id, animals_id: animal.id})
          end
        end

        conn
        |> redirect(to: animal_path(conn, :show, animal.id))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def new(conn, _params) do
    changeset = Animals.changeset(%Animals{})
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    animal =
      Repo.get(Animals, id)
      |> Repo.preload([:animals_image, :animals_status])

    render(conn, SmartcitydogsWeb.AnimalView, "show.html", animal: animal)
  end
end
