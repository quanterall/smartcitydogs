defmodule SmartcitydogsWeb.Shelter.AnimalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.{Signals, Repo, SignalsFilters}
  import Ecto.Query

  action_fallback(SmartcitydogsWeb.FallbackController)

   def index(conn, params) do
    chip =
      if params["chip_number"] do
        dynamic([p], ilike(p.chip_number, ^params["chip_number"]))
      else
        true
      end

    page =
      Animals
      |> preload(:animals_status)
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
      Repo.get(Animals, id)
      |> Repo.preload([:animals_image, :animals_status])

    render(conn, "show.html", animal: animal)
  end
end
