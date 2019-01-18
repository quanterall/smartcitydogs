defmodule SmartcitydogsWeb.AnimalImageControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.AnimalImage
  alias Smartcitydogs.DataAnimal

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    animal_images = DataAnimal.list_animal_images()
    render(conn, "index.json", animal_images: animal_images)
  end

  def create(conn, %{"animal_image" => animal_image_params}) do
    with {:ok, %AnimalImage{} = animal_image} <-
           AnimalImage.create_animal_image(animal_image_params) do
      conn
      |> put_status(:created)
      |> render("show.json", animal_image: animal_image)
    end
  end

  def show(conn, %{"id" => id}) do
    animal_image = DataAnimal.get_animal_image(id)
    render(conn, "show.json", animal_image: animal_image)
  end

  def update(conn, %{"id" => id, "animal_image" => animal_image_params}) do
    animal_image = DataAnimal.get_animal_image(id)

    with {:ok, %AnimalImage{} = animal_image} <-
           DataAnimal.update_animal_image(animal_image, animal_image_params) do
      render(conn, "show.json", animal_image: animal_image)
    end
  end

  def delete(conn, %{"id" => id}) do
    animal_image = DataAnimal.get_animal_image(id)

    with {:ok, %AnimalImage{}} <- DataAnimal.delete_animal_image(animal_image) do
      send_resp(conn, :no_content, "")
    end
  end
end
