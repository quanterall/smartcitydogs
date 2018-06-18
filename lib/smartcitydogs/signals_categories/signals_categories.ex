defmodule SmartCityDogs.SignalsCategories do
  @moduledoc """
  The SignalsCategories context.
  """

  import Ecto.Query, warn: false
  alias SmartCityDogs.Repo

  alias SmartCityDogs.SignalsCategories.SignalCategory

  @doc """
  Returns the list of signals_categories.

  ## Examples

      iex> list_signals_categories()
      [%SignalCategory{}, ...]

  """
  def list_signals_categories do
    Repo.all(SignalCategory)
  end

  @doc """
  Gets a single signal_category.

  Raises `Ecto.NoResultsError` if the Signal category does not exist.

  ## Examples

      iex> get_signal_category!(123)
      %SignalCategory{}

      iex> get_signal_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_signal_category!(id), do: Repo.get!(SignalCategory, id)

  @doc """
  Creates a signal_category.

  ## Examples

      iex> create_signal_category(%{field: value})
      {:ok, %SignalCategory{}}

      iex> create_signal_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_signal_category(attrs \\ %{}) do
    %SignalCategory{}
    |> SignalCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a signal_category.

  ## Examples

      iex> update_signal_category(signal_category, %{field: new_value})
      {:ok, %SignalCategory{}}

      iex> update_signal_category(signal_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_signal_category(%SignalCategory{} = signal_category, attrs) do
    signal_category
    |> SignalCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a SignalCategory.

  ## Examples

      iex> delete_signal_category(signal_category)
      {:ok, %SignalCategory{}}

      iex> delete_signal_category(signal_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_signal_category(%SignalCategory{} = signal_category) do
    Repo.delete(signal_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking signal_category changes.

  ## Examples

      iex> change_signal_category(signal_category)
      %Ecto.Changeset{source: %SignalCategory{}}

  """
  def change_signal_category(%SignalCategory{} = signal_category) do
    SignalCategory.changeset(signal_category, %{})
  end
end
