defmodule SmartcitydogsWeb.PerformedProcedureControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.DataProcedure
  alias Smartcitydogs.PerformedProcedures

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    performed_procedure = DataProcedure.list_performed_procedure()
    render(conn, "index.json", performed_procedure: performed_procedure)
  end

  def create(conn, %{"performed_procedure" => performed_procedure_params}) do
    with {:ok, %PerformedProcedures{} = performed_procedure} <-
      DataProcedure.create_performed_procedure(performed_procedure_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", performed_procedure_controller_api_path(conn, :show, performed_procedure))
      |> render("show.json", performed_procedure: performed_procedure)
    end
  end

  def show(conn, %{"id" => id}) do
    performed_procedure = DataProcedure.get_performed_procedure!(id)
    render(conn, "show.json", performed_procedure: performed_procedure)
  end

  def update(conn, %{"id" => id, "performed_procedure" => performed_procedure_params}) do
    performed_procedure = DataProcedure.get_performed_procedure!(id)

    with {:ok, %PerformedProcedures{} = performed_procedure} <-
      DataProcedure.update_performed_procedure(
             performed_procedure,
             performed_procedure_params
           ) do
      render(conn, "show.json", performed_procedure: performed_procedure)
    end
  end

  def delete(conn, %{"id" => id}) do
    performed_procedure = DataProcedure.get_performed_procedure!(id)

    with {:ok, %PerformedProcedures{}} <-
      DataProcedure.delete_performed_procedure(performed_procedure) do
      send_resp(conn, :no_content, "")
    end
  end
end
