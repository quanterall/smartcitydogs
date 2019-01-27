defmodule SmartcitydogsWeb.Router do
  use SmartcitydogsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Smartcitydogs.Plugs.AssignCurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Smartcitydogs.Guardian.ApiAuthPipeline
  end

  pipeline :auth do
    plug Smartcitydogs.Guardian.AuthPipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  ## Browser ##
  scope "/", SmartcitydogsWeb do
    pipe_through :browser

    get "/", HomeController, :index
    resources("/signals", SignalController, only: [:show, :index])
    resources("/news", NewsController, only: [:show, :index])
    resources("/animals", AnimalController, only: [:show, :index])
    get("/about", PageController, :about)
    get("/help", PageController, :help)
    get("/contact", ContactController, :new)
    post("/contact", ContactController, :send)

    scope "/auth" do
      get("/login", SessionController, :new)
      post("/login", SessionController, :create)
      get("/logout", SessionController, :delete)
    end

    scope "/" do
      pipe_through [:auth, :ensure_auth]
      get "/profile", UserController, :show
    end
  end

  scope "/api", SmartcitydogsWeb.Api, as: :api do
    pipe_through :api

    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
    resources("/signals", SignalController, only: [:show, :index])
    resources("/animals", AnimalController, only: [:show, :index])

    scope "/" do
      pipe_through [:jwt_authenticated]
      resources("/signals", SignalController, only: [:create, :update])

      scope "/signals/:signal_id" do
        resources("/comments", SignalCommentController, only: [:create, :update])
        resources("/likes", SignalLikeController, only: [:create, :delete])
      end

      get "/profile", UserController, :show
    end
  end
end
