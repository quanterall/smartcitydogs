defmodule SmartcitydogsWeb.PageController do
  use SmartcitydogsWeb, :controller
  
  import Ecto.Query
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.DataPages
  alias Smartcitydogs.DataAnimals
  alias Smartcitydogs.Animals
  

  def index(conn, _params) do
    signal = DataSignals.list_signals()
    news = DataPages.list_news()
    animal = DataAnimals.list_animals()
    struct = from(p in Animals, where: p.animals_status_id == 3)
    adopted_animals = Smartcitydogs.Repo.all(struct) |> Smartcitydogs.Repo.preload(:animals_status)

    last_animals = 
      if length(animal) <= 6 do
        animal
      else
        Enum.slice(animal, -6..-1) |> Enum.reverse
      end

    last_signals = 
      if length(signal) <= 6 do
        signal
      else
        Enum.slice(signal, -6..-1)
      end

    last_news =
      if length(news) <= 3 do
        news
      else
        Enum.slice(news, -3..-1)
      end
      
    last_adopted_animals =
      if length(adopted_animals) <= 6 do
        adopted_animals
      else
        Enum.slice(adopted_animals, -6..-1) |> Enum.reverse
      end

    render(conn, "index.html", signal: last_signals, news: last_news, animals: last_animals, adopted_animals: last_adopted_animals)
  end
end
