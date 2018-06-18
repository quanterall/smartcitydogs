defmodule SmartCityDogs.SignalsComments do
  @moduledoc """
  The SignalsComments context.
  """

  import Ecto.Query, warn: false
  alias SmartCityDogs.Repo

  alias SmartCityDogs.SignalsComments.SignalsComment

  @doc """
  Returns the list of signals_comments.

  ## Examples

      iex> list_signals_comments()
      [%SignalsComment{}, ...]

  """
  def list_signals_comments do
    Repo.all(SignalsComment)
  end

  @doc """
  Gets a single signals_comment.

  Raises `Ecto.NoResultsError` if the Signals comment does not exist.

  ## Examples

      iex> get_signals_comment!(123)
      %SignalsComment{}

      iex> get_signals_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_signals_comment!(id), do: Repo.get!(SignalsComment, id)

  @doc """
  Creates a signals_comment.

  ## Examples

      iex> create_signals_comment(%{field: value})
      {:ok, %SignalsComment{}}

      iex> create_signals_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_signals_comment(attrs \\ %{}) do
    %SignalsComment{}
    |> SignalsComment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a signals_comment.

  ## Examples

      iex> update_signals_comment(signals_comment, %{field: new_value})
      {:ok, %SignalsComment{}}

      iex> update_signals_comment(signals_comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_signals_comment(%SignalsComment{} = signals_comment, attrs) do
    signals_comment
    |> SignalsComment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a SignalsComment.

  ## Examples

      iex> delete_signals_comment(signals_comment)
      {:ok, %SignalsComment{}}

      iex> delete_signals_comment(signals_comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_signals_comment(%SignalsComment{} = signals_comment) do
    Repo.delete(signals_comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking signals_comment changes.

  ## Examples

      iex> change_signals_comment(signals_comment)
      %Ecto.Changeset{source: %SignalsComment{}}

  """
  def change_signals_comment(%SignalsComment{} = signals_comment) do
    SignalsComment.changeset(signals_comment, %{})
  end
end
