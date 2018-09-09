defmodule SmartcitydogsWeb.UserView do
  use SmartcitydogsWeb, :view
  alias Smartcitydogs.User

  def user_changeset(conn) do
    if Map.has_key?(conn.assigns, :signal_changeset) do
      conn.assigns.signal_changeset
    else
      User.changeset(%Smartcitydogs.User{}, %{})
    end
  end
end
