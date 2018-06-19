defmodule SmartCityDogsWeb.UserView do
  use SmartCityDogsWeb, :view
  alias SmartCityDogsWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      phone: user.phone
    }
  end

  def render("sign_in.json", %{user: user}) do
    %{
      data: %{
        user: %{
          id: user.id,
          email: user.email,
          username: user.username,
          first_name: user.first_name
        }
      }
    }
  end

  def render("logout.json", %{user: user}) do
    %{
      data: %{
        user: %{
          id: user.id,
          email: user.email,
          username: user.username,
          first_name: user.first_name
        }
      }
    }
  end

end
