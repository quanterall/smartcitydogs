defmodule SmartcitydogsWeb.MySignalsController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignals

  def index(conn, params) do
    page_num =
      if params == %{} do
        1
      else
        String.to_integer(params["page"])
      end

    user = conn.assigns.current_user.id
    signals = DataSignals.get_user_signal(user)

    page = Smartcitydogs.Repo.paginate(signals, page: page_num, page_size: 9)
    render(conn, "my_signals.html", signals: signals, page: page)
  end
end
