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
    plug(:fetch_session)
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

  pipeline :api_auth do
    plug(:ensure_authenticated)
  end

  pipeline :with_session do
    plug(Guardian.Plug.VerifySession)
    plug(Guardian.Plug.LoadResource)
    plug(Smartcitydogs.CurrentUser)
  end

  scope "/api", SmartcitydogsWeb do
    pipe_through(:api)

    post("/users/sign_in", UserControllerAPI, :sign_in)

    resources(
      "/forgoten_password",
      ForgotenPasswordControllerAPI,
      only: [:new, :create, :edit, :update]
    )

    resources("/users", UserControllerAPI, only: [:create])
  end

  scope "/api", SmartcitydogsWeb do
    pipe_through([:api, :api_auth])
    resources("/users", UserControllerAPI, except: [:new, :edit])
    post("/users/logout", UserControllerAPI, :logout)

    resources("/signals", SignalControllerAPI, except: [:new, :edit])
    resources("/signal_images", SignalImageControllerAPI, except: [:new, :edit])
    resources("/signals_comments", SignalsCommentControllerAPI, except: [:new, :edit])
    resources("/signals_types", SignalsTypeControllerAPI, except: [:new, :edit])
    resources("/signals_categories", SignalCategoryControllerAPI, except: [:new, :edit])
    resources("/signals_likes", SignalsLikeControllerAPI, except: [:new, :edit])
    resources("/contacts", ContactControllerAPI, except: [:new, :edit, :delete])
    resources("/users_types", UsersTypeControllerAPI, except: [:new, :edit])
    resources("/performed_procedure", PerformedProcedureControllerAPI, except: [:new, :edit])
    resources("/animal_statuses", AnimalStatusControllerAPI, except: [:new, :edit])
    resources("/animal_images", AnimalImageControllerAPI, except: [:new, :edit])
    resources("/rescues", RescueControllerAPI, except: [:new, :edit])
    resources("/procedure_types", ProcedureTypeControllerAPI, except: [:new, :edit])
    resources("/animals", AnimalControllerAPI, except: [:new, :edit])
    resources("/header_slides", HeaderSlideControllerAPI, except: [:new, :edit])
    resources("/news", NewsSchemaControllerAPI, except: [:new, :edit])
    resources("/static_pages", StaticPageControllerAPI, except: [:new, :edit])
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
      get("/users", UserController, :index)
      get("/users/:id", UserController, :show)

      resources("/animals", AnimalController)
      resources("/news", NewsController)
      get("/show", PageController, :show)

      resources(
        "/my_signals",
        MySignalsController
      )

      # get("/signals/my_signals", SignalController, :my_signals)
      get("/signals/comment", SignalController, :comment)
      get("/signals/filter_index", SignalController, :filter_index)
      get("/signals/get_signals_support_count", SignalController, :get_signals_support_count)
      get("/signals/update_like_count", SignalController, :update_like_count)
      get("/signals/update_type", SignalController, :update_type)

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

  # Plug function
  defp ensure_authenticated(conn, _opts) do
    current_user_id = get_session(conn, :current_user_id)
    IO.puts("Authentication!")

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
