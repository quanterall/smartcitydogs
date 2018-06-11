defmodule SmartcitydogsWeb.MySignalsController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.Signals
  alias Smartcitydogs.DataUser

  def index(conn, _params) do
    user = conn.assigns.current_user.id
    signals = DataSignals.get_user_signal(user)
    render(conn, "my_signals.html", signals: signals)
  end

  # def my_signals(conn) do
  #   user = conn.assigns.current_user.id
  #   signals = DataSignals.get_user_signal(user)
  #   render("my_signals.html", signals: signals)
  # end
end
