defmodule SmartcitydogsWeb.PageView do
  use SmartcitydogsWeb, :view

  def get_signals_images(signals_id) do
    signal =
      Smartcitydogs.DataSignals.get_signal(signals_id)
      |> Smartcitydogs.Repo.preload(:signals_images)

    if signal.signals_images == [] do
      cond do
        signal.signals_categories_id == 1 -> "images/stray.jpg"
        signal.signals_categories_id == 2 -> "images/escaped.jpg"
        signal.signals_categories_id == 3 -> "images/mistreated.jpg"
      end
    else
      cond do
        List.first(signal.signals_images).url == nil && signal.signals_categories_id == 1 ->
          "images/stray.jpg"

        List.first(signal.signals_images).url == nil && signal.signals_categories_id == 2 ->
          "images/escaped.jpg"

        List.first(signal.signals_images).url == nil && signal.signals_categories_id == 3 ->
          "images/mistreated.jpg"

        true ->
          List.first(signal.signals_images).url
      end
    end
  end

  def get_csrf_token(conn) do
    Plug.Conn.get_session(conn, :csrf_token)
  end
end
