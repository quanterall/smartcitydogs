defmodule SmartCityDogsWeb.Router do
  use SmartCityDogsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SmartCityDogsWeb do
    pipe_through :api

    resources "/signals", SignalController, except: [:new, :edit]
    resources "/signal_images", SignalImageController, except: [:new, :edit]
    resources "/signals_comments", SignalsCommentController, except: [:new, :edit]
    resources "/signals_types", SignalsTypeController, except: [:new, :edit]
    resources "/signals_categories", SignalCategoryController, except: [:new, :edit]
    resources "/signals_likes", SignalsLikeController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
    resources "/contacts", ContactController, except: [:new, :edit]
    resources "/users_types", UsersTypeController, except: [:new, :edit]
  end
end
