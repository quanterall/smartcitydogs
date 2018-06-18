defmodule SmartCityDogs.Rescues do
  @moduledoc """
  The Rescues context.
  """

  import Ecto.Query, warn: false
  alias SmartCityDogs.Repo

  alias SmartCityDogs.Rescues.Rescue

  @doc """
  Returns the list of rescues.

  ## Examples

      iex> list_rescues()
      [%Rescue{}, ...]

  """
  def list_rescues do
    Repo.all(Rescue)
  end

  @doc """
  Gets a single rescue.

  Raises `Ecto.NoResultsError` if the Rescue does not exist.

  ## Examples

      iex> get_rescue!(123)
      %Rescue{}

      iex> get_rescue!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rescue!(id), do: Repo.get!(Rescue, id)

  @doc """
  Creates a rescue.

  ## Examples

      iex> create_rescue(%{field: value})
      {:ok, %Rescue{}}

      iex> create_rescue(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rescue(attrs \\ %{}) do
    %Rescue{}
    |> Rescue.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rescue.

  ## Examples

      iex> update_rescue(rescue, %{field: new_value})
      {:ok, %Rescue{}}

      iex> update_rescue(rescue, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rescue(%Rescue{} = rescues, attrs) do
    rescues
    |> Rescue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Rescue.

  ## Examples

      iex> delete_rescue(rescue)
      {:ok, %Rescue{}}

      iex> delete_rescue(rescue)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rescue(%Rescue{} = rescues) do
    Repo.delete(rescues)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rescue changes.

  ## Examples

      iex> change_rescue(rescue)
      %Ecto.Changeset{source: %Rescue{}}

  """
  def change_rescue(%Rescue{} = rescues) do
    Rescue.changeset(rescues, %{})
  end
end
