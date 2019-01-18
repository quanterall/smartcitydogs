defmodule SmartcitydogsWeb.Router do
  use SmartcitydogsWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(NavigationHistory.Tracker)
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
  end

  pipeline :login_required do
    plug(
      Guardian.Plug.EnsureAuthenticated,
      handler: Smartcitydogs.GuardianErrorHandler
    )
  end

  pipeline :admin_required do
    plug(Smartcitydogs.CheckAdmin)
  end

  pipeline :shelter_required do
    plug(Smartcitydogs.CheckShelter)
  end

  pipeline :municipality_required do
    plug(Smartcitydogs.CheckMunicipality)
  end

  pipeline :zoo_police_required do
    plug(Smartcitydogs.CheckPolice)
  end

  pipeline :api_auth do
    plug(:ensure_authenticated)
  end

  pipeline :with_session do
    plug(Guardian.Plug.VerifySession)
    plug(Guardian.Plug.LoadResource)
    plug(Smartcitydogs.CurrentUser)
  end

  pipeline :municipality_layout do
    plug(:put_layout, {SmartcitydogsWeb.Municipality.LayoutView, :app})
  end

  pipeline :shelter_layout do
    plug(:put_layout, {SmartcitydogsWeb.Shelter.LayoutView, :app})
  end

  pipeline :zoo_police_layout do
    plug(:put_layout, {SmartcitydogsWeb.ZooPolice.LayoutView, :app})
  end

  scope "/api", SmartcitydogsWeb do
    scope "/" do
      pipe_through(:api)

      post("/users/sign_in", UserControllerAPI, :sign_in)
      resources("/signals", SignalControllerAPI, only: [:index, :show])

      resources(
        "/forgoten_password",
        ForgotenPasswordControllerAPI,
        only: [:new, :create, :edit, :update]
      )

      resources("/users", UserControllerAPI, only: [:create])
    end

    scope "/" do
      pipe_through([:api, :api_auth])

      get("/users/:id", UserControllerAPI, :show)
      post("/users/logout", UserControllerAPI, :logout)
      resources("/signals", SignalControllerAPI)
      get("/my_signals", MySignalControllerAPI, :index)

      resources("/signal_type", SignalTypeControllerAPI, except: [:new, :edit])
      resources("/signal_category", SignalCategoryControllerAPI, except: [:new, :edit])

      resources("/animals", AnimalControllerAPI, except: [:new, :edit])
      post("/animals/:id/send_email", AnimalControllerAPI, :send_email)
      resources("/contacts", ContactControllerAPI, except: [:new, :edit, :delete])
    end
  end

  ###### DEFAULT BROWSER STACK #####

  scope "/", SmartcitydogsWeb do
    pipe_through([:browser, :with_session])

    get("/", PageController, :index)
    resources("/signals", SignalController, only: [:index, :new, :create, :show])
    resources("/animals", AnimalController, only: [:index, :show])

    resources("/sessions", SessionController, only: [:new, :create, :delete])
    resources("/users", UserController, only: [:new, :create])
    resources("/help", HelpController, only: [:index])
    resources("/about", AboutController, only: [:index])
    resources("/news", NewsController, only: [:index, :show, :new, :create, :edit, :update])
    resources("/forgoten_password", ForgotenPasswordController)
    resources("/contact", ContactController, only: [:index, :new, :create])
    ###### REGISTERED USER ZONE #########
    scope "/" do
      pipe_through([:login_required])

      get("/profile", UserController, :show)
      get("/profile/edit", UserController, :edit)
      put("/profile/update", UserController, :update)

      post("/animals/:id/adopt", AnimalController, :adopt)
      get("/show", PageController, :show)

      resources("/my_signals", MySignalController)
      get("/followed_signals", SignalController, :followed_signals)

      get("/signals/get_signal_support_count", SignalController, :get_signal_support_count)
      get("/signals/followed_signals", SignalController, :followed_signals)
      get("/signals/:id/update_type", SignalController, :update_type)
      resources("/signals", SignalController)

      scope "/signals/:id" do
        resources("/comments", SignalCommentController)
        post("/dislike", SignalController, :dislike)
        post("/like", SignalController, :like)
      end

      resources("/help", HelpController, only: [:index])

      scope "/municipality", Municipality, as: :municipality do
        pipe_through([:municipality_required, :municipality_layout])
        resources("/animals", AnimalController)
        get("/signals", SignalController, :index)
      end

      scope "/shelter", Shelter, as: :shelter do
        pipe_through([:shelter_required, :shelter_layout])
        resources("/animals", AnimalController)
        resources("/performed_procedure", PerformedProcedureController, only: [:create, :delete])
        get("/signals", SignalController, :index)
      end

      scope "/zoo_police", ZooPolice, as: :zoo_police do
        pipe_through([:zoo_police_required, :zoo_police_layout])
        get("/signals", SignalController, :index)
      end
    end
  end

  scope "/auth", SmartcitydogsWeb do
    pipe_through(:browser)

    get("/:provider", SessionController, :request)
    get("/:provider/callback", SessionController, :callback)
  end

  # Plug function
  defp ensure_authenticated(conn, _opts) do
    current_user_id = get_session(conn, :current_user_id)

    if current_user_id do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> render(SmartcitydogsWeb.ErrorView, "401.json", message: "Unauthenticated user")
      |> halt()
    end
  end
end
