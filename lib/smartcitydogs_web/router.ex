defmodule SmartCityDogsWeb.Router do
  use SmartCityDogsWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
  end

  pipeline :api_auth do
    plug(:ensure_authenticated)
  end

  scope "/api", SmartCityDogsWeb do
    pipe_through(:api)

    post("/users/sign_in", UserController, :sign_in)
    resources("/users", UserController, only: [:create])

    end

  scope "/api", SmartCityDogsWeb do
    pipe_through([:api, :api_auth])
    resources("/users", UserController, except: [:new, :edit])
    post("/users/logout", UserController, :logout)

    resources("/signals", SignalController, except: [:new, :edit])
    resources("/signal_images", SignalImageController, except: [:new, :edit])
    resources("/signals_comments", SignalsCommentController, except: [:new, :edit])
    resources("/signals_types", SignalsTypeController, except: [:new, :edit])
    resources("/signals_categories", SignalCategoryController, except: [:new, :edit])
    resources("/signals_likes", SignalsLikeController, except: [:new, :edit])
    resources("/users", UserController, except: [:new, :edit])
    resources("/contacts", ContactController, except: [:new, :edit])
    resources("/users_types", UsersTypeController, except: [:new, :edit])
    resources("/performed_procedure", PerformedProcedureController, except: [:new, :edit])
    resources("/animal_statuses", AnimalStatusController, except: [:new, :edit])
    resources("/animal_images", AnimalImageController, except: [:new, :edit])
    resources("/rescues", RescueController, except: [:new, :edit])
    resources("/procedure_types", ProcedureTypeController, except: [:new, :edit])
    resources("/animals", AnimalController, except: [:new, :edit])
    resources("/header_slides", HeaderSlideController, except: [:new, :edit])
    resources("/news", NewsSchemaController, except: [:new, :edit])
    resources("/static_pages", StaticPageController, except: [:new, :edit])
  
  end
  scope "/auth", SmartCityDogsWeb do
    pipe_through(:api)
    get("/:provider", UserController, :request)
    get("/:provider/callback", UserController, :callback)
  end

  # Plug function
  defp ensure_authenticated(conn, _opts) do
    current_user_id = get_session(conn, :current_user_id)
    IO.puts "Authentication!"
    IO.inspect current_user_id
    if current_user_id do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> render(SmartCityDogsWeb.ErrorView, "401.json", message: "Unauthenticated user")
      |> halt()
    end
  end

end
