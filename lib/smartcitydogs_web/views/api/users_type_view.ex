defmodule SmartcitydogsWeb.UserTypeControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.UserTypeControllerAPIView

  def render("index.json", %{users_types: users_types}) do
    %{data: render_many(users_types, UserTypeControllerAPIView, "users_type.json")}
  end

  def render("show.json", %{users_type: users_type}) do
    %{data: render_one(users_type, UserTypeControllerAPIView, "users_type.json")}
  end

  def render("users_type.json", %{users_type_controller_api: users_type}) do
    %{id: users_type.id, name: users_type.name, deleted_at: users_type.deleted_at}
  end
end
