defmodule SmartcitydogsWeb.ContactController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.Mailer
  alias Smartcitydogs.Email

  @recapcha_pkey Application.fetch_env!(:recaptcha, :public_key)
  @recapcha_secret Application.fetch_env!(:recaptcha, :secret)
  @contact_email Application.fetch_env!(:smartcitydogs, :contact_email)
  def new(conn, _params) do
    render(conn, "new.html", public_key: @recapcha_pkey)
  end

  def send(conn, %{"email" => email} = params) do
    case Recaptcha.verify(params["g-recaptcha-response"], secret: @recapcha_secret) do
      {:ok, _} ->
        Email.send_email(
          @contact_email,
          "Запитване от: " <> email,
          "contact.html",
          params
        )
        |> Mailer.deliver_later()

        conn
        |> put_flash(:info, "Съобщението е изпратено успешно")
        |> redirect(to: Routes.contact_path(conn, :new))

      {:error, _} ->
        conn
        |> put_flash(:error, "Невалиден код против роботи")
        |> render("new.html", public_key: @recapcha_pkey)
    end
  end
end
