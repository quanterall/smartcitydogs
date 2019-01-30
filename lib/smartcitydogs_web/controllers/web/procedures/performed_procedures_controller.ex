defmodule SmartcitydogsWeb.PerformedProcedureController do
  use SmartcitydogsWeb, :controller
  import SmartcitydogsWeb.TemplateResolver
  alias Smartcitydogs.PerformedProcedure

  def create(conn, %{"performed_procedure" => params, "animal_id" => animal_id}) do
    PerformedProcedure.create(Map.put(params, "animal_id", animal_id))

    redirect(conn, to: Routes.animal_path(conn, :index))
  end

  def delete(conn, %{"id" => id}) do
    PerformedProcedure.get(id)
    |> PerformedProcedure.delete()

    redirect(conn, to: Routes.animal_path(conn, :index))
  end
end
