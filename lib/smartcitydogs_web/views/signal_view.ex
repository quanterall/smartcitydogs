defmodule SmartcitydogsWeb.SignalView do
  use SmartcitydogsWeb, :view
  import Scrivener.HTML

  def get_signals_images(signals_id) do
    signal =
      Smartcitydogs.DataSignals.get_signal(signals_id)
      |> Smartcitydogs.Repo.preload(:signal_images)

    cond do
      signal.signal_images == [] ->
        cond do
          signal.signals_categories_id == 1 -> "images/stray.jpg"
          signal.signals_categories_id == 2 -> "images/escaped.jpg"
          signal.signals_categories_id == 3 -> "images/mistreated.jpg"
        end

      List.first(signal.signal_images).url == nil ->
        cond do
          signal.signals_categories_id == 1 -> "images/stray.jpg"
          signal.signals_categories_id == 2 -> "images/escaped.jpg"
          signal.signals_categories_id == 3 -> "images/mistreated.jpg"
        end

      true ->
        List.first(signal.signal_images).url
    end
  end

  def get_all_signals(user_id) do
    list = Smartcitydogs.DataSignals.get_user_signal(user_id)
    list
  end

  def get_all_comments(signals_id) do
    list = Smartcitydogs.DataSignals.get_comment_signal_id(signals_id)
    list
  end

  def get_comment_signal_id(signals_id) do
    Smartcitydogs.DataSignals.get_comment_signal_id(signals_id)
  end

  def get_signals_view_count(signal_id) do
    list = Smartcitydogs.DataSignals.get_signal_support_count(signal_id)

    if list != [] do
      [head | _] = list
      count = head.view_count
      Smartcitydogs.DataSignals.update_signal(head, %{view_count: count + 1})
      head.view_count + 1
    end
  end
end
