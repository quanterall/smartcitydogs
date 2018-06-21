defmodule SmartCityDogsWeb.AnimalStatusController do
  use SmartCityDogsWeb, :controller

  alias SmartCityDogs.AnimalStatuses
  alias SmartCityDogs.AnimalStatuses.AnimalStatus

  action_fallback(SmartCityDogsWeb.FallbackController)

  def index(conn, _params) do
    animal_statuses = AnimalStatuses.list_animal_statuses()
    render(conn, "index.json", animal_statuses: animal_statuses)
  end

  def create(conn, %{"animal_status" => animal_status_params}) do
    with {:ok, %AnimalStatus{} = animal_status} <-
           AnimalStatuses.create_animal_status(animal_status_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", animal_status_path(conn, :show, animal_status))
      |> render("show.json", animal_status: animal_status)
    end
  end

  def show(conn, %{"id" => id}) do
    animal_status = AnimalStatuses.get_animal_status!(id)
    render(conn, "show.json", animal_status: animal_status)
  end

  def update(conn, %{"id" => id, "animal_status" => animal_status_params}) do
    animal_status = AnimalStatuses.get_animal_status!(id)

    with {:ok, %AnimalStatus{} = animal_status} <-
           AnimalStatuses.update_animal_status(animal_status, animal_status_params) do
      render(conn, "show.json", animal_status: animal_status)
    end
  end

  def delete(conn, %{"id" => id}) do
    animal_status = AnimalStatuses.get_animal_status!(id)

    with {:ok, %AnimalStatus{}} <- AnimalStatuses.delete_animal_status(animal_status) do
      send_resp(conn, :no_content, "")
    end
  end
end
