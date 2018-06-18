defmodule SmartCityDogs.SignalsTypes do
  @moduledoc """
  The SignalsTypes context.
  """

  import Ecto.Query, warn: false
  alias SmartCityDogs.Repo

  alias SmartCityDogs.SignalsTypes.SignalsType

  @doc """
  Returns the list of signals_types.

  ## Examples

      iex> list_signals_types()
      [%SignalsType{}, ...]

  """
  def list_signals_types do
    Repo.all(SignalsType)
  end

  @doc """
  Gets a single signals_type.

  Raises `Ecto.NoResultsError` if the Signals type does not exist.

  ## Examples

      iex> get_signals_type!(123)
      %SignalsType{}

      iex> get_signals_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_signals_type!(id), do: Repo.get!(SignalsType, id)

  @doc """
  Creates a signals_type.

  ## Examples

      iex> create_signals_type(%{field: value})
      {:ok, %SignalsType{}}

      iex> create_signals_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_signals_type(attrs \\ %{}) do
    %SignalsType{}
    |> SignalsType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a signals_type.

  ## Examples

      iex> update_signals_type(signals_type, %{field: new_value})
      {:ok, %SignalsType{}}

      iex> update_signals_type(signals_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_signals_type(%SignalsType{} = signals_type, attrs) do
    signals_type
    |> SignalsType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a SignalsType.

  ## Examples

      iex> delete_signals_type(signals_type)
      {:ok, %SignalsType{}}

      iex> delete_signals_type(signals_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_signals_type(%SignalsType{} = signals_type) do
    Repo.delete(signals_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking signals_type changes.

  ## Examples

      iex> change_signals_type(signals_type)
      %Ecto.Changeset{source: %SignalsType{}}

  """
  def change_signals_type(%SignalsType{} = signals_type) do
    SignalsType.changeset(signals_type, %{})
  end
end
