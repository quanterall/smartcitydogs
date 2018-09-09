defmodule SmartcitydogsWeb.SignalView do
  use SmartcitydogsWeb, :view
  import Scrivener.HTML
  alias Smartcitydogs.Signals

  def signal_changeset(conn) do
    if Map.has_key?(conn.assigns, :signal_changeset) do
      conn.assigns.signal_changeset
    else
      Signals.changeset(%Smartcitydogs.Signals{}, %{})
    end
  end
end
