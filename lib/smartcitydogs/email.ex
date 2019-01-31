defmodule Smartcitydogs.Email do
  use Bamboo.Phoenix, view: SmartcitydogsWeb.EmailView
  @from Application.fetch_env!(:smartcitydogs, Smartcitydogs.Mailer)[:username]
  def send_email(email_address, subject, template, params \\ %{}) do
    IO.inspect(params)

    new_email()
    |> to(email_address)
    |> from(@from)
    |> subject(subject)
    |> put_html_layout({SmartcitydogsWeb.LayoutView, "email.html"})
    |> render(template, params)
  end
end
