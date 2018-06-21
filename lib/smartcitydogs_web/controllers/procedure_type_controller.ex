defmodule SmartCityDogsWeb.ProcedureTypeController do
  use SmartCityDogsWeb, :controller

  alias SmartCityDogs.ProcedureTypes
  alias SmartCityDogs.ProcedureTypes.ProcedureType

  action_fallback(SmartCityDogsWeb.FallbackController)

  def index(conn, _params) do
    procedure_types = ProcedureTypes.list_procedure_types()
    render(conn, "index.json", procedure_types: procedure_types)
  end

  def create(conn, %{"procedure_type" => procedure_type_params}) do
    with {:ok, %ProcedureType{} = procedure_type} <-
           ProcedureTypes.create_procedure_type(procedure_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", procedure_type_path(conn, :show, procedure_type))
      |> render("show.json", procedure_type: procedure_type)
    end
  end

  def show(conn, %{"id" => id}) do
    procedure_type = ProcedureTypes.get_procedure_type!(id)
    render(conn, "show.json", procedure_type: procedure_type)
  end

  def update(conn, %{"id" => id, "procedure_type" => procedure_type_params}) do
    procedure_type = ProcedureTypes.get_procedure_type!(id)

    with {:ok, %ProcedureType{} = procedure_type} <-
           ProcedureTypes.update_procedure_type(procedure_type, procedure_type_params) do
      render(conn, "show.json", procedure_type: procedure_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    procedure_type = ProcedureTypes.get_procedure_type!(id)

    with {:ok, %ProcedureType{}} <- ProcedureTypes.delete_procedure_type(procedure_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
