defmodule SmartcitydogsWeb.Router do
  use SmartcitydogsWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", SmartcitydogsWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/show", PageController, :show)
    resources("/users", UserController)

    get("/signals/comment", SignalController, :comment)
    get("/signals/get_signals_support_count", SignalController, :get_signals_support_count)
    get("/signals/update_like_count", SignalController, :update_like_count)
    resources(
      "/signals",
      SignalController
    )
    # resources(
    #   "/",
    #   SupportCountController
    # )

    #get("/signals/:id", SignalController, :update)

    # resources "/all", AllController, only: [:index]
    # get("/register", RegisterController, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", SmartcitydogsWeb do
  #   pipe_through :api
  # end
end
