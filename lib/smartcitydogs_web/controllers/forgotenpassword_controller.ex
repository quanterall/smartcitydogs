defmodule SmartcitydogsWeb.ForgotenPasswordController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.User
  alias Smartcitydogs.Repo
  # Timex is a library you can use to easily change the date for checking expiry
  use Timex

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset, action: forgoten_password_path(conn, :create))
  end

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
        conn
        |> put_flash(:error, "Could not send reset email. Please try again later")
        |> redirect(to: forgoten_password_path(conn, :new))

      user ->
        user = reset_password_token(user)
        email = Map.get(user, :email)

        Smartcitydogs.Email.send_reset_email(email, user.reset_password_token)
        |> Smartcitydogs.Mailer.deliver_now()


        redirect(conn, to: session_path(conn, :new))

        put_flash(
          conn,
          :info,
          "If your email address exists in our database, you will receive a password reset link at your email address in a few minutes."
        )
    end
  end

  def edit(conn, %{"id" => token}) do
    user =
      User
      |> Repo.get_by(reset_password_token: token)

    case user do
      nil ->
        conn
        |> put_flash(:error, "Invalid reset token")
        |> redirect(to: forgoten_password_path(conn, :new))

      user ->
        if expired?(user.reset_token_sent_at) do
          # could set reset fields to nil here
          User.password_token_changeset(user, %{
            reset_password_token: nil,
            reset_token_sent_at: nil
          })
          |> Repo.update!()

          conn
          |> put_flash(:error, "Password reset token expired")
          |> redirect(to: forgoten_password_path(conn, :new))
        else
          changeset = User.changeset(%User{})

          conn
          |> render("edit.html", changeset: changeset, token: token)
        end
    end
  end

  def update(conn, %{"id" => token, "user" => pw_params}) do
    user =
      User
      |> Repo.get_by(reset_password_token: token)



    case user do
      nil ->
        conn
        |> put_flash(:error, "Invalid reset token")
        |> redirect(to: forgoten_password_path(conn, :new))

      user ->
        if expired?(user.reset_token_sent_at) do
          User.password_token_changeset(user, %{
            reset_password_token: nil,
            reset_token_sent_at: nil
          })
          |> Repo.update!()

          conn
          |> put_flash(:error, "Password reset token expired")
          |> redirect(to: forgoten_password_path(conn, :new))
        else
          changeset = User.registration_changeset(user, pw_params)

          case Repo.update(changeset) do
            {:ok, _user} ->
              User.password_token_changeset(user, %{
                reset_password_token: nil,
                reset_token_sent_at: nil
              })

              changeset
              |> Repo.update!()

              conn
              |> put_flash(:info, "Password reset successfully!")
              |> redirect(to: forgoten_password_path(conn, :new))

            {:error, changeset} ->
              conn
              |> render("edit.html", changeset: changeset, token: token)
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
