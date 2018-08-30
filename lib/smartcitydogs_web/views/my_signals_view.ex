defmodule SmartcitydogsWeb.MySignalsView do
  use SmartcitydogsWeb, :view

  def get_signals_images(signals_id) do
    list = Smartcitydogs.DataSignals.get_signal_image_id(signals_id)
    List.first(list).url
    
  end
end
