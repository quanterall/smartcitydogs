defmodule SmartcitydogsWeb.AnimalImageController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.AnimalImage

  def create(conn, %{"animal_id" => animal_id, "animal_image" => %{"image" => image}}) do
    path = AnimalImage.store_image(image)
    AnimalImage.create(%{"animal_id" => animal_id, "url" => path})
    redirect(conn, to: Routes.animal_path(conn, :index))
  end

  def delete(conn, %{"id" => id}) do
    AnimalImage.get(id)
    |> AnimalImage.delete()

    redirect(conn, to: Routes.animal_path(conn, :index))
  end
end
