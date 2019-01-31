defmodule SmartcitydogsWeb.Api.AnimalController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Animal

  def index(conn, params) do
    animals =
      Animal.get_all_preloaded(params)
      |> SmartcitydogsWeb.Encoder.struct_to_map()

    json(conn, animals)
  end

  def show(conn, %{"id" => id}) do
    case Animal.get_preloaded(id) do
      nil ->
        wrong_animal_id(conn, id)

      animal ->
        json(conn, SmartcitydogsWeb.Encoder.struct_to_map(animal))
    end
  end

  defp wrong_animal_id(conn, id) do
    json(conn, %{error: "There is no animal with id: " <> id})
  end
end
