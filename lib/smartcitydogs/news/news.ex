defmodule SmartCityDogs.News do
  @moduledoc """
  The News context.
  """

  import Ecto.Query, warn: false
  alias SmartCityDogs.Repo

  alias SmartCityDogs.News.NewsSchema

  @doc """
  Returns the list of news.

  ## Examples

      iex> list_news()
      [%NewsSchema{}, ...]

  """
  def list_news do
    Repo.all(NewsSchema)
  end

  @doc """
  Gets a single news_schema.

  Raises `Ecto.NoResultsError` if the News schema does not exist.

  ## Examples

      iex> get_news_schema!(123)
      %NewsSchema{}

      iex> get_news_schema!(456)
      ** (Ecto.NoResultsError)

  """
  def get_news_schema!(id), do: Repo.get!(NewsSchema, id)

  @doc """
  Creates a news_schema.

  ## Examples

      iex> create_news_schema(%{field: value})
      {:ok, %NewsSchema{}}

      iex> create_news_schema(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_news_schema(attrs \\ %{}) do
    %NewsSchema{}
    |> NewsSchema.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a news_schema.

  ## Examples

      iex> update_news_schema(news_schema, %{field: new_value})
      {:ok, %NewsSchema{}}

      iex> update_news_schema(news_schema, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_news_schema(%NewsSchema{} = news_schema, attrs) do
    news_schema
    |> NewsSchema.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a NewsSchema.

  ## Examples

      iex> delete_news_schema(news_schema)
      {:ok, %NewsSchema{}}

      iex> delete_news_schema(news_schema)
      {:error, %Ecto.Changeset{}}

  """
  def delete_news_schema(%NewsSchema{} = news_schema) do
    Repo.delete(news_schema)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking news_schema changes.

  ## Examples

      iex> change_news_schema(news_schema)
      %Ecto.Changeset{source: %NewsSchema{}}

  """
  def change_news_schema(%NewsSchema{} = news_schema) do
    NewsSchema.changeset(news_schema, %{})
  end
end
