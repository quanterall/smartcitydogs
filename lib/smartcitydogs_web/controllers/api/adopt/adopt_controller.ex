defmodule SmartcitydogsWeb.Api.AdoptController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.{Animal, Adopt, User, Mailer, Email}

  @contact_email Application.fetch_env!(:smartcitydogs, :contact_email)
  def create(conn, %{"animal_id" => animal_id} = params) do
    user = Guardian.Plug.current_resource(conn)

    animal = Smartcitydogs.Animal.get(animal_id)

    if !Adopt.exist(animal, user) do
      params
      |> Map.put("user_id", user.id)
      |> Adopt.create()

      Email.send_email(
        @contact_email,
        "Запитване за осиновяване от: " <> user.email,
        "adopt.html",
        user: user,
        animal: animal
      )
      |> Mailer.deliver_later()

      json(conn, %{success: "Adopt is created and email is send!"})
    else
      json(conn, %{error: "You can't adopt twice!"})
    end
  end
end
