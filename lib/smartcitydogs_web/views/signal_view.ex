defmodule SmartcitydogsWeb.SignalView do
  use SmartcitydogsWeb, :view
  import Scrivener.HTML
  alias Smartcitydogs.Signal

  def signal_changeset(conn) do
    if Map.has_key?(conn.assigns, :signal_changeset) do
      conn.assigns.signal_changeset
    else
      Signal.changeset(%Smartcitydogs.Signal{}, %{})
    end
  end
end
