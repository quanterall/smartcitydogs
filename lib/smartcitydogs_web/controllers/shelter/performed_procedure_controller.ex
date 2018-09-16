defmodule SmartcitydogsWeb.Shelter.PerformedProcedureController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.{
    Signals,
    Repo,
    SignalsFilters,
    Animals,
    AnimalsFilters,
    PerformedProcedures
  }

  import Ecto.Query

  def create(conn, %{"performed_procedures" => performed_procedures_params} = params) do
    PerformedProcedures.create_procedure(performed_procedures_params)

    conn
    |> redirect(to: shelter_animal_path(conn, :index))
  end

  def delete(conn, %{"id" => id}) do
    PerformedProcedures
    |> Repo.get(id)
    |> Repo.delete()

    conn
    |> redirect(to: NavigationHistory.last_path(conn, []))
  end
end
