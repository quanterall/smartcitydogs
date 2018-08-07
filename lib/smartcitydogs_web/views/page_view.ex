defmodule SmartcitydogsWeb.PageView do
  use SmartcitydogsWeb, :view

  def get_signals_images(signals_id) do
    list = Smartcitydogs.DataSignals.get_signal_image_id(signals_id)

    if list != [] do
      [head | tail] = list
      
      head.url
    end
  end

  def get_csrf_token(conn) do
    Plug.Conn.get_session(conn, :csrf_token)
  end

end
