defmodule SmartCityDogs.UsersTypes do
  @moduledoc """
  The UsersTypes context.
  """

  import Ecto.Query, warn: false
  alias SmartCityDogs.Repo

  alias SmartCityDogs.UsersTypes.UsersType

  @doc """
  Returns the list of users_types.

  ## Examples

      iex> list_users_types()
      [%UsersType{}, ...]

  """
  def list_users_types do
    Repo.all(UsersType)
  end

  @doc """
  Gets a single users_type.

  Raises `Ecto.NoResultsError` if the Users type does not exist.

  ## Examples

      iex> get_users_type!(123)
      %UsersType{}

      iex> get_users_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_users_type!(id), do: Repo.get!(UsersType, id)

  @doc """
  Creates a users_type.

  ## Examples

      iex> create_users_type(%{field: value})
      {:ok, %UsersType{}}

      iex> create_users_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_users_type(attrs \\ %{}) do
    %UsersType{}
    |> UsersType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a users_type.

  ## Examples

      iex> update_users_type(users_type, %{field: new_value})
      {:ok, %UsersType{}}

      iex> update_users_type(users_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_users_type(%UsersType{} = users_type, attrs) do
    users_type
    |> UsersType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UsersType.

  ## Examples

      iex> delete_users_type(users_type)
      {:ok, %UsersType{}}

      iex> delete_users_type(users_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_users_type(%UsersType{} = users_type) do
    Repo.delete(users_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking users_type changes.

  ## Examples

      iex> change_users_type(users_type)
      %Ecto.Changeset{source: %UsersType{}}

  """
  def change_users_type(%UsersType{} = users_type) do
    UsersType.changeset(users_type, %{})
  end
end
