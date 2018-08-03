defmodule SmartcitydogsWeb.AnimalController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.DataAnimals
  alias Smartcitydogs.Animals
  alias Smartcitydogs.AnimalImages
  alias Smartcitydogs.Repo
  import Ecto.Query

  plug(:put_layout, false when action in [:adopted_animals])
  plug(:put_layout, false when action in [:shelter_animals])

  ############################# Minicipality Home Page Animals ################################

  def minicipality_registered(conn, params) do
    chip = params["chip_number"]
    page = Animals |> Smartcitydogs.Repo.paginate(params)
    sorted_animals = DataAnimals.sort_animals_by_id()
    logged_user_type_id = conn.assigns.current_user.users_types.id

    if logged_user_type_id == 3 do
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    else
      if chip == "" do
        page = Smartcitydogs.Repo.paginate(sorted_animals)
        render(conn, "minicipality_registered.html", animals: page.entries, page: page)
      end

      if chip != nil do
        animals = DataAnimals.get_animal_by_chip(chip)
        page = Map.delete(page, :entries) |> Map.delete(:total_entries)
        page = Map.put(page, :entries, animals) |> Map.put(:total_entries, length(animals))

        list_animals =
          Map.get(page, :entries) |> Repo.preload(:animals_status) |> Repo.preload(:animals_image)

        # render(conn, "minicipality_registered.html", animals: list_animals, page: page)
        ##  page = Map.delete(page, :entries) |> Map.delete(:total_entries)
        ##   page = Map.put(page, :entries, animals) |> Map.put(:total_entries, length(animals))
        page = Smartcitydogs.Repo.paginate(animals)
        render(conn, "minicipality_registered.html", animals: page.entries, page: page)
      end

      page = Animals |> Smartcitydogs.Repo.paginate(params)

      list_animals =
        Map.get(page, :entries) |> Repo.preload(:animals_status) |> Repo.preload(:animals_image)

      render(conn, "minicipality_registered.html", animals: list_animals, page: page)
    end
  end

  def minicipality_shelter(conn, params) do
    struct = from(p in Animals, where: p.animals_status_id == 3)
    all_adopted = Repo.all(struct) |> Repo.preload(:animals_status)
    page = Smartcitydogs.Repo.paginate(all_adopted, page: 1, page_size: 8)
    render(conn, "minicipality_shelter.html", animals: page.entries, page: page)
  end

  def minicipality_adopted(conn, params) do
    struct = from(p in Animals, where: p.animals_status_id == 2)
    all_adopted = Repo.all(struct) |> Repo.preload(:animals_status)
    page = Smartcitydogs.Repo.paginate(all_adopted, page: 1, page_size: 8)
    render(conn, "minicipality_adopted.html", animals: page.entries, page: page)
  end

  ############################# /Minicipality Home Page Animals ################################

  def index(conn, params) do
    sorted_animals = DataAnimals.sort_animals_by_id()
    IO.inspect(conn)

    if conn.assigns.current_user != nil do
      logged_user_type_id = conn.assigns.current_user.users_types.id

      if logged_user_type_id == 3 do
        render(conn, SmartcitydogsWeb.ErrorView, "401.html")
      else
        index_rendering(conn, params, sorted_animals)
      end
    else
      index_rendering(conn, params, sorted_animals)
    end
  end

  defp index_rendering(conn, params, sorted_animals) do
    cond do
      params == %{} || (params["page"] == nil && params["chip_number"] == "") ->
        x = 1
        page = Smartcitydogs.Repo.paginate(sorted_animals, page: x, page_size: 8)

        list_animals =
          Map.get(page, :entries)
          |> Repo.preload(:animals_status)
          |> Repo.preload(:animals_image)

        render(
          conn,
          "index.html",
          animals: list_animals,
          page: page,
          chip_number: params["chip_number"]
        )

      params != %{} && params["page"] != nil ->
        x = String.to_integer(params["page"])
        animals = DataAnimals.get_animal_by_chip(params["chip_number"])
        page = Smartcitydogs.Repo.paginate(animals, page: x, page_size: 8)

        render(
          conn,
          "index.html",
          animals: page.entries,
          page: page,
          chip_number: params["chip_number"]
        )

      params["chip_number"] != nil ->
        chip = params["chip_number"]
        animals = DataAnimals.get_animal_by_chip(chip)
        page = Smartcitydogs.Repo.paginate(animals, page_size: 8)

        render(
          conn,
          "index.html",
          animals: page.entries,
          page: page,
          chip_number: params["chip_number"]
        )
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

    if conn.assigns.current_user != nil do
    logged_user_type_id = conn.assigns.current_user.users_types.id
      if logged_user_type_id == 3 do
        render(conn, SmartcitydogsWeb.ErrorView, "401.html")
      else
        render(conn, "show.html", animals: animal)
      end
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
