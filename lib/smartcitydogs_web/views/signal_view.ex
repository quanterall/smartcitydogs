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



  def get_signals_view_count(signal_id) do
    list = Smartcitydogs.DataSignals.get_signal_support_count(signal_id)

    if list != [] do
      [head | tail] = list
      count = head.view_count
      IO.inspect(count)
      IO.puts "---------------------------------------"
      Smartcitydogs.DataSignals.update_signal(head,%{view_count: count+1})
      views = head.view_count + 1
      IO.puts "________________________VIEWS________________________"
      IO.inspect(views)
      IO.puts "_________________________________________________"

    end
    IO.inspect(views)
    views
  end
end
