defmodule SmartCityDogsWeb.Router do
  use SmartCityDogsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SmartCityDogsWeb do
    pipe_through :api
    resources "/performed_procedure", PerformedProcedureController, except: [:new, :edit]
    resources "/animal_statuses", AnimalStatusController, except: [:new, :edit]
    resources "/animal_images", AnimalImageController, except: [:new, :edit]
    resources "/rescues", RescueController, except: [:new, :edit]
    resources "/procedure_types", ProcedureTypeController, except: [:new, :edit]
    resources "/animals", AnimalController, except: [:new, :edit]
    resources "/header_slides", HeaderSlideController, except: [:new, :edit]
    resources "/news", NewsSchemaController, except: [:new, :edit]
    resources "/static_pages", StaticPageController, except: [:new, :edit]

  end
end
