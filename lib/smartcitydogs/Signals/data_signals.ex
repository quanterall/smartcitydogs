defmodule Smartcitydogs.DataSignals do
  import Ecto.Query, warn: false
  alias Smartcitydogs.Repo

  alias Smartcitydogs.Signals
  alias Smartcitydogs.SignalsTypes
  alias Smartcitydogs.SignalsComments
  alias Smartcitydogs.SignalsCategories
  alias Smartcitydogs.SignalImages
  alias Smartcitydogs.SignalsLikes
  alias Smartcitydogs.DataUsers



  def get_animal_by_chip(chip_number) do
    query = Ecto.Query.from(c in Signals, where: c.chip_number == ^chip_number)
    Repo.all(query)
  end

  # Signals

  def create_signal(args \\ %{}) do
    %Signals{}
    |> Signals.changeset(args)
    |> Repo.insert()
  end

  def update_signal(%Signals{} = signals, args) do
    signals
    |> Signals.changeset(args)
    |> Repo.update()
  end

  def follow_signal(id) do
    signal = get_signal(id)
    follow_number = Map.get(signal, :support_count)
    signal
    |> Signals.changeset(%{support_count: follow_number + 1})
    |> Repo.update()
  end

  def unfollow_signal(id) do
    signal = get_signal(id)
    follow_number = Map.get(signal, :support_count)
    signal
    |> Signals.changeset(%{support_count: follow_number - 1})
    |> Repo.update()
  end



  def get_user_signal(users_id) do
    query = Ecto.Query.from(c in Signals, where: c.users_id == ^users_id)
    Repo.all(query) |> Repo.preload(:signal_images)
  end

  ### takes the support_count
  def get_signal_support_count(signal_id) do
    query = Ecto.Query.from(c in Signals, where: c.id == ^signal_id)
    Repo.all(query)
  end

  def list_signals() do
    Repo.all(Signals)
  end

  def change_signal(%Signals{} = signal) do
    Signals.changeset(signal, %{})
  end

  def get_signal(id) do
    Repo.get!(Signals, id)
  end

  def delete_signal(id) do
    get_signal(id)
    |> Repo.delete()
  end

  def sort_signal_by_id() do
    query = Ecto.Query.from(c in Signals, order_by: [c.id])
    Repo.all(query)
  end

  def sort_signal_comment_by_id() do
    query = Ecto.Query.from(c in SignalsComments, order_by: [desc: c.inserted_at])
    Repo.all(query) |> Repo.preload(:users)
  end

  def get_all_followed_signals(user_id) do
    user = user_id |> DataUsers.get_user!() |> Map.get(:liked_signals)
    user
  end

  # Signal iamges

  def get_signal_image_id(signals_id) do
    query = Ecto.Query.from(c in SignalImages, where: c.signals_id == ^signals_id)
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
    Ecto.Query.from(c in Signals, where: c.signals_categories_id == ^3)
    |> Repo.all()
  end

  # Signals types

  def get_signal_type(id) do
    Repo.get!(SignalsTypes, id)
  end

  def list_signal_types() do
    Repo.all(SignalsTypes)
  end

  def create_signal_type(args \\ %{}) do
    %SignalsTypes{}
    |> SignalsTypes.changeset(args)
    |> Repo.insert()
  end

  def update_signal_type(%SignalsTypes{} = types, args) do
    types
    |> SignalsTypes.changeset(args)
    |> Repo.update()
  end

  def delete_signal_type(id) do
    get_signal_type(id)
    |> Repo.delete()
  end

  # Signal comments

  def get_signal_comment(id) do
    Repo.get!(SignalsComments, id) |> Repo.preload(:users)
  end

  def list_signal_comment() do
    Repo.all(SignalsComments) |> Repo.preload(:users)
  end

  def get_comment_signal_id(signals_id) do
    Ecto.Query.from(c in SignalsComments, where: c.signals_id == ^signals_id)
    |> Repo.all()
  end

  def get_one_signal_comment(signals_id, comment_id) do
   Ecto.Query.from(c in SignalsComments, where: c.signals_id == ^signals_id)
   |> Repo.all() 
   |> Enum.at(comment_id - 1)
  end

  def create_signal_comment(args \\ %{}) do
    %SignalsComments{}
    |> SignalsComments.changeset(args)
    |> Repo.insert()
  end

  def update_signal_comment(%SignalsComments{} = comments, args) do
    comments
    |> SignalsComments.changeset(args)
    |> Repo.update()
  end

  def delete_signal_comment(id) do
    get_signal_comment(id)
    |> Repo.delete()
  end

  # Signals category

  def get_signal_category(id) do
    Repo.get!(SignalsCategories, id)
  end

  def list_signal_category() do
    Repo.all(SignalsCategories)
  end

  def create_signal_category(args \\ %{}) do
    %SignalsCategories{}
    |> SignalsCategories.changeset(args)
    |> Repo.insert()
  end

  def update_signal_category(%SignalsCategories{} = category, args) do
    category
    |> SignalsCategories.changeset(args)
    |> Repo.update()
  end

  def delete_signal_category(id) do
    get_signal_category(id)
    |> Repo.delete()
  end

  # Signals likes
  def get_signals_user_like(user_id, signal_id) do
    Ecto.Query.from(c in SignalsLikes, where: c.users_id == ^user_id and c.signals_id == ^signal_id)
    |> Repo.all()
  end

  def get_signal_like(id) do
    query = Ecto.Query.from(c in SignalsLikes, where: c.users_id == ^id)
    Repo.all(query)
  end

  def list_signal_like() do
    Repo.all(SignalsLikes)
  end

  def create_signal_like(args \\ %{}) do
    %SignalsLikes{}
    |> SignalsLikes.changeset(args)
    |> Repo.insert()
  end

  def update_signal_like(%SignalsLikes{} = like, args) do
    like
    |> SignalsLikes.changeset(args)
    |> Repo.update()
  end

  def delete_signal_like(id) do
    get_signal_like(id)
    |> Repo.delete()
  end
end
