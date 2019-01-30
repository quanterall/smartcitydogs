defmodule SmartcitydogsWeb.TemplateResolver do
  def get_template_name(conn, template) do
    Guardian.Plug.current_resource(conn)
    |> case do
      %{user_type: "citizen"} -> template
      %{user_type: type} -> "#{type}_#{template}"
      _ -> template
    end
  end
end
