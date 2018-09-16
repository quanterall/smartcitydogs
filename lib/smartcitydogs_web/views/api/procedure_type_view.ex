defmodule SmartcitydogsWeb.ProcedureTypeControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.ProcedureTypeControllerAPIView

  def render("index.json", %{procedure_types: procedure_types}) do
    %{data: render_many(procedure_types, ProcedureTypeControllerAPIView, "procedure_type.json")}
  end

  def render("show.json", %{procedure_type: procedure_type}) do
    %{data: render_one(procedure_type, ProcedureTypeControllerAPIView, "procedure_type.json")}
  end

  def render("procedure_type.json", %{procedure_type_controller_api: procedure_type}) do
    %{id: procedure_type.id, name: procedure_type.name, deleted_at: procedure_type.deleted_at}
  end
end
