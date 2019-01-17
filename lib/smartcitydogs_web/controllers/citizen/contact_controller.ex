defmodule SmartcitydogsWeb.ContactController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Email

  def new(conn, _params) do
    {:system, public_key} = Application.get_env(:recaptcha, :public_key)
    render(conn, "new.html", public_key: public_key)
  end

  def create(conn, params) do
    {:system, secret} = Application.get_env(:recaptcha, :secret)

    case Recaptcha.verify(params["g-recaptcha-response"], secret: secret) do
      {:ok, _} ->
        params =
          if conn.assigns.current_user != nil do
            params
            |> Map.put("first_name", conn.assigns.current_user.first_name)
            |> Map.put("last_name", conn.assigns.current_user.last_name)
            |> Map.put("phone", conn.assigns.current_user.phone)
          end

        Email.send_contact_email(params)
        |> Smartcitydogs.Mailer.deliver_now()

        conn
        |> redirect(to: page_path(conn, :new))
        |> put_flash(:info, "Съобщението е изпратено успешно")

      {:error, _} ->
        conn
        |> put_flash(:error, "Невалиден код против роботи")
        |> redirect(to: contact_path(conn, :new))
    end
  end
end
