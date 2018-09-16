defmodule SmartcitydogsWeb.UserView do
  use SmartcitydogsWeb, :view
  alias Smartcitydogs.User

  def user_changeset(conn) do
    if Map.has_key?(conn.assigns, :user_changeset) do
      conn.assigns.user_changeset
    else
      User.changeset(%Smartcitydogs.User{}, %{})
    end
  end
end
