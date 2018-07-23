defmodule SmartcitydogsWeb.UserControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.UserControllerAPIView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserControllerAPIView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserControllerAPIView, "user.json")}
  end

  def render("user.json", %{user_controller_api: user}) do
    %{
      id: user.id,
      username: user.username,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      phone: user.phone,
      reset_password_token: user.reset_password_token,
      ##  reset_password_token_sent_at: user.reset_password_token_sent_at,
      deleted_at: user.deleted_at,
      users_types_id: user.users_types_id
    }
  end

  def render("sign_in.json", %{user: user}) do
    %{
      data: %{
        user: %{
          id: user.id,
          email: user.email,
          username: user.username,
          first_name: user.first_name,
        }
      }
    }
  end

  def render("municipality_sign_in.json", %{user: user}) do
    %{
      users_types_id: user.users_types_id,
     }
  end

  def render("logout.json", _) do
    %{
      data: %{
        message: "successfully logged out"
      }
    }
  end
end
