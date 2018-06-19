defmodule SmartCityDogs.Signals.Signal do
  use Ecto.Schema
  import Ecto.Changeset


  schema "signals" do
    field :address, :string
    field :chip_number, :string
    field :deleted_at, :naive_datetime
    field :description, :string
    #field :signals_categories_id, :integer
    #field :signals_types_id, :integer
    field :support_count, :integer
    field :title, :string
    #field :users_id, :integer
    field :view_count, :integer
    belongs_to :signals_types, SmartCityDogs.SignalsTypes.SignalsType
    belongs_to :signals_categories, SmartCityDogs.SignalsCategories.SignalCategory
    has_many :signals_likes , SmartCityDogs.SignalsLikes.SignalsLike
    has_many :signals_comments , SmartCityDogs.SignalsComments.SignalsComment
    has_many :signal_images , SmartCityDogs.SignalImages.SignalImage
    #belongs_to :contacts, SmartCityDogs.Contacts.Contact
    #belongs_to :users_types, SmartCityDogs.UsersTypes.UsersType
    belongs_to :users, SmartCityDogs.Users.User


    timestamps()
  end

  @doc false
  def changeset(signal, attrs) do
    signal
    |> cast(attrs, [:title, :view_count, :address, :support_count, :chip_number, :description, :deleted_at, :signals_types_id, :signals_categories_id, :users_id])
    |> validate_required([:title, :address, :chip_number, :description, :signals_types_id, :signals_categories_id, :users_id])
  end
end
