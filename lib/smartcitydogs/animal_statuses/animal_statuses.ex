defmodule SmartCityDogs.AnimalStatuses do
  @moduledoc """
  The AnimalStatuses context.
  """

  import Ecto.Query, warn: false
  alias SmartCityDogs.Repo

  alias SmartCityDogs.AnimalStatuses.AnimalStatus

  @doc """
  Returns the list of animal_statuses.

  ## Examples

      iex> list_animal_statuses()
      [%AnimalStatus{}, ...]

  """
  def list_animal_statuses do
    Repo.all(AnimalStatus)
  end

  @doc """
  Gets a single animal_status.

  Raises `Ecto.NoResultsError` if the Animal status does not exist.

  ## Examples

      iex> get_animal_status!(123)
      %AnimalStatus{}

      iex> get_animal_status!(456)
      ** (Ecto.NoResultsError)

  """
  def get_animal_status!(id), do: Repo.get!(AnimalStatus, id)

  @doc """
  Creates a animal_status.

  ## Examples

      iex> create_animal_status(%{field: value})
      {:ok, %AnimalStatus{}}

      iex> create_animal_status(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_animal_status(attrs \\ %{}) do
    %AnimalStatus{}
    |> AnimalStatus.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a animal_status.

  ## Examples

      iex> update_animal_status(animal_status, %{field: new_value})
      {:ok, %AnimalStatus{}}

      iex> update_animal_status(animal_status, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_animal_status(%AnimalStatus{} = animal_status, attrs) do
    animal_status
    |> AnimalStatus.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a AnimalStatus.

  ## Examples

      iex> delete_animal_status(animal_status)
      {:ok, %AnimalStatus{}}

      iex> delete_animal_status(animal_status)
      {:error, %Ecto.Changeset{}}

  """
  def delete_animal_status(%AnimalStatus{} = animal_status) do
    Repo.delete(animal_status)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking animal_status changes.

  ## Examples

      iex> change_animal_status(animal_status)
      %Ecto.Changeset{source: %AnimalStatus{}}

  """
  def change_animal_status(%AnimalStatus{} = animal_status) do
    AnimalStatus.changeset(animal_status, %{})
  end
end
