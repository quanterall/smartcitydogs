defmodule Smartcitydogs.Animals.Policy do
  @behaviour Bodyguard.Policy
  alias Smartcitydogs.User

  # Admin users can do anything
  def authorize(_, %User{user_type_id: 1}, _), do: true

  # Zoo users can do anything
  def authorize(_, %User{user_type_id: 3}, _), do: false

  # Municipality users can do anything
  def authorize(action, %User{user_type_id: 4}, _)
      when action in [
             :index,
             :show,
             :minicipality_registered,
             :minicipality_shelter,
             :minicipality_adopted
           ],
      do: true

  # Shelter users can do anything
  def authorize(_, %User{user_type_id: 5}, _), do: true

  # when action in [:new, :index, ]

  # Regular users can create posts
  def authorize(:index, _, _), do: true

  # Regular users can modify their own posts
  #   def authorize(action, %User{id: user_id}, %Blog.Post{user_id: user_id}})
  #     when action in [:update_post, :delete_post], do: true

  # Catch-all: deny everything else
  def authorize(_, _, _), do: false
end

#  user = Smartcitydogs.DataUsers.get_user!(7)
# Bodyguard.permit(Smartcitydogs.Animals.Policy, :new, user)
#    - проверка за достъп (модул, функция, потребител)
