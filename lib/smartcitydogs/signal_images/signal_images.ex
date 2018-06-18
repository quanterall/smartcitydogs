defmodule SmartCityDogs.SignalImages do
  @moduledoc """
  The SignalImages context.
  """

  import Ecto.Query, warn: false
  alias SmartCityDogs.Repo

  alias SmartCityDogs.SignalImages.SignalImage

  @doc """
  Returns the list of signal_images.

  ## Examples

      iex> list_signal_images()
      [%SignalImage{}, ...]

  """
  def list_signal_images do
    Repo.all(SignalImage)
  end

  @doc """
  Gets a single signal_image.

  Raises `Ecto.NoResultsError` if the Signal image does not exist.

  ## Examples

      iex> get_signal_image!(123)
      %SignalImage{}

      iex> get_signal_image!(456)
      ** (Ecto.NoResultsError)

  """
  def get_signal_image!(id), do: Repo.get!(SignalImage, id)

  @doc """
  Creates a signal_image.

  ## Examples

      iex> create_signal_image(%{field: value})
      {:ok, %SignalImage{}}

      iex> create_signal_image(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_signal_image(attrs \\ %{}) do
    %SignalImage{}
    |> SignalImage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a signal_image.

  ## Examples

      iex> update_signal_image(signal_image, %{field: new_value})
      {:ok, %SignalImage{}}

      iex> update_signal_image(signal_image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_signal_image(%SignalImage{} = signal_image, attrs) do
    signal_image
    |> SignalImage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a SignalImage.

  ## Examples

      iex> delete_signal_image(signal_image)
      {:ok, %SignalImage{}}

      iex> delete_signal_image(signal_image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_signal_image(%SignalImage{} = signal_image) do
    Repo.delete(signal_image)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking signal_image changes.

  ## Examples

      iex> change_signal_image(signal_image)
      %Ecto.Changeset{source: %SignalImage{}}

  """
  def change_signal_image(%SignalImage{} = signal_image) do
    SignalImage.changeset(signal_image, %{})
  end
end
