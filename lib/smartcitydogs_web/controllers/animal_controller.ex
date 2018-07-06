defmodule SmartcitydogsWeb.AnimalController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.DataAnimals
  alias Smartcitydogs.Animals
  alias Smartcitydogs.AnimalImages
  alias Smartcitydogs.Repo

  plug(:put_layout, false)

  def index(conn, _params) do
    chip = _params["chip_number"]

    logged_user_type_id = conn.assigns.current_user.users_types.id

    if logged_user_type_id == 3 do
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    else
      if chip == "" do
        animals = DataAnimals.list_animals()
        render(conn, "index.html", animals: animals)
      end

      if chip != nil do
        animals = DataAnimals.get_animal_by_chip(chip)
        render(conn, "index.html", animals: animals)
      end

      animals = DataAnimals.list_animals()
      render(conn, "index.html", animals: animals)
    end
  end

  def new(conn, _params) do
    changeset = Animals.changeset(%Animals{})

    logged_user_type_id = conn.assigns.current_user.users_types.id

    if logged_user_type_id != 5 do
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def create(conn, %{"animals" => animal_params}) do
    logged_user_type_id = conn.assigns.current_user.users_types.id

    if logged_user_type_id != 5 do
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    else
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
  end

  def upload_file(id, conn) do
    upload = Map.get(conn, :params)
    upload = Map.get(upload, "files")

    for n <- upload do
      [head] = n
      IO.puts("\n N:")
      IO.inspect(n)

      extension = Path.extname(head.filename)

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
    animal = DataAnimals.get_animal(id)
    logged_user_type_id = conn.assigns.current_user.users_types.id

    if logged_user_type_id == 3 do
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    else
      render(conn, "show.html", animals: animal)
    end
  end

  def edit(conn, %{"id" => id}) do
    animal = DataAnimals.get_animal(id)
    changeset = DataAnimals.change_animal(animal)
    logged_user_type_id = conn.assigns.current_user.users_types.id

    if logged_user_type_id == 1 || logged_user_type_id == 5 do
      render(conn, "edit.html", animals: animal, changeset: changeset)
    else
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end

  def update(conn, %{"id" => id, "animals" => animal_params}) do
    animal = DataAnimals.get_animal(id)

    logged_user_type_id = conn.assigns.current_user.users_types.id

    if logged_user_type_id == 1 || logged_user_type_id == 5 do
      case DataAnimals.update_animal(animal, animal_params) do
        {:ok, animal} ->
          conn
          |> put_flash(:info, "Animal updated successfully.")
          |> redirect(to: animal_path(conn, :show, animal))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", animal: animal, changeset: changeset)
      end
    else
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end
end
