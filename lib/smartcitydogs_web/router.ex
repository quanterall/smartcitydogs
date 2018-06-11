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
    plug(Smartcitydogs.CheckAdmin)
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

    resources("/sessions", SessionController, only: [:new, :create, :delete])

    resources("/users", UserController, only: [:new, :create])
    resources("/help", HelpController, only: [:index])
    resources("/fortheproject", ForTheProjectController, only: [:index])

    resources(
      "/forgoten_password",
      ForgotenPasswordController,
      only: [:new, :create, :edit, :update]
    )

    resources("/contact", ContactController, only: [:new, :create])

    ###### registered user zone
    scope "/" do
      pipe_through([:login_required])

      resources("/users", UserController)
      resources("/animals", AnimalController)
      resources("/news", NewsController)
      get("/show", PageController, :show)

      resources(
        "/my_signals",
        MySignalsController
      )

      # get("/signals/my_signals", SignalController, :my_signals)
      get("/signals/comment", SignalController, :comment)
      get("/signals/get_signals_support_count", SignalController, :get_signals_support_count)
      get("/signals/update_like_count", SignalController, :update_like_count)

      resources(
        "/signals",
        SignalController
      )

      resources("/help", HelpController, only: [:index])
      resources("/contact", ContactController, only: [:new, :create, :edit, :update])

      ############ admin(zone)

      scope "/admin", Admin, as: :admin do
        pipe_through([:admin_required])

        resources("/users", UserController)
        get("/show", PageController, :show)

        get("/signals/comment", SignalController, :comment)
        get("/signals/get_signals_support_count", SignalController, :get_signals_support_count)
        get("/signals/update_like_count", SignalController, :update_like_count)

        resources(
          "/signals",
          SignalController
        )
      end
    end
  end

  scope "/auth", SmartcitydogsWeb do
    pipe_through(:browser)

    get("/:provider", SessionController, :request)
    get("/:provider/callback", SessionController, :callback)
  end

  # Other scopes may use custom stacks.
  # scope "/api", SmartcitydogsWeb do
  #   pipe_through :api
  # end
end
