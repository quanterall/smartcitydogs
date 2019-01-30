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

  pipeline :jwt_authenticated do
    plug(Smartcitydogs.Guardian.ApiAuthPipeline)
  end

  pipeline :auth do
    plug(Smartcitydogs.Guardian.AuthPipeline)
  end

  pipeline :ensure_auth do
    plug(Guardian.Plug.EnsureAuthenticated)
  end

  ## Browser ##
  scope "/", SmartcitydogsWeb do
    pipe_through([:browser, :auth])

    scope "/" do
      pipe_through([:ensure_auth])
      get("/profile", UserController, :show)
      resources("/news", NewsController, except: [:show, :index])
      resources("/animals", AnimalController, except: [:show, :index])

      scope "/animals/:animal_id" do
        resources("/performed-procedure", PerformedProcedureController)
      end
    end

    resources("/news", NewsController, only: [:show, :index])

    get("/", HomeController, :index)
    resources("/signals", SignalController, only: [:show, :index])

    resources("/animals", AnimalController, only: [:show, :index])
    get("/about", PageController, :about)
    get("/help", PageController, :help)
    get("/contact", ContactController, :new)
    post("/contact", ContactController, :send)
    get("/login", SessionController, :new)
    post("/login", SessionController, :create)
    get("/logout", SessionController, :delete)
  end

  scope "/api", SmartcitydogsWeb.Api, as: :api do
    pipe_through(:api)

    post("/sign_up", UserController, :create)
    post("/sign_in", UserController, :sign_in)
    resources("/signals", SignalController, only: [:show, :index])
    resources("/animals", AnimalController, only: [:show, :index])

    scope "/" do
      pipe_through([:jwt_authenticated])
      resources("/signals", SignalController, only: [:create, :update])

      scope "/signals/:signal_id" do
        resources("/comments", SignalCommentController, only: [:create, :update])
        resources("/likes", SignalLikeController, only: [:create, :delete])
      end

      scope "/statistics" do
        get("/count", StatisticController, :count)
      end

      scope "/animals/:animal_id" do
        post("/adopt", AdoptController, :create)
      end

      get("/profile", UserController, :show)
    end
  end
end
