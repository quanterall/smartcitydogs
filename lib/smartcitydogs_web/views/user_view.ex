defmodule SmartCityDogsWeb.UserView do
  use SmartCityDogsWeb, :view
  alias SmartCityDogsWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      password_hash: user.password_hash,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      phone: user.phone,
      reset_password_token: user.reset_password_token,
      reset_password_token_sent_at: user.reset_password_token_sent_at,
      deleted_at: user.deleted_at,
      contact_id: user.contact_id,
      users_types_id: user.users_types_id}
  end
end
