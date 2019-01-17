defmodule Smartcitydogs.Contact.Policy do
  @behaviour Bodyguard.Policy
  alias Smartcitydogs.User

  # Admin users can do anything
  def authorize(_, %User{user_type_id: 1}, _), do: false

  # Zoo users can do anything
  def authorize(_, %User{user_type_id: 3}, _), do: false

  # Municipality users can do anything
  def authorize(_, %User{user_type_id: 4}, _), do: false

  # Shelter users can do anything
  def authorize(_, %User{user_type_id: 5}, _), do: false

  # when action in [:new, :index, ]

  # Regular users can create posts
  def authorize(action, _, _)
      when action in [:index, :create, :new, :edit, :update],
      do: true
end
