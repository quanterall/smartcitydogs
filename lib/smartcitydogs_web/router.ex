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

  pipeline :login_required do
    plug(
      Guardian.Plug.EnsureAuthenticated,
      handler: SmartcitydogsWeb.GuardianErrorHandler
    )
  end

  pipeline :admin_required do
    plug Smartcitydogs.CheckAdmin
  end

  pipeline :with_session do
    plug(Guardian.Plug.VerifySession)
    plug(Guardian.Plug.LoadResource)
    plug(Smartcitydogs.CurrentUser)
  end

  scope "/", SmartcitydogsWeb do
    # Use the default browser stack
    pipe_through([:browser, :with_session])

    get("/", PageController, :index)
<<<<<<< HEAD

    resources("/sessions", SessionController, only: [:new, :create, :delete])

    resources("/users", UserController, only: [:new, :create])

    # registered user zone
    scope "/" do
      pipe_through([:login_required])

      resources "/users", UserController, only: [:show] do
        resources("/posts", PostController)
      end

      # admin zone
      scope "/admin", Admin, as: :admin do
        pipe_through([:admin_required])

        resources "/users", UserController, only: [:index, :show] do
          resources "/posts", PostController, only: [:index, :show] 
        end
      end
    end
=======
    resources("/users", UserController)

    # resources "/all", AllController, only: [:index]
    # get("/register", RegisterController, :index)
>>>>>>> e1b74a8043d2f8bdf816134d73d9398c8e588c03
  end

  # Other scopes may use custom stacks.
  # scope "/api", SmartcitydogsWeb do
  #   pipe_through :api
  # end
end
