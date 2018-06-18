defmodule SmartCityDogsWeb.PerformedProcedureController do
  use SmartCityDogsWeb, :controller

  alias SmartCityDogs.PerformedProcedures
  alias SmartCityDogs.PerformedProcedures.PerformedProcedure

  action_fallback SmartCityDogsWeb.FallbackController

  def index(conn, _params) do
    performed_procedure = PerformedProcedures.list_performed_procedure()
    render(conn, "index.json", performed_procedure: performed_procedure)
  end

  def create(conn, %{"performed_procedure" => performed_procedure_params}) do
    with {:ok, %PerformedProcedure{} = performed_procedure} <- PerformedProcedures.create_performed_procedure(performed_procedure_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", performed_procedure_path(conn, :show, performed_procedure))
      |> render("show.json", performed_procedure: performed_procedure)
    end
  end

  def show(conn, %{"id" => id}) do
    performed_procedure = PerformedProcedures.get_performed_procedure!(id)
    render(conn, "show.json", performed_procedure: performed_procedure)
  end

  def update(conn, %{"id" => id, "performed_procedure" => performed_procedure_params}) do
    performed_procedure = PerformedProcedures.get_performed_procedure!(id)

    with {:ok, %PerformedProcedure{} = performed_procedure} <- PerformedProcedures.update_performed_procedure(performed_procedure, performed_procedure_params) do
      render(conn, "show.json", performed_procedure: performed_procedure)
    end
  end

  def delete(conn, %{"id" => id}) do
    performed_procedure = PerformedProcedures.get_performed_procedure!(id)
    with {:ok, %PerformedProcedure{}} <- PerformedProcedures.delete_performed_procedure(performed_procedure) do
      send_resp(conn, :no_content, "")
    end
  end
end
