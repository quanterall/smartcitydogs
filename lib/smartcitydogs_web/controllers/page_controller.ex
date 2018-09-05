defmodule SmartcitydogsWeb.PageController do
  use SmartcitydogsWeb, :controller

  import Ecto.Query
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.DataPages
  alias Smartcitydogs.DataAnimals
  alias Smartcitydogs.Animals
  alias Smartcitydogs.Signals
  alias Smartcitydogs.News
  alias Smartcitydogs.Repo

  def index(conn, _params) do
    signals =
      Signals
      |> limit(6)
      |> Repo.all()
      |> Repo.preload([:signals_types, :signals_categories, :signals_comments])

    news =
      News
      |> limit(4)
      |> Repo.all()

    animal =
      Animals
      |> limit(6)
      |> Repo.all()
      |> Repo.preload([:animals_image, :animals_status])

    adopted_animals =
      Animals
      |> limit(6)
      |> where(animals_status_id: 3)
      |> preload([:animals_image, :animals_status])
      |> Repo.all()

    render(conn, "index.html",
      signals: signals,
      news: news,
      animals: animal,
      adopted_animals: adopted_animals
    )
  end
end
