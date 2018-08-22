defmodule SmartcitydogsWeb.MySignalsController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignals

  def index(conn, params) do

    if params == %{} do
      x = 1
    else
      x = String.to_integer(params["page"])
    end

    user = conn.assigns.current_user.id
    sorted_signals = DataSignals.sort_signal_by_id()
    signals = DataSignals.get_user_signal(user)
    
    page = Smartcitydogs.Repo.paginate(sorted_signals, page: x, page_size: 8)
    render(conn, "my_signals.html", signals: signals, page: page)
  end
end
