defmodule SmartcitydogsWeb.PageView do
  use SmartcitydogsWeb, :view

  def get_signals_images(signals_id) do
    list = Smartcitydogs.DataSignals.get_signal_image_id(signals_id)
    
    if List.first(list) == nil do
      "images/2.jpg"
    else
      List.first(list).url
    end

  end

  def get_csrf_token(conn) do
    Plug.Conn.get_session(conn, :csrf_token)
  end


end
