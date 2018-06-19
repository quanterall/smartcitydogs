defmodule SmartCityDogs.Email do
  use Bamboo.Phoenix, view: App.FeedbackView

  def send_reset_email(to_email, token) do
    new_email()
    |> to(to_email)
    |> from(System.get_env("FROM_EMAIL"))
    |> subject("Reset Password Instructions")
    |> text_body("Please visit #{System.get_env("USER_IP")}:4000/forgoten_password/#{token}/edit to reset your password")
  end

  def send_contact_email(user, from_email) do
  ##  IO.inspect from_email
  ##  IO.inspect user
    new_email()
    |> to(System.get_env("SMTP_USERNAME"))
    |> from(from_email)
    |> subject(Enum.at(user.contact ,0).topic)
    |> text_body("Text is #{Enum.at(user.contact ,0).text} \n\n\n\n Sent from #{user.first_name} #{user.last_name}, phone: #{user.phone}")
  end

  def send_unauth_contact_email(topic, text, user_data) do
    new_email()
    |> to(System.get_env("SMTP_USERNAME"))
    |> from(System.get_env("SMTP_USERNAME"))
    |> subject(topic)
    |> text_body("Text is #{text}  \n\n\n\n Sent from #{user_data["first_name"]} #{user_data["last_name"]}, phone:#{user_data["phone"]}")
  end

end
