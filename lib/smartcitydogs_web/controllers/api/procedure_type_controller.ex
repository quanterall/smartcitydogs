defmodule SmartcitydogsWeb.ProcedureTypeControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.ProcedureType
  alias Smartcitydogs.DataProcedure

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    procedure_types = DataProcedure.list_procedure_type()
    render(conn, "index.json", procedure_types: procedure_types)
  end

  def create(conn, %{"procedure_type" => procedure_type_params}) do
    with {:ok, %ProcedureType{} = procedure_type} <-
           DataProcedure.create_procedure_type(procedure_type_params) do
      conn
      |> render("show.json", procedure_type: procedure_type)
    end
  end

  def show(conn, %{"id" => id}) do
    procedure_type = DataProcedure.get_procedure_type!(id)
    render(conn, "show.json", procedure_type: procedure_type)
  end

  def update(conn, %{"id" => id, "procedure_type" => procedure_type_params}) do
    procedure_type = DataProcedure.get_procedure_type!(id)

    with {:ok, %ProcedureType{} = procedure_type} <-
           DataProcedure.update_procedure_type(procedure_type, procedure_type_params) do
      render(conn, "show.json", procedure_type: procedure_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    procedure_type = DataProcedure.get_procedure_type!(id)

    with {:ok, %ProcedureType{}} <- DataProcedure.delete_procedure_type(procedure_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
