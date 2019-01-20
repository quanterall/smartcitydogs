defmodule SmartcitydogsWeb.Shelter.AnimalController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.{
    Repo,
    Animal,
    AnimalFilter,
    PerformedProcedure,
    AnimalImage
  }

  import Ecto.Query

  def index(conn, params) do
    page =
      Animal
      |> order_by(desc: :inserted_at)
      |> preload([:animal_status, :performed_procedure, performed_procedure: :procedure_type])

    page =
      if params["animals_filters"]["animal_status_id"] &&
           params["animals_filters"]["animal_status_id"] != "" do
        page
        |> where(
          [animal],
          animal.animal_status_id == ^params["animals_filters"]["animal_status_id"]
        )
      else
        page
      end

    page =
      if params["animals_filters"]["adopted"] == "true" do
        page
        |> join(:inner, [animal], c in assoc(animal, :adopt))
      else
        page
      end

    filter_changeset =
      if params["animals_filters"] != nil do
        AnimalFilter.changeset(%AnimalFilter{}, params["animals_filters"])
      else
        AnimalFilter.changeset(%AnimalFilter{}, %{})
      end

    performed_procedure_changeset = PerformedProcedure.changeset(%PerformedProcedure{}, %{})

    pagination_params = [
      {
        :animals_filters,
        [
          {:animal_status_id, params["animals_filters"]["animal_status_id"]},
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
      pagination_params: pagination_params,
      performed_procedure_changeset: performed_procedure_changeset
    )
  end

  def edit(conn, %{"id" => id}) do
    animal =
      Animal
      |> Repo.get(id)
      |> Repo.preload([
        :performed_procedure
      ])

    changeset = Animal.changeset(animal)

    render(conn, "edit.html", animals: animal, changeset: changeset)
  end

  def update(conn, %{"id" => id, "animals" => animal_params}) do
    animal =
      Animal
      |> Repo.get(id)
      |> Animal.changeset(animal_params)
      |> Repo.update()

    case animal do
      {:ok, animal} ->
        conn
        |> put_flash(:info, "Animal updated successfully.")
        |> redirect(to: animal_path(conn, :show, animal))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", animal: animal, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    Animal
    |> Repo.get(id)
    |> Repo.delete()

    conn
    |> redirect(to: shelter_animal_path(conn, :index))
  end

  def create(conn, %{"animals" => animal_params}) do
    case Animal.create_animal(animal_params) do
      {:ok, animal} ->
        if animal_params["animal_image"] != nil do
          AnimalImage.store_images(animal, animal_params["animal_image"])
        end

        conn
        |> redirect(to: shelter_animal_path(conn, :show, animal.id))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def new(conn, _params) do
    changeset = Animal.changeset(%Animal{})
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    animal =
      Repo.get(Animal, id)
      |> Repo.preload([:animal_images, :animal_status])

    render(conn, SmartcitydogsWeb.AnimalView, "show.html", animal: animal)
  end
end
