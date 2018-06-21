defmodule SmartCityDogsWeb.ProcedureTypeView do
  use SmartCityDogsWeb, :view
  alias SmartCityDogsWeb.ProcedureTypeView

  def render("index.json", %{procedure_types: procedure_types}) do
    %{data: render_many(procedure_types, ProcedureTypeView, "procedure_type.json")}
  end

  def render("show.json", %{procedure_type: procedure_type}) do
    %{data: render_one(procedure_type, ProcedureTypeView, "procedure_type.json")}
  end

  def render("procedure_type.json", %{procedure_type: procedure_type}) do
    %{id: procedure_type.id, name: procedure_type.name, deleted_at: procedure_type.deleted_at}
  end
end
