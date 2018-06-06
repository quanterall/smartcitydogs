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
end
