defmodule SmartcitydogsWeb.SignalView do
  use SmartcitydogsWeb, :view

  def get_signals_images(signals_id) do
    list = Smartcitydogs.DataSignals.get_signal_image_id(signals_id)

    if list != [] do
      [head | tail] = list
      IO.inspect(head)
      head.url
    end

  end

  def get_signals_support_count(signal_id) do
    list = Smartcitydogs.DataSignals.get_signal_support_count(signal_id)
    IO.inspect(list)
    IO.puts "----------------------------"
    if list != [] do
      #IO.inspect(list)
      [head | tail] = list
      IO.inspect(head)
      #count = head.count
      #IO.inspect(count)
      count = head.support_count
      IO.inspect(count)
      IO.puts "---------------------------------------"
      Smartcitydogs.DataSignals.update_signal(head,%{support_count: count+1})
    end
  end
end
