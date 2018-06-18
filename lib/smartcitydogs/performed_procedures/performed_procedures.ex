defmodule SmartCityDogs.PerformedProcedures do
  @moduledoc """
  The PerformedProcedures context.
  """

  import Ecto.Query, warn: false
  alias SmartCityDogs.Repo

  alias SmartCityDogs.PerformedProcedures.PerformedProcedure

  @doc """
  Returns the list of performed_procedure.

  ## Examples

      iex> list_performed_procedure()
      [%PerformedProcedure{}, ...]

  """
  def list_performed_procedure do
    Repo.all(PerformedProcedure)
  end

  @doc """
  Gets a single performed_procedure.

  Raises `Ecto.NoResultsError` if the Performed procedure does not exist.

  ## Examples

      iex> get_performed_procedure!(123)
      %PerformedProcedure{}

      iex> get_performed_procedure!(456)
      ** (Ecto.NoResultsError)

  """
  def get_performed_procedure!(id), do: Repo.get!(PerformedProcedure, id)

  @doc """
  Creates a performed_procedure.

  ## Examples

      iex> create_performed_procedure(%{field: value})
      {:ok, %PerformedProcedure{}}

      iex> create_performed_procedure(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_performed_procedure(attrs \\ %{}) do
    %PerformedProcedure{}
    |> PerformedProcedure.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a performed_procedure.

  ## Examples

      iex> update_performed_procedure(performed_procedure, %{field: new_value})
      {:ok, %PerformedProcedure{}}

      iex> update_performed_procedure(performed_procedure, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_performed_procedure(%PerformedProcedure{} = performed_procedure, attrs) do
    performed_procedure
    |> PerformedProcedure.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PerformedProcedure.

  ## Examples

      iex> delete_performed_procedure(performed_procedure)
      {:ok, %PerformedProcedure{}}

      iex> delete_performed_procedure(performed_procedure)
      {:error, %Ecto.Changeset{}}

  """
  def delete_performed_procedure(%PerformedProcedure{} = performed_procedure) do
    Repo.delete(performed_procedure)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking performed_procedure changes.

  ## Examples

      iex> change_performed_procedure(performed_procedure)
      %Ecto.Changeset{source: %PerformedProcedure{}}

  """
  def change_performed_procedure(%PerformedProcedure{} = performed_procedure) do
    PerformedProcedure.changeset(performed_procedure, %{})
  end
end
