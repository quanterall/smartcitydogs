defmodule SmartcitydogsWeb.ForgotenPasswordControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Repo
  alias Smartcitydogs.Email
  alias Smartcitydogs.Mailer
  alias Smartcitydogs.User
  alias Smartcitydogs.Repo
  # Timex is a library you can use to easily change the date for checking expiry
  use Timex

  def create(conn, %{"user" => pw_params}) do
    email = pw_params["email"]
    phone = pw_params["phone"]
    username = pw_params["username"]
    user =
      cond do
        String.trim(email) != "" ->
          User
          |> Repo.get_by(email: email)

        String.trim(phone) != "" ->
          User
          |> Repo.get_by(phone: phone)

        String.trim(username) != "" ->
          User
          |> Repo.get_by(username: username)

        true ->
          nil
      end

    case user do
      nil ->
        IO.puts("Could not send reset email. Please try again later")
        render(conn, "couldnt_send_token.json", forgoten_password: user)

      user ->
        user = reset_password_token(user)
        email = Map.get(user, :email)

        Email.send_reset_email(email, user.reset_password_token)
        |> Mailer.deliver_now()
        render(conn, "show.json", forgoten_password: user)
    end
  end

  def edit(conn, %{"id" => token}) do
    user =
      User
      |> Repo.get_by(reset_password_token: token)

    case user do
      nil ->
        IO.puts("Invalid reset token")
        render(conn, "inv_token.json", forgoten_password: user)

      user ->
        if expired?(user.reset_token_sent_at) do
          # could set reset fields to nil here
          User.password_token_changeset(user, %{
            reset_password_token: nil,
            reset_token_sent_at: nil
          })
          |> Repo.update!()
        else
        end
    end
  end

  def update(conn, %{"id" => token, "user" => pw_params}) do
    user =
      User
      |> Repo.get_by(reset_password_token: token)

    case user do
      nil ->
        IO.puts("Invalid reset token")

      user ->
        if expired?(user.reset_token_sent_at) do
          User.password_token_changeset(user, %{
            reset_password_token: nil,
            reset_token_sent_at: nil
          })
          |> Repo.update!()

          IO.puts("Password reset token expired")
          render(conn, "token_exp.json", forgoten_password: user)
        else
          changeset = User.register_changeset(user, pw_params)

          case Repo.update(changeset) do
            {:ok, _user} ->
              User.password_token_changeset(user, %{
                reset_password_token: nil,
                reset_token_sent_at: nil
              })

              changeset
              |> Repo.update!()
          end
        end
    end
  end

  # sets the token & sent at in the database for the user
  defp reset_password_token(user) do
    token = random_string(48)
    sent_at = DateTime.utc_now()

    user
    |> User.changeset(%{reset_password_token: token, reset_token_sent_at: sent_at})
    |> Repo.update!()
  end

  # sets the token to a random string or whatever length is input
  defp random_string(length) do
    length
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64()
    |> binary_part(0, length)
  end

  # checks if now is later than 1 day from the reset_token_sent_at
  defp expired?(datetime) do
    Timex.after?(Timex.now(), Timex.shift(datetime, days: 1))
  end
end
