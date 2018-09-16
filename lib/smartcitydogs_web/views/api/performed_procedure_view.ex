defmodule SmartcitydogsWeb.PerformedProcedureControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.PerformedProcedureControllerAPIView

  def render("index.json", %{performed_procedure: performed_procedure}) do
    %{
      data:
        render_many(
          performed_procedure,
          PerformedProcedureControllerAPIView,
          "performed_procedure.json"
        )
    }
  end

  def render("show.json", %{performed_procedure: performed_procedure}) do
    %{
      data:
        render_one(
          performed_procedure,
          PerformedProcedureControllerAPIView,
          "performed_procedure.json"
        )
    }
  end

  def render("performed_procedure.json", %{
        performed_procedure_controller_api: performed_procedure
      }) do
    %{
      id: performed_procedure.id,
      date: performed_procedure.date,
      deleted_at: performed_procedure.deleted_at
    }
  end
end
