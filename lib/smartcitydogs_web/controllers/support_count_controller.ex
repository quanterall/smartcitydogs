defmodule SmartcitydogsWeb.SupportCountController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignal

  def get_signal_support_count(conn, %{"id" => id}) do
    signal = DataSignal.get_signal(id)

    DataSignal.update_signal(signal, %{support_count: signal.support_count + 1})
    redirect(conn, to: signal_path(conn, :show, signal))
  end
end
