defmodule SmartCityDogs.AnimalImages do
  @moduledoc """
  The AnimalImages context.
  """

  import Ecto.Query, warn: false
  alias SmartCityDogs.Repo

  alias SmartCityDogs.AnimalImages.AnimalImage

  @doc """
  Returns the list of animal_images.

  ## Examples

      iex> list_animal_images()
      [%AnimalImage{}, ...]

  """
  def list_animal_images do
    Repo.all(AnimalImage)
  end

  @doc """
  Gets a single animal_image.

  Raises `Ecto.NoResultsError` if the Animal image does not exist.

  ## Examples

      iex> get_animal_image!(123)
      %AnimalImage{}

      iex> get_animal_image!(456)
      ** (Ecto.NoResultsError)

  """
  def get_animal_image!(id), do: Repo.get!(AnimalImage, id)

  @doc """
  Creates a animal_image.

  ## Examples

      iex> create_animal_image(%{field: value})
      {:ok, %AnimalImage{}}

      iex> create_animal_image(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_animal_image(attrs \\ %{}) do
    %AnimalImage{}
    |> AnimalImage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a animal_image.

  ## Examples

      iex> update_animal_image(animal_image, %{field: new_value})
      {:ok, %AnimalImage{}}

      iex> update_animal_image(animal_image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_animal_image(%AnimalImage{} = animal_image, attrs) do
    animal_image
    |> AnimalImage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a AnimalImage.

  ## Examples

      iex> delete_animal_image(animal_image)
      {:ok, %AnimalImage{}}

      iex> delete_animal_image(animal_image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_animal_image(%AnimalImage{} = animal_image) do
    Repo.delete(animal_image)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking animal_image changes.

  ## Examples

      iex> change_animal_image(animal_image)
      %Ecto.Changeset{source: %AnimalImage{}}

  """
  def change_animal_image(%AnimalImage{} = animal_image) do
    AnimalImage.changeset(animal_image, %{})
  end
end
