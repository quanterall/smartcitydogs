defmodule SmartcitydogsWeb.PageController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.DataPages
  alias Smartcitydogs.DataAnimals
  alias Smartcitydogs.SignalController

  def index(conn, _params) do
    signal = DataSignals.list_signals()
    news = DataPages.list_news()
    animal = DataAnimals.list_animals()

    if length(animal) <= 3 do
      last_animals = animal
    else
      last_animals = Enum.slice(animal, -3..-1)
    end

    if length(signal) <= 3 do
      last_signals =  signal
    else 
      last_signals = Enum.slice(signal, -6..-1)
    end 

    if length(news) <= 3 do
      last_news = news
    else
      last_news = Enum.slice(news, -3..-1)
    end

    render(conn, "index.html", signal: last_signals, news: last_news, animals: last_animals)
  end



end
