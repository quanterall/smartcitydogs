defmodule SmartCityDogs.SignalsLikes do
  @moduledoc """
  The SignalsLikes context.
  """

  import Ecto.Query, warn: false
  alias SmartCityDogs.Repo

  alias SmartCityDogs.SignalsLikes.SignalsLike

  @doc """
  Returns the list of signals_likes.

  ## Examples

      iex> list_signals_likes()
      [%SignalsLike{}, ...]

  """
  def list_signals_likes do
    Repo.all(SignalsLike)
  end

  @doc """
  Gets a single signals_like.

  Raises `Ecto.NoResultsError` if the Signals like does not exist.

  ## Examples

      iex> get_signals_like!(123)
      %SignalsLike{}

      iex> get_signals_like!(456)
      ** (Ecto.NoResultsError)

  """
  def get_signals_like!(id), do: Repo.get!(SignalsLike, id)

  @doc """
  Creates a signals_like.

  ## Examples

      iex> create_signals_like(%{field: value})
      {:ok, %SignalsLike{}}

      iex> create_signals_like(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_signals_like(attrs \\ %{}) do
    %SignalsLike{}
    |> SignalsLike.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a signals_like.

  ## Examples

      iex> update_signals_like(signals_like, %{field: new_value})
      {:ok, %SignalsLike{}}

      iex> update_signals_like(signals_like, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_signals_like(%SignalsLike{} = signals_like, attrs) do
    signals_like
    |> SignalsLike.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a SignalsLike.

  ## Examples

      iex> delete_signals_like(signals_like)
      {:ok, %SignalsLike{}}

      iex> delete_signals_like(signals_like)
      {:error, %Ecto.Changeset{}}

  """
  def delete_signals_like(%SignalsLike{} = signals_like) do
    Repo.delete(signals_like)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking signals_like changes.

  ## Examples

      iex> change_signals_like(signals_like)
      %Ecto.Changeset{source: %SignalsLike{}}

  """
  def change_signals_like(%SignalsLike{} = signals_like) do
    SignalsLike.changeset(signals_like, %{})
  end
end
