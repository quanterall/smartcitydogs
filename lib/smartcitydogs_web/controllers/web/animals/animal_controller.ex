defmodule SmartcitydogsWeb.AnimalController do
  use SmartcitydogsWeb, :controller
  import SmartcitydogsWeb.TemplateResolver
  alias Smartcitydogs.{Animal, Converter, AnimalStatus, ProcedureType}
  alias Smartcitydogs.Converter

  def index(conn, params) do
    filters = Map.get(params, "animal_filter", %{})
    page = Animal.paginate_preloaded(params, filters)
    keyword_params = params |> Map.delete("page") |> Converter.to_keyword_list()

    animal_statuses =
      AnimalStatus.get_all()
      |> Enum.map(fn status -> {status.name, status.id} end)

    procedure_types =
      ProcedureType.get_all()
      |> Enum.map(fn procedure_type -> [key: procedure_type.name, value: procedure_type.id] end)

    render(conn, get_template_name(conn, "index.html"),
      page: page,
      params: keyword_params,
      procedure_types: procedure_types,
      animal_statuses: [{"Всички", ""}] ++ animal_statuses
    )
  end

  def show(conn, %{"id" => id}) do
    animal = Animal.get_preloaded(id)
    render(conn, "show.html", animal: animal)
  end

  def edit(conn, %{"id" => id}) do
    animal = Animal.get_preloaded(id)
    changeset = Animal.changeset(animal)
    render(conn, "edit.html", animal: animal, changeset: changeset)
  end

  def new(conn, _) do
    changeset = Animal.changeset(%Animal{})
    render(conn, "new.html", changeset: changeset)
  end

  def update(conn, %{"animal" => params, "id" => id}) do
    Animal.get(id)
    |> Animal.update(params)

    redirect(conn, to: Routes.animal_path(conn, :index))
  end

  def create(conn, %{"animal" => params}) do
    Animal.create(params)

    redirect(conn, to: Routes.animal_path(conn, :index))
  end

  def delete(conn, %{"id" => id}) do
    Animal.get(id)
    |> Animal.delete()

    redirect(conn, to: Routes.animal_path(conn, :index))
  end
end
