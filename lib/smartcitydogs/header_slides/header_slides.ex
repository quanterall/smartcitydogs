defmodule SmartCityDogs.HeaderSlides do
  @moduledoc """
  The HeaderSlides context.
  """

  import Ecto.Query, warn: false
  alias SmartCityDogs.Repo

  alias SmartCityDogs.HeaderSlides.HeaderSlide

  @doc """
  Returns the list of header_slides.

  ## Examples

      iex> list_header_slides()
      [%HeaderSlide{}, ...]

  """
  def list_header_slides do
    Repo.all(HeaderSlide)
  end

  @doc """
  Gets a single header_slide.

  Raises `Ecto.NoResultsError` if the Header slide does not exist.

  ## Examples

      iex> get_header_slide!(123)
      %HeaderSlide{}

      iex> get_header_slide!(456)
      ** (Ecto.NoResultsError)

  """
  def get_header_slide!(id), do: Repo.get!(HeaderSlide, id)

  @doc """
  Creates a header_slide.

  ## Examples

      iex> create_header_slide(%{field: value})
      {:ok, %HeaderSlide{}}

      iex> create_header_slide(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_header_slide(attrs \\ %{}) do
    %HeaderSlide{}
    |> HeaderSlide.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a header_slide.

  ## Examples

      iex> update_header_slide(header_slide, %{field: new_value})
      {:ok, %HeaderSlide{}}

      iex> update_header_slide(header_slide, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_header_slide(%HeaderSlide{} = header_slide, attrs) do
    header_slide
    |> HeaderSlide.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a HeaderSlide.

  ## Examples

      iex> delete_header_slide(header_slide)
      {:ok, %HeaderSlide{}}

      iex> delete_header_slide(header_slide)
      {:error, %Ecto.Changeset{}}

  """
  def delete_header_slide(%HeaderSlide{} = header_slide) do
    Repo.delete(header_slide)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking header_slide changes.

  ## Examples

      iex> change_header_slide(header_slide)
      %Ecto.Changeset{source: %HeaderSlide{}}

  """
  def change_header_slide(%HeaderSlide{} = header_slide) do
    HeaderSlide.changeset(header_slide, %{})
  end
end
