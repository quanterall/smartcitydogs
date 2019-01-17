defmodule SmartcitydogsWeb.MySignalView do
  use SmartcitydogsWeb, :view

  def get_signal_images(signal_id) do
    signal =
      Smartcitydogs.DataSignal.get_signal(signal_id)
      |> Smartcitydogs.Repo.preload(:signal_images)

    if signal.signal_images == [] do
      cond do
        signal.signal_category_id == 1 -> "images/stray.jpg"
        signal.signal_category_id == 2 -> "images/escaped.jpg"
        signal.signal_category_id == 3 -> "images/mistreated.jpg"
      end
    else
      cond do
        List.first(signal.signal_images).url == nil && signal.signal_category_id == 1 ->
          "images/stray.jpg"

        List.first(signal.signal_images).url == nil && signal.signal_category_id == 2 ->
          "images/escaped.jpg"

        List.first(signal.signal_images).url == nil && signal.signal_category_id == 3 ->
          "images/mistreated.jpg"
      end

      List.first(signal.signal_images).url
    end
  end
end
