defmodule SmartcitydogsWeb.AnimalStatusControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.DataAnimal
  alias Smartcitydogs.AnimalStatus

  action_fallback(SmartCityDogsWeb.FallbackController)

  def index(conn, _params) do
    animal_statuses = DataAnimal.list_animal_statuses()
    render(conn, "index.json", animal_statuses: animal_statuses)
  end

  def create(conn, %{"animal_status" => animal_status_params}) do
    with {:ok, %AnimalStatus{} = animal_status} <-
           DataAnimal.create_animal_status(animal_status_params) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        animal_status_controller_api_path(conn, :show, animal_status)
      )
      |> render("show.json", animal_status: animal_status)
    end
  end

  def show(conn, %{"id" => id}) do
    animal_status = DataAnimal.get_animal_status(id)
    render(conn, "show.json", animal_status: animal_status)
  end

  def update(conn, %{"id" => id, "animal_status" => animal_status_params}) do
    animal_status = DataAnimal.get_animal_status(id)

    with {:ok, %AnimalStatus{} = animal_status} <-
           DataAnimal.update_animal_status(animal_status, animal_status_params) do
      render(conn, "show.json", animal_status: animal_status)
    end
  end

  def delete(conn, %{"id" => id}) do
    animal_status = DataAnimal.get_animal_status(id)

    with {:ok, %AnimalStatus{}} <- DataAnimal.delete_animal_status(animal_status) do
      send_resp(conn, :no_content, "")
    end
  end
end
