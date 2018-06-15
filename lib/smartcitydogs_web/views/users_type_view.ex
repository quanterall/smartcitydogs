defmodule SmartCityDogsWeb.UsersTypeView do
  use SmartCityDogsWeb, :view
  alias SmartCityDogsWeb.UsersTypeView

  def render("index.json", %{users_types: users_types}) do
    %{data: render_many(users_types, UsersTypeView, "users_type.json")}
  end

  def render("show.json", %{users_type: users_type}) do
    %{data: render_one(users_type, UsersTypeView, "users_type.json")}
  end

  def render("users_type.json", %{users_type: users_type}) do
    %{id: users_type.id,
      name: users_type.name,
      deleted_at: users_type.deleted_at}
  end
end
