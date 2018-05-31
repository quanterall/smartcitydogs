defmodule SmartcitydogsWeb.AnimalController do
    use SmartcitydogsWeb, :controller

    alias Smartcitydogs.DataAnimals
    alias Smartcitydogs.Animals
    alias Smartcitydogs.Repo

    def index(conn, _params) do
        animals = DataAnimals.list_animals()
        render(conn, "index.html", animals: animals)
    end

    def new(conn, _params) do
        changeset = Animals.changeset(%Animals{})
        render(conn, "new.html", changeset: changeset)
    end

    def create(conn, %{"animals" => animal_params}) do
        #users = Map.get(changeset, :changes)
        #IO.inspect(users)
        #case Smartcitydogs.DataUsers.create_user(users) do
         case DataAnimals.create_animal(animal_params) do
          {:ok, animal} ->
            IO.inspect(conn)
            conn
            |> put_flash(:info, " Dog wiht chip number #{animal.chip_number} is created!")
            |> redirect(to: animal_path(conn, :index))
      
          {:error, changeset} ->
            render(conn, "new.html", changeset: changeset)
        end
    end
end