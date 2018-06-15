defmodule SmartCityDogsWeb.Router do
  use SmartCityDogsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SmartCityDogsWeb do
    pipe_through :api
  end
end
