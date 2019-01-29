defmodule SmartcitydogsWeb.Api.StatisticController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Guardian
  alias Smartcitydogs.Signal
  alias Smartcitydogs.Animal

  def count(conn, _) do
    %{id: id} = Guardian.Plug.current_resource(conn)

    data = %{
      all_signals: Signal.get_count(),
      user_signals: Signal.get_count_by_user_id(id),
      animals: Animal.get_count()
    }

    json(conn, data)
  end
end
