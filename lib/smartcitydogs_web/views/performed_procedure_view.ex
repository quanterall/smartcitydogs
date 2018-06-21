defmodule SmartCityDogsWeb.PerformedProcedureView do
  use SmartCityDogsWeb, :view
  alias SmartCityDogsWeb.PerformedProcedureView

  def render("index.json", %{performed_procedure: performed_procedure}) do
    %{data: render_many(performed_procedure, PerformedProcedureView, "performed_procedure.json")}
  end

  def render("show.json", %{performed_procedure: performed_procedure}) do
    %{data: render_one(performed_procedure, PerformedProcedureView, "performed_procedure.json")}
  end

  def render("performed_procedure.json", %{performed_procedure: performed_procedure}) do
    %{
      id: performed_procedure.id,
      date: performed_procedure.date,
      deleted_at: performed_procedure.deleted_at
    }
  end
end
