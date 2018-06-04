defmodule SmartcitydogsWeb.AnimalController do
    use SmartcitydogsWeb, :controller

    alias Smartcitydogs.DataAnimals
    alias Smartcitydogs.Animals
    alias Smartcitydogs.Repo
    alias Smartcitydogs.Avatar

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
        upload = Map.get(conn, :params)
        IO.inspect(upload) 
        upload = Map.get(upload, "files")
        IO.inspect(upload) 
        #extension = Path.extname(upload.filename)
        #{:error, raison} = File.cp(upload.path, "/home/sonyft/smartcitydog/smartcitydogs/assets/static/images")
        #IO.inspect(raison)
        Avatar.store(upload)
         case DataAnimals.create_animal(animal_params) do
          {:ok, animal} ->
            #IO.inspect(conn)
            conn
            |> put_flash(:info, " Dog wiht chip number #{animal.chip_number} is created!")
            |> redirect(to: animal_path(conn, :index))
      
          {:error, changeset} ->
            render(conn, "new.html", changeset: changeset)
        end
    end

    def show(conn, %{"id" => id}) do
        #animal = Repo.get!(Animals, id) |> Repo.preload(:animals_status)
        animal = DataAnimals.get_animal(id)
        render(conn, "show.html", animals: animal)
    end

    def edit(conn, %{"id" => id}) do
        animal = DataAnimals.get_animal(id)
        changeset = DataAnimals.change_animal(animal)
        render(conn, "edit.html", animals: animal, changeset: changeset)
    end

    def update(conn, %{"id" => id, "animals" => animal_params}) do
        animal = DataAnimals.get_animal(id)
    
        case DataAnimals.update_animal(animal, animal_params) do
          {:ok, animal} ->
            conn
            |> put_flash(:info, "Animal updated successfully.")
            |> redirect(to: animal_path(conn, :show, animal))
    
          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "edit.html", animal: animal, changeset: changeset)
        end
      end

end