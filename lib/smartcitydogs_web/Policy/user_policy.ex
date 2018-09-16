defmodule Smartcitydogs.Users.Policy do
  @behaviour Bodyguard.Policy
  alias Smartcitydogs.User

  # Admin users can do anything
  def authorize(_, %User{users_types_id: 1}, _), do: true

  # Zoo users can do anything
  def authorize(action, %User{users_types_id: 3}, _)
      when action in [:show],
      do: true

  # Municipality users can do anything
  def authorize(action, %User{users_types_id: 4}, _)
      when action in [
             :show
           ],
      do: true

  # Shelter users can do anything
  def authorize(action, %User{users_types_id: 5}, _)
      when action in [
             :show
           ],
      do: true

  # when action in [:new, :index, ]

  # Regular users can create posts
  def authorize(action, _, _)
      when action in [:show, :edit, :update],
      do: true
end
