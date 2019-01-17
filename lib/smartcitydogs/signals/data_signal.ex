defmodule Smartcitydogs.DataSignal do
  import Ecto.Query
  alias Smartcitydogs.Repo

  alias Smartcitydogs.Signal
  alias Smartcitydogs.SignalType
  alias Smartcitydogs.SignalComment
  alias Smartcitydogs.SignalCategory
  alias Smartcitydogs.SignalImage
  alias Smartcitydogs.SignalLike
  alias Smartcitydogs.DataUsers

  def get_animal_by_chip(chip_number) do
    query = from(c in Signal, where: c.chip_number == ^chip_number)
    Repo.all(query)
  end

  # Signal

  def update_signal(%Signal{} = signals, args) do
    signals
    |> Signal.changeset(args)
    |> Repo.update()
  end

  def create_signal(args) do
    %Signal{}
    |> Signal.changeset(args)
    |> Repo.insert!()
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
    query = from(c in Signal, where: c.user_id == ^user_id)
    Repo.all(query) |> Repo.preload(:signal_images)
  end

  ### takes the support_count
  def get_signal_support_count(signal_id) do
    query = from(c in Signal, where: c.id == ^signal_id)
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
    query = from(c in Signal, order_by: [c.id])
    Repo.all(query)
  end

  def sort_signal_comment_by_id() do
    query = from(c in SignalComment, order_by: [desc: c.inserted_at])
    Repo.all(query) |> Repo.preload(:user)
  end

  def get_all_followed_signals(user_id) do
    user = user_id |> DataUsers.get_user!() |> Map.get(:liked_signals)
    user
  end

  # Signal iamges

  def get_signal_image_id(signal_id) do
    query = from(c in SignalImage, where: c.signal_id == ^signal_id)
    Repo.all(query)
  end

  def get_signal_images(id) do
    Repo.get!(SignalImage, id)
  end

  def list_signal_images() do
    Repo.all(SignalImage)
  end

  def create_signal_images(args \\ %{}) do
    %SignalImage{}
    |> SignalImage.changeset(args)
    |> Repo.insert()
  end

  def update_signal_images(%SignalImage{} = images, args) do
    images
    |> SignalImage.changeset(args)
    |> Repo.update()
  end

  def delete_signal_images(id) do
    get_signal_images(id)
    |> Repo.delete()
  end

  def get_all_cruelty_signals() do
    from(c in Signal, where: c.signal_category_id == ^3)
    |> Repo.all()
  end

  # Signal types

  def get_signal_type(id) do
    Repo.get!(SignalType, id)
  end

  def list_signal_types() do
    Repo.all(SignalType)
  end

  def create_signal_type(args \\ %{}) do
    %SignalType{}
    |> SignalType.changeset(args)
    |> Repo.insert()
  end

  def update_signal_type(%SignalType{} = types, args) do
    types
    |> SignalType.changeset(args)
    |> Repo.update()
  end

  def delete_signal_type(id) do
    get_signal_type(id)
    |> Repo.delete()
  end

  # Signal comments

  def get_signal_comment(id) do
    Repo.get!(SignalComment, id) |> Repo.preload(:user)
  end

  def list_signal_comment() do
    Repo.all(SignalComment) |> Repo.preload(:user)
  end

  def get_comment_signal_id(signal_id) do
    from(c in SignalComment, where: c.signal_id == ^signal_id)
    |> Repo.all()
  end

  def get_one_signal_comment(signal_id, comment_id) do
    from(c in SignalComment, where: c.signal_id == ^signal_id)
    |> Repo.all()
    |> Enum.at(comment_id - 1)
  end

  def create_signal_comment(args \\ %{}) do
    %SignalComment{}
    |> SignalComment.changeset(args)
    |> Repo.insert()
  end

  def update_signal_comment(%SignalComment{} = comments, args) do
    comments
    |> SignalComment.changeset(args)
    |> Repo.update()
  end

  def delete_signal_comment(id) do
    get_signal_comment(id)
    |> Repo.delete()
  end

  # Signal category

  def get_signal_category(id) do
    Repo.get!(SignalCategory, id)
  end

  def list_signal_category() do
    Repo.all(SignalCategory)
  end

  def create_signal_category(args \\ %{}) do
    %SignalCategory{}
    |> SignalCategory.changeset(args)
    |> Repo.insert()
  end

  def update_signal_category(%SignalCategory{} = category, args) do
    category
    |> SignalCategory.changeset(args)
    |> Repo.update()
  end

  def delete_signal_category(id) do
    get_signal_category(id)
    |> Repo.delete()
  end

  # Signal likes
  def get_signal_user_like(user_id, signal_id) do
    from(c in SignalLike,
      where: c.user_id == ^user_id and c.signal_id == ^signal_id
    )
    |> Repo.all()
  end

  def get_signal_like(id) do
    query = from(c in SignalLike, where: c.user_id == ^id)
    Repo.all(query)
  end

  def list_signal_like() do
    Repo.all(SignalLike)
  end

  def create_signal_like(args \\ %{}) do
    %SignalLike{}
    |> SignalLike.changeset(args)
    |> Repo.insert()
  end

  def update_signal_like(%SignalLike{} = like, args) do
    like
    |> SignalLike.changeset(args)
    |> Repo.update()
  end

  def delete_signal_like(id) do
    get_signal_like(id)
    |> Repo.delete()
  end
end
