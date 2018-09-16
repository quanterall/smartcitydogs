defmodule SmartcitydogsWeb.ForgotenPasswordControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.ForgotenPasswordControllerAPIView

  def render("index.json", %{forgoten_password: users}) do
    %{data: render_many(users, ForgotenPasswordControllerAPIView, "forgoten_password.json")}
  end

  def render("show.json", %{forgoten_password: user}) do
    render("forgoten_password.json", %{forgoten_password: user})
  end

  def render("forgoten_password.json", %{forgoten_password: user}) do
    %{
      id: user.id,
      username: user.username,
      password_hash: user.password_hash,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      phone: user.phone,
      reset_password_token: user.reset_password_token,
      deleted_at: user.deleted_at,
      users_types_id: user.users_types_id
    }
  end

  def render("couldnt_send_token.json", %{forgoten_password: _}) do
    %{error: "Could not send reset email. Please try again later"}
  end

  def render("inv_token.json", %{forgoten_password: _}) do
    %{error: "Invalid reset token."}
  end

  def render("token_exp.json", %{forgoten_password: _}) do
    %{error: "Password token expired."}
  end
end
