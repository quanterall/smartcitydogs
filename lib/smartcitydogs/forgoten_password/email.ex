defmodule Smartcitydogs.Email do
  use Bamboo.Phoenix, view: App.FeedbackView

  def send_reset_email(to_email, token) do
    new_email()
    |> to(to_email)
    |> from(System.get_env("FROM_EMAIL"))
    |> subject("Reset Password Instructions")
    |> text_body(
      "Please visit #{System.get_env("USER_IP")}:4000/forgoten_password/#{token}/edit to reset your password"
    )
  end

  def send_contact_email(user, contact_params) do
    text = contact_params.text

    new_email()
    |> to("smartcitydogs@gmail.com")
    |> from(user.email)
    |> subject(contact_params.topic)
    |> text_body("Запитване:
       #{text} \n\n\n\n 
       Изпратено от: #{user.first_name} #{user.last_name}, 
       телефонен номер: #{user.phone}")
  end

  def send_adopt_email(animal, user) do
    new_email()
    |> to("smartcitydogs@gmail.com")
    |> from(user.email)
    |> subject("Заявка за осиновяване.")
    |> text_body("
      Желая да осиновя куче с номер на чипа: #{animal.chip_number} .

      Данни:

      Име: #{user.first_name},
      Фамилия: #{user.last_name},
      Имейл: #{user.email},
      Телефонен номер: #{user.phone}
      ")
    |> Smartcitydogs.Mailer.deliver_now()
  end

  def send_unauth_contact_email(topic, text, user_data) do
    new_email()
    |> to(System.get_env("SMTP_USERNAME"))
    |> from(System.get_env("SMTP_USERNAME"))
    |> subject(topic)
    |> text_body("Запитване:
       #{text}  \n\n\n\n 
       Изпратено от: #{user_data["first_name"]} #{user_data["last_name"]},
       телефонен номер: #{user_data["phone"]}")
  end
end
