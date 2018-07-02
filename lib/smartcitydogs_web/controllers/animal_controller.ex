defmodule SmartcitydogsWeb.AnimalController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.DataAnimals
  alias Smartcitydogs.Animals
  alias Smartcitydogs.AnimalImages
  alias Smartcitydogs.Repo

  def index(conn, params) do
    chip = params["chip_number"]
    page = Animals |> Smartcitydogs.Repo.paginate(params)
    if chip == "" do
      animals = DataAnimals.list_animals()
      render(conn, "index.html", animals: page.entries, page: page)
    end

    if chip != nil do
      animals = DataAnimals.get_animal_by_chip(chip)
      render(conn, "index.html", animals: page.entries, page: page)
    end

    page = Animals |> Smartcitydogs.Repo.paginate(params)
   ## animals = DataAnimals.list_animals()
    render(conn, "index.html", animals: page.entries, page: page)
  end

  def new(conn, _params) do
    changeset = Animals.changeset(%Animals{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"animals" => animal_params}) do
    case DataAnimals.create_animal(animal_params) do
      {:ok, animal} ->
        upload_file(animal.id, conn)

        conn
        |> put_flash(
          :info,
          " Dog wiht chip number #{Map.get(animal_params, "chip_number")} is created!"
        )
        |> redirect(to: animal_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def upload_file(id, conn) do
    upload = Map.get(conn, :params)
    upload = Map.get(upload, "files")

    for n <- upload do
      [head] = n
      IO.puts("\n N:")
      IO.inspect(n)

      extension = Path.extname(head.filename)

      # File.cp(head.path, "/home/sonyft/smartcitydog/smartcitydogs/assets/static/images/#{Map.get(animal_params, "chip_number")}-profile#{}#{extension}")
      File.cp(
        head.path,
        "../smartcitydogs/assets/static/images/#{Map.get(head, :filename)}-profile#{extension}"
      )

      args = %{
        "url" => "images/#{Map.get(head, :filename)}-profile#{extension}",
        "animals_id" => "#{id}"
      }

      DataAnimals.create_animal_image(args)
    end
  end

  def show(conn, %{"id" => id}) do
    # animal = Repo.get!(Animals, id) |> Repo.preload(:animals_status)
    animal = DataAnimals.get_animal(id)
    render(conn, "show.html", animals: animal)
  end

  def edit(conn, %{"id" => id}) do
    animal = DataAnimals.get_animal(id)
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
end
