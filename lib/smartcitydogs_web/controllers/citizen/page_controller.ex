defmodule SmartcitydogsWeb.PageController do
  use SmartcitydogsWeb, :controller

  import Ecto.Query
  alias Smartcitydogs.DataSignal
  alias Smartcitydogs.DataPage
  alias Smartcitydogs.DataAnimal
  alias Smartcitydogs.Animal
  alias Smartcitydogs.Signal
  alias Smartcitydogs.News
  alias Smartcitydogs.Repo

  def index(conn, _params) do
    signals =
      Signal
      |> limit(6)
      |> order_by(desc: :id)
      |> Repo.all()
      |> Repo.preload([:signal_type, :signal_category, :signal_comments, :signal_likes])

    news =
      News
      |> limit(4)
      |> Repo.all()

    animal =
      Animal
      |> limit(6)
      |> Repo.all()
      |> Repo.preload([:animal_images, :animal_status])

    adopted_animals =
      Animal
      |> limit(6)
      |> where(animal_status_id: 3)
      |> preload([:animal_images, :animal_status])
      |> Repo.all()

    render(conn, "index.html",
      signals: signals,
      news: news,
      animals: animal,
      adopted_animals: adopted_animals
    )
  end
end
