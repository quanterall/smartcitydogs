defmodule Smartcitydogs.SignalsData do

  import Ecto.Query, warn: false
  alias Smartcitydogs.Repo

  alias Smartcitydogs.Signals
  alias Smartcitydogs.SignalsTypes
  alias Smartcitydogs.SignalsComments
  alias Smartcitydogs.SignalsCategories
  alias Smartcitydogs.User

  import Plug.Conn

  def list_signals(Signals) do
    Repo.all(Signals)
  end

  def get_signal(id) do
    Repo.get!(Signals,id)
  end

  def create_signal(args \\ %{}) do
    
  end
end
