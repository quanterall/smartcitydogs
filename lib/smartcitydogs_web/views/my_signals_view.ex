defmodule SmartcitydogsWeb.MySignalsView do
  use SmartcitydogsWeb, :view

  def get_signals_images(signal_id) do
    signal =
      Smartcitydogs.DataSignals.get_signal(signal_id)
      |> Smartcitydogs.Repo.preload(:signals_images)

    if signal.signals_images == [] do
      cond do
        signal.signal_category_id == 1 -> "images/stray.jpg"
        signal.signal_category_id == 2 -> "images/escaped.jpg"
        signal.signal_category_id == 3 -> "images/mistreated.jpg"
      end
    else
      cond do
        List.first(signal.signals_images).url == nil && signal.signal_category_id == 1 ->
          "images/stray.jpg"

        List.first(signal.signals_images).url == nil && signal.signal_category_id == 2 ->
          "images/escaped.jpg"

        List.first(signal.signals_images).url == nil && signal.signal_category_id == 3 ->
          "images/mistreated.jpg"
      end

      List.first(signal.signals_images).url
    end
  end
end
