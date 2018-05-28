defmodule Smartcitydogs.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias Smartcitydogs.Repo
  alias Smartcitydogs.User

  def for_token(user = %User{}), do: {:ok, "User:#{user.id}"}
  def for_token(_), do: {:error, "Unknown resource type"}

  # def from_token("User:" <> id), do: {:ok, Repo.get(User, id)}
  def from_token("User:" <> id), do: {:ok, Smartcitydogs.DataUsers.get_user!(id)}
  def from_token(_), do: {:error, "Unknown resource type"}
end
