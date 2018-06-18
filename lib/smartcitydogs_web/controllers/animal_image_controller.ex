defmodule SmartCityDogsWeb.AnimalImageController do
  use SmartCityDogsWeb, :controller

  alias SmartCityDogs.AnimalImages
  alias SmartCityDogs.AnimalImages.AnimalImage

  action_fallback SmartCityDogsWeb.FallbackController

  def index(conn, _params) do
    animal_images = AnimalImages.list_animal_images()
    render(conn, "index.json", animal_images: animal_images)
  end

 ## def create(conn, %{"animal_image" => animal_image_params}) do
 ##   with {:ok, %AnimalImage{} = animal_image} <- AnimalImages.create_animal_image(animal_image_params) do
 ##     conn
  ##    |> put_status(:created)
  ##    |> put_resp_header("location", animal_image_path(conn, :show, animal_image))
  ##    |> render("show.json", animal_image: animal_image)
  ##  end
 ## end

  def show(conn, %{"id" => id}) do
    animal_image = AnimalImages.get_animal_image!(id)
    render(conn, "show.json", animal_image: animal_image)
  end

  def update(conn, %{"id" => id, "animal_image" => animal_image_params}) do
    animal_image = AnimalImages.get_animal_image!(id)

    with {:ok, %AnimalImage{} = animal_image} <- AnimalImages.update_animal_image(animal_image, animal_image_params) do
      render(conn, "show.json", animal_image: animal_image)
    end
  end

  def delete(conn, %{"id" => id}) do
    animal_image = AnimalImages.get_animal_image!(id)
    with {:ok, %AnimalImage{}} <- AnimalImages.delete_animal_image(animal_image) do
      send_resp(conn, :no_content, "")
    end
  end
end
