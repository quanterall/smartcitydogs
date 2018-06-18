defmodule SmartCityDogs.ProcedureTypes do
  @moduledoc """
  The ProcedureTypes context.
  """

  import Ecto.Query, warn: false
  alias SmartCityDogs.Repo

  alias SmartCityDogs.ProcedureTypes.ProcedureType

  @doc """
  Returns the list of procedure_types.

  ## Examples

      iex> list_procedure_types()
      [%ProcedureType{}, ...]

  """
  def list_procedure_types do
    Repo.all(ProcedureType)
  end

  @doc """
  Gets a single procedure_type.

  Raises `Ecto.NoResultsError` if the Procedure type does not exist.

  ## Examples

      iex> get_procedure_type!(123)
      %ProcedureType{}

      iex> get_procedure_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_procedure_type!(id), do: Repo.get!(ProcedureType, id)

  @doc """
  Creates a procedure_type.

  ## Examples

      iex> create_procedure_type(%{field: value})
      {:ok, %ProcedureType{}}

      iex> create_procedure_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_procedure_type(attrs \\ %{}) do
    %ProcedureType{}
    |> ProcedureType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a procedure_type.

  ## Examples

      iex> update_procedure_type(procedure_type, %{field: new_value})
      {:ok, %ProcedureType{}}

      iex> update_procedure_type(procedure_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_procedure_type(%ProcedureType{} = procedure_type, attrs) do
    procedure_type
    |> ProcedureType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ProcedureType.

  ## Examples

      iex> delete_procedure_type(procedure_type)
      {:ok, %ProcedureType{}}

      iex> delete_procedure_type(procedure_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_procedure_type(%ProcedureType{} = procedure_type) do
    Repo.delete(procedure_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking procedure_type changes.

  ## Examples

      iex> change_procedure_type(procedure_type)
      %Ecto.Changeset{source: %ProcedureType{}}

  """
  def change_procedure_type(%ProcedureType{} = procedure_type) do
    ProcedureType.changeset(procedure_type, %{})
  end
end
