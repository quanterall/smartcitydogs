defmodule SmartcitydogsWeb.PageView do
  use SmartcitydogsWeb, :view

  def get_signals_images(signals_id) do
    signal = Smartcitydogs.DataSignals.get_signal(signals_id) |> Smartcitydogs.Repo.preload(:signal_images)
    if signal.signal_images == [] do
      cond do
        signal.signals_categories_id == 1 -> "images/stray.jpg"
        signal.signals_categories_id == 2 -> "images/escaped.jpg"
        signal.signals_categories_id == 3 -> "images/mistreated.jpg"
      end
    else
      cond do
        List.first(signal.signal_images).url == nil &&  signal.signals_categories_id == 1 -> "images/stray.jpg"
        List.first(signal.signal_images).url == nil &&  signal.signals_categories_id == 2 -> "images/escaped.jpg"
        List.first(signal.signal_images).url == nil &&  signal.signals_categories_id == 3 ->  "images/mistreated.jpg"
      end
      List.first(signal.signal_images).url 
    end
  end

  def get_csrf_token(conn) do
    Plug.Conn.get_session(conn, :csrf_token)
  end


end
