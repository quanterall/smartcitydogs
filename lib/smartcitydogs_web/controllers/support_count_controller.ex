defmodule SmartcitydogsWeb.SupportCountController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignals

  def get_signals_support_count(conn, %{"id" => id}) do
    signal = DataSignals.get_signal(id)

    DataSignals.update_signal(signal, %{support_count: signal.support_count + 1})
    redirect(conn, to: signal_path(conn, :show, signal))
  end
end