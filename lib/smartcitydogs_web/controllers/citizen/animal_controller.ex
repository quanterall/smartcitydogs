defmodule SmartcitydogsWeb.AnimalController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Animal
  alias Smartcitydogs.Repo
  import Ecto.Query

  ## Render for regular users
  def index(conn, params) do
    chip =
      if params["chip_number"] do
        dynamic([p], ilike(p.chip_number, ^params["chip_number"]))
      else
        true
      end

    page =
      Animal
      |> preload(:animal_status)
      |> where(^chip)
      |> order_by(desc: :inserted_at)
      |> Repo.paginate(params)

    render(
      conn,
      "index.html",
      animals: page.entries,
      page: page
    )
  end

  def show(conn, %{"id" => id}) do
    animal =
      Repo.get(Animal, id)
      |> Repo.preload([:animal_images, :animal_status])

    render(conn, "show.html", animal: animal)
  end

  def adopt(conn, %{"animal_id" => animal_id}) do
    animal = Repo.get(Animal, animal_id)
    Smartcitydogs.Animal.adopt(animal, conn.assigns.current_user)

    conn
    |> redirect(to: NavigationHistory.last_path(conn, []))
  end
end
