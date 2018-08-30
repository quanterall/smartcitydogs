defmodule SmartcitydogsWeb.ContactController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.User
  alias Smartcitydogs.DataUsers
  alias Smartcitydogs.Email

  def index(conn, _params) do
    changeset = User.changeset(%User{})

    with :ok <-
           Bodyguard.permit(
             Smartcitydogs.Contact.Policy,
             :index,
             conn.assigns.current_user
           ) do
      if conn.assigns.current_user != nil do
        changeset = User.changeset(conn.assigns.current_user)
        id = conn.assigns.current_user.id
        
        render(conn, "newcontact.html",
          changeset: changeset,
          action: contact_path(conn, :update, id)
        )
      else
        render(conn, "newcontact.html",
          changeset: changeset,
          action: contact_path(conn, :create)
        )
      end
    end
    render(conn, "newcontact.html",
    changeset: changeset,
    action: contact_path(conn, :create)
  )
  end

  ## Render the two different forms based on logged or not user.
  def new(conn, _params) do
    changeset = User.changeset(%User{})

    with :ok <-
           Bodyguard.permit(
             Smartcitydogs.Contact.Policy,
             :new,
             conn.assigns.current_user
           ) do
      if conn.assigns.current_user != nil do
        changeset = User.changeset(conn.assigns.current_user)
        id = conn.assigns.current_user.id

        render(conn, "newcontact.html",
          changeset: changeset,
          action: contact_path(conn, :update, id)
        )
      else
        render(conn, "newcontact.html", changeset: changeset, action: contact_path(conn, :create))
      end
    end
  end

  ## When a not logged in user sneds email
  def create(conn, params) do
    {:system, secret} = Application.get_env(:recaptcha, :secret)

    with :ok <-
           Bodyguard.permit(
             Smartcitydogs.Contact.Policy,
             :create,
             conn.assigns.current_user
           ) do
      case Recaptcha.verify(params["g-recaptcha-response"], secret: secret) do
        {:ok, _} ->
          user_params = Map.get(params, "user")
          topic = Map.get(user_params, "topic")
          text = Map.get(user_params, "text")

          Email.send_unauth_contact_email(topic, text, user_params)
          |> Smartcitydogs.Mailer.deliver_now()

          redirect(conn, to: page_path(conn, :index))

        {:error, _} ->
          redirect(conn, to: contact_path(conn, :index))
      end
    end
  end

  def edit(conn, %{"id" => id}) do
    user = DataUsers.get_user!(id)
    changeset = DataUsers.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  ## When a logged in user sneds email
  def update(conn, %{"id" => id, "user" => user_params}) do
    topic = Map.get(user_params, "topic")
    text = Map.get(user_params, "text")

    with :ok <-
           Bodyguard.permit(
             Smartcitydogs.Contact.Policy,
             :update,
             conn.assigns.current_user
           ) do
      contact_map = %{topic: topic, text: text, users_id: id}
      DataUsers.create_contact(contact_map)
      user_sender = DataUsers.get_user!(id)

      Email.send_contact_email(user_sender, contact_map)
      |> Smartcitydogs.Mailer.deliver_now()

      redirect(conn, to: page_path(conn, :index))
    end
  end
end
