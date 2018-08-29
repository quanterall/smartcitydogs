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
      handler: Smartcitydogs.GuardianErrorHandler
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
    scope "/signals" do
      get("/:id/comment", SignalControllerAPI, :comment)
      get("/:id/unlike", SignalControllerAPI, :unlike)
      get("/:id/like", SignalControllerAPI, :like)
      put("/signals/follow", SignalControllerAPI, :follow)
      put("/signals/unfollow", SignalControllerAPI, :unfollow)
    end
    get("/my_signals", MySignalsControllerAPI, :index)
    resources("/signal_images", SignalImageControllerAPI, except: [:new, :edit])
    resources("/signals_comments", SignalsCommentControllerAPI, except: [:new, :edit])
    scope "/signals_comments", SmartcitydogsWeb do
      put("/follow", SignalsCommentControllerAPI,:follow)
      put("/unfollow", SignalsCommentControllerAPI, :unfollow)
    end
    resources("/signals_types", SignalsTypeControllerAPI, except: [:new, :edit])
    resources("/signals_categories", SignalCategoryControllerAPI, except: [:new, :edit])
    resources("/signals_likes", SignalsLikeControllerAPI, except: [:new, :edit])
    resources("/animals", AnimalControllerAPI, except: [:new, :edit])
    post("/animals/:id/send_email", AnimalControllerAPI, :send_email)
    resources("/contacts", ContactControllerAPI, except: [:new, :edit, :delete])
    resources("/users_types", UsersTypeControllerAPI, except: [:new, :edit])
    resources("/performed_procedure", PerformedProcedureControllerAPI, except: [:new, :edit])
    resources("/animal_statuses", AnimalStatusControllerAPI, except: [:new, :edit])
    resources("/animal_images", AnimalImageControllerAPI, except: [:new, :edit])
    resources("/rescues", RescueControllerAPI, except: [:new, :edit])
    resources("/procedure_types", ProcedureTypeControllerAPI, except: [:new, :edit])
    resources("/header_slides", HeaderSlideControllerAPI, except: [:new, :edit])
    resources("/news", NewsSchemaControllerAPI, except: [:new, :edit])
    resources("/static_pages", StaticPageControllerAPI, except: [:new, :edit])
    

    # post("/signals/add_comment_like", SignalController, :add_comment_like)
    # post("/signals/add_comment_dislike", SignalController, :add_comment_dislike)
  end

  ###### DEFAULT BROWSER STACK #####

  scope "/", SmartcitydogsWeb do

    pipe_through([:browser, :with_session])

    get("/", PageController, :index)
    resources("/signals", SignalController)
    resources("/registered", AnimalController)
    resources("/sessions", SessionController, only: [:new, :create, :delete])
    resources("/users", UserController, only: [:new, :create])
    resources("/help", HelpController, only: [:index])
    resources("/fortheproject", ForTheProjectController, only: [:index])
    resources("/news", NewsController)
    resources("/forgoten_password",ForgotenPasswordController)
    resources("/contact", ContactController, only: [:index, :new, :create])
    ###### REGISTERED USER ZONE #########
    scope "/" do
      pipe_through([:login_required])
      resources("/users", UserController)
      resources("/registered", AnimalController)
      resources("/news", NewsController)
      
      get("/show", PageController, :show) ##not in develop

      resources("/my_signals", MySignalsController)

      get("/show", PageController, :show)


      get("/signals/get_signals_support_count", SignalController, :get_signals_support_count)
      get("/signals/followed_signals", SignalController, :followed_signals)
      get("/signals/update_type", SignalController, :update_type)
      resources("/signals", SignalController)

      resources("/help", HelpController, only: [:index])

      resources("/contact", ContactController, only: [:new, :create, :edit, :update])

      ####### ADMIN ZONE #########

      scope "/admin", Admin, as: :admin do
        pipe_through([:admin_required])

        resources("/users", UserController)
        get("/show", PageController, :show)

        get("/signals/get_signals_support_count", SignalController, :get_signals_support_count)

        resources("/contact", ContactController, only: [:new, :create, :edit, :update])

        resources("/signals", SignalController)
      end

      ######## MUNICIPALITY ZONE #######

      scope "/municipality" do

        get("/animals", AnimalController, :minicipality_registered)
        get("/filter_registered", AnimalController, :filter_registered)
        get("/animals/shelter", AnimalController, :minicipality_shelter)
        get("/animals/adopted", AnimalController, :minicipality_adopted)
        get("/signals", SignalController, :minicipality_signals)
        get("/filter_signals", SignalController, :filter_signals)
        resources("/signals", SignalController)
        resources("/registered", AnimalController)
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
