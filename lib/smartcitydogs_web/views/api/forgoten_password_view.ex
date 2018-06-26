defmodule SmartcitydogsWeb.ForgotenPasswordControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.ForgotenPasswordControllerAPIView

  def render("index.json", %{forgoten_password: users}) do
    %{data: render_many(users, ForgotenPasswordControllerAPIView, "forgoten_password.json")}
  end

  def render("show.json", %{forgoten_password: user}) do
    IO.puts "//////"
    render("forgoten_password.json", %{forgoten_password: user})
  ##  %{data: render_one(user, ForgotenPasswordControllerAPIView, "forgoten_password.json")}
  end

  def render("forgoten_password.json", %{forgoten_password: user}) do
    IO.puts "*********"
    %{
      id: user.id,
      username: user.username,
      password_hash: user.password_hash,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      phone: user.phone,
      reset_password_token: user.reset_password_token,
     ## reset_password_token_sent_at: user.reset_password_token_sent_at,
      deleted_at: user.deleted_at,
      users_types_id: user.users_types_id
    }
  end

  def render("couldnt_send_token.json", %{forgoten_password: user}) do
    %{error: "Could not send reset email. Please try again later"}
  end

  def render("inv_token.json", %{forgoten_password: user}) do
    %{error: "Invalid reset token."}
  end

  def render("token_exp.json", %{forgoten_password: user}) do
    %{error: "Password token expired."}
  end
end
