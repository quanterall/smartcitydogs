defmodule Smartcitydogs.DataSignal do
  import Ecto.Query
  alias Smartcitydogs.Repo

  alias Smartcitydogs.Signal
  alias Smartcitydogs.SignalTypes
  alias Smartcitydogs.SignalComments
  alias Smartcitydogs.SignalCategories
  alias Smartcitydogs.SignalImages
  alias Smartcitydogs.SignalLikes
  alias Smartcitydogs.DataUsers

  def get_animal_by_chip(chip_number) do
    query = Ecto.Query.from(c in Signal, where: c.chip_number == ^chip_number)
    Repo.all(query)
  end

  # Signal

  def update_signal(%Signal{} = signals, args) do
    signals
    |> Signal.changeset(args)
    |> Repo.update()
  end

  def follow_signal(id) do
    signal = get_signal(id)
    follow_number = Map.get(signal, :support_count)

    signal
    |> Signal.changeset(%{support_count: follow_number + 1})
    |> Repo.update()
  end

  def unfollow_signal(id) do
    signal = get_signal(id)
    follow_number = Map.get(signal, :support_count)

    signal
    |> Signal.changeset(%{support_count: follow_number - 1})
    |> Repo.update()
  end

  def get_user_signal(user_id) do
    query = Ecto.Query.from(c in Signal, where: c.user_id == ^user_id)
    Repo.all(query) |> Repo.preload(:signal_images)
  end

  ### takes the support_count
  def get_signal_support_count(signal_id) do
    query = Ecto.Query.from(c in Signal, where: c.id == ^signal_id)
    Repo.all(query)
  end

  def list_signals() do
    Repo.all(Signal)
  end

  def change_signal(%Signal{} = signal) do
    Signal.changeset(signal, %{})
  end

  def get_signal(id) do
    Repo.get!(Signal, id)
  end

  def delete_signal(id) do
    get_signal(id)
    |> Repo.delete()
  end

  def sort_signal_by_id() do
    query = Ecto.Query.from(c in Signal, order_by: [c.id])
    Repo.all(query)
  end

  def sort_signal_comment_by_id() do
    query = Ecto.Query.from(c in SignalComments, order_by: [desc: c.inserted_at])
    Repo.all(query) |> Repo.preload(:users)
  end

  def get_all_followed_signals(user_id) do
    user = user_id |> DataUsers.get_user!() |> Map.get(:liked_signals)
    user
  end

  # Signal iamges

  def get_signal_image_id(signal_id) do
    query = Ecto.Query.from(c in SignalImages, where: c.signal_id == ^signal_id)
    Repo.all(query)
  end

  def get_signal_images(id) do
    Repo.get!(SignalImages, id)
  end

  def list_signal_images() do
    Repo.all(SignalImages)
  end

  def create_signal_images(args \\ %{}) do
    %SignalImages{}
    |> SignalImages.changeset(args)
    |> Repo.insert()
  end

  def update_signal_images(%SignalImages{} = images, args) do
    images
    |> SignalImages.changeset(args)
    |> Repo.update()
  end

  def delete_signal_images(id) do
    get_signal_images(id)
    |> Repo.delete()
  end

  def get_all_cruelty_signals() do
    Ecto.Query.from(c in Signal, where: c.signal_category_id == ^3)
    |> Repo.all()
  end

  # Signal types

  def get_signal_type(id) do
    Repo.get!(SignalTypes, id)
  end

  def list_signal_types() do
    Repo.all(SignalTypes)
  end

  def create_signal_type(args \\ %{}) do
    %SignalTypes{}
    |> SignalTypes.changeset(args)
    |> Repo.insert()
  end

  def update_signal_type(%SignalTypes{} = types, args) do
    types
    |> SignalTypes.changeset(args)
    |> Repo.update()
  end

  def delete_signal_type(id) do
    get_signal_type(id)
    |> Repo.delete()
  end

  # Signal comments

  def get_signal_comment(id) do
    Repo.get!(SignalComments, id) |> Repo.preload(:users)
  end

  def list_signal_comment() do
    Repo.all(SignalComments) |> Repo.preload(:users)
  end

  def get_comment_signal_id(signal_id) do
    Ecto.Query.from(c in SignalComments, where: c.signal_id == ^signal_id)
    |> Repo.all()
  end

  def get_one_signal_comment(signal_id, comment_id) do
    Ecto.Query.from(c in SignalComments, where: c.signal_id == ^signal_id)
    |> Repo.all()
    |> Enum.at(comment_id - 1)
  end

  def create_signal_comment(args \\ %{}) do
    %SignalComments{}
    |> SignalComments.changeset(args)
    |> Repo.insert()
  end

  def update_signal_comment(%SignalComments{} = comments, args) do
    comments
    |> SignalComments.changeset(args)
    |> Repo.update()
  end

  def delete_signal_comment(id) do
    get_signal_comment(id)
    |> Repo.delete()
  end

  # Signal category

  def get_signal_category(id) do
    Repo.get!(SignalCategories, id)
  end

  def list_signal_category() do
    Repo.all(SignalCategories)
  end

  def create_signal_category(args \\ %{}) do
    %SignalCategories{}
    |> SignalCategories.changeset(args)
    |> Repo.insert()
  end

  def update_signal_category(%SignalCategories{} = category, args) do
    category
    |> SignalCategories.changeset(args)
    |> Repo.update()
  end

  def delete_signal_category(id) do
    get_signal_category(id)
    |> Repo.delete()
  end

  # Signal likes
  def get_signal_user_like(user_id, signal_id) do
    Ecto.Query.from(c in SignalLikes,
      where: c.user_id == ^user_id and c.signal_id == ^signal_id
    )
    |> Repo.all()
  end

  def get_signal_like(id) do
    query = Ecto.Query.from(c in SignalLikes, where: c.user_id == ^id)
    Repo.all(query)
  end

  def list_signal_like() do
    Repo.all(SignalLikes)
  end

  def create_signal_like(args \\ %{}) do
    %SignalLikes{}
    |> SignalLikes.changeset(args)
    |> Repo.insert()
  end

  def update_signal_like(%SignalLikes{} = like, args) do
    like
    |> SignalLikes.changeset(args)
    |> Repo.update()
  end

  def delete_signal_like(id) do
    get_signal_like(id)
    |> Repo.delete()
  end
end
