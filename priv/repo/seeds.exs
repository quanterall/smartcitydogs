# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Smartcitydogs.Repo.insert!(%Smartcitydogs.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

########  alias #############

alias Smartcitydogs.Repo

alias Smartcitydogs.Animals
alias Smartcitydogs.AnimalStatus
alias Smartcitydogs.AnimalImages
alias Smartcitydogs.PerformedProcedures
alias Smartcitydogs.ProcedureType
alias Smartcitydogs.Rescues
alias Smartcitydogs.HeaderSlides
alias Smartcitydogs.News
alias Smartcitydogs.StaticPages
alias Smartcitydogs.SignalsCategories
alias Smartcitydogs.SignalsTypes
alias Smartcitydogs.UsersType
alias Smartcitydogs.User
alias Smartcitydogs.Signals
alias Smartcitydogs.SignalsComments
alias Smartcitydogs.SignalsImages
alias Smartcitydogs.Adopt

############## Users Type Admin #############
users_type_params = %{name: "Admin", prefix: "admin"}

unless Repo.get_by(UsersType, name: users_type_params[:name]) do
  %UsersType{}
  |> UsersType.changeset(users_type_params)
  |> Repo.insert!()
end

############## Users Type User #############
users_type_params = %{name: "User", prefix: "citizen"}

unless Repo.get_by(UsersType, name: users_type_params[:name]) do
  %UsersType{}
  |> UsersType.changeset(users_type_params)
  |> Repo.insert!()
end

############## Users Type Zoo Police#############
users_type_params = %{name: "zoo police", prefix: "police"}

unless Repo.get_by(UsersType, name: users_type_params[:name]) do
  %UsersType{}
  |> UsersType.changeset(users_type_params)
  |> Repo.insert!()
end

############## Users Type  representative of the municipality#############
users_type_params = %{name: "representative of the municipality", prefix: "municipality"}

unless Repo.get_by(UsersType, name: users_type_params[:name]) do
  %UsersType{}
  |> UsersType.changeset(users_type_params)
  |> Repo.insert!()
end

############## Users Type  representative of a municipal shelter#############
users_type_params = %{name: "representative of a municipal shelter", prefix: "shelter"}

unless Repo.get_by(UsersType, name: users_type_params[:name]) do
  %UsersType{}
  |> UsersType.changeset(users_type_params)
  |> Repo.insert!()
end

############## Users Admin #############
users_params = %{
  username: "admin",
  password: "password",
  first_name: "Admin",
  last_name: "Admin",
  email: "admin@test.bg",
  phone: "00000000000",
  users_types_id: 1,
  agreed_to_terms: true
}

unless Repo.get_by(User, username: users_params[:username]) do
  %User{}
  |> User.changeset(users_params)
  |> Repo.insert!()
end

############## Users Citizen #############
users_params = %{
  username: "citizen",
  password: "password",
  first_name: "citizen",
  last_name: "citizen",
  email: "citizen@test.bg",
  phone: "00000000000",
  users_types_id: 2,
  agreed_to_terms: true
}

unless Repo.get_by(User, username: users_params[:username]) do
  %User{}
  |> User.changeset(users_params)
  |> Repo.insert!()
end

############## Users Police #############
users_params = %{
  username: "police",
  first_name: "police",
  last_name: "police",
  email: "police@test.bg",
  password: "password",
  phone: "0000000000",
  users_types_id: 3,
  agreed_to_terms: true
}

unless Repo.get_by(User, username: users_params[:username]) do
  %User{}
  |> User.changeset(users_params)
  |> Repo.insert!()
end

############## Users Municipality #############
users_params = %{
  username: "municipality",
  first_name: "municipality",
  last_name: "municipality",
  email: "municipality@test.bg",
  password: "password",
  phone: "0000000000",
  users_types_id: 4,
  agreed_to_terms: true
}

unless Repo.get_by(User, username: users_params[:username]) do
  %User{}
  |> User.changeset(users_params)
  |> Repo.insert!()
end

############## Users Shelter #############
users_params = %{
  username: "shelter",
  first_name: "shelter",
  last_name: "shelter",
  email: "shelter@test.bg",
  password: "password",
  phone: "00000000000",
  users_types_id: 5,
  agreed_to_terms: true
}

unless Repo.get_by(User, username: users_params[:username]) do
  %User{}
  |> User.changeset(users_params)
  |> Repo.insert!()
end

############ Animal Status ############
animals_status_params = %{name: "На свобода", prefix: "free"}

unless Repo.get_by(AnimalStatus, name: animals_status_params[:name]) do
  %AnimalStatus{}
  |> AnimalStatus.changeset(animals_status_params)
  |> Repo.insert!()
end

############ Animal Status ############
animals_status_params = %{name: "В приюта", prefix: "shelter"}

unless Repo.get_by(AnimalStatus, name: animals_status_params[:name]) do
  %AnimalStatus{}
  |> AnimalStatus.changeset(animals_status_params)
  |> Repo.insert!()
end

############ Animal Status ############
animals_status_params = %{name: "Осиновено", prefix: "adopted"}

unless Repo.get_by(AnimalStatus, name: animals_status_params[:name]) do
  %AnimalStatus{}
  |> AnimalStatus.changeset(animals_status_params)
  |> Repo.insert!()
end

########     Procedure Type   ###############
procedure_type_prams = %{name: "Кастрирано", prefix: "castrated"}

unless Repo.get_by(ProcedureType, name: procedure_type_prams[:name]) do
  %ProcedureType{}
  |> ProcedureType.changeset(procedure_type_prams)
  |> Repo.insert!()
end

########     Procedure Type   ###############
procedure_type_prams = %{name: "Обезпаразитено", prefix: "deworm"}

unless Repo.get_by(ProcedureType, name: procedure_type_prams[:name]) do
  %ProcedureType{}
  |> ProcedureType.changeset(procedure_type_prams)
  |> Repo.insert!()
end

########     Procedure Type   ###############
procedure_type_prams = %{name: "Ваксинирано", prefix: "vaccinated"}

unless Repo.get_by(ProcedureType, name: procedure_type_prams[:name]) do
  %ProcedureType{}
  |> ProcedureType.changeset(procedure_type_prams)
  |> Repo.insert!()
end

Enum.each(0..99, fn _ ->
  animals_params = %{
    sex: "M",
    chip_number: Faker.Address.building_number(),
    address: Faker.Address.street_address(),
    description: Faker.Lorem.paragraph(),
    animals_status_id: Faker.random_between(1, 3)
  }

  unless Repo.get_by(Animals, chip_number: animals_params[:chip_number]) do
    animal =
      %Animals{}
      |> Animals.changeset(animals_params)
      |> Repo.insert!()

    animals_images_params = %{animals_id: animal.id, url: "images/escaped.jpg"}

    Enum.each(0..3, fn _ ->
      %AnimalImages{}
      |> AnimalImages.changeset(animals_images_params)
      |> Repo.insert!()
    end)
  end
end)

###############  Performed Procedures #################

animals_count = length(Repo.all(Animals))

Enum.each(0..99, fn _ ->
  performed_paramas = %{
    date: Ecto.DateTime.utc() |> Ecto.DateTime.to_string(),
    animals_id: Faker.random_between(1, animals_count),
    procedure_type_id: Faker.random_between(1, 3)
  }

  %PerformedProcedures{}
  |> PerformedProcedures.changeset(performed_paramas)
  |> Repo.insert!()
end)

#########    Rescues    ##############
Enum.each(0..99, fn _ ->
  rescue_param = %{name: Faker.Name.name(), animals_id: Faker.random_between(1, animals_count)}

  %Rescues{}
  |> Rescues.changeset(rescue_param)
  |> Repo.insert!()
end)

###########   Header Slides ############
header_params = %{image_url: "images/2.jpg", text: "Hello Phoenix"}

unless Repo.get_by(HeaderSlides, image_url: header_params[:image_url]) do
  %HeaderSlides{}
  |> HeaderSlides.changeset(header_params)
  |> Repo.insert!()
end

############# News #####################
Enum.each(0..99, fn _ ->
  news_params = %{
    image_url: "images/2.jpg",
    title: Faker.Lorem.Shakespeare.king_richard_iii(),
    content: Faker.Lorem.paragraph(),
    short_content: Faker.Lorem.sentence(),
    date: "2018-05-22 11:56:16"
  }

  %News{}
  |> News.changeset(news_params)
  |> Repo.insert!()
end)

############## Static Pages #############
static_params = %{content: "Home", keywords: "smart, dogs", meta: "wertrs", title: "Начало"}

unless Repo.get_by(StaticPages, content: static_params[:content]) do
  %StaticPages{}
  |> StaticPages.changeset(static_params)
  |> Repo.insert!()
end

############## Signals Categories #############
signal_categori_params = %{name: "Бездомно куче", prefix: "homeless"}

unless Repo.get_by(SignalsCategories, name: signal_categori_params[:name]) do
  %SignalsCategories{}
  |> SignalsCategories.changeset(signal_categori_params)
  |> Repo.insert!()
end

############## Signals Categories #############
signal_categori_params = %{name: "Избягало куче", prefix: "escaped"}

unless Repo.get_by(SignalsCategories, name: signal_categori_params[:name]) do
  %SignalsCategories{}
  |> SignalsCategories.changeset(signal_categori_params)
  |> Repo.insert!()
end

############## Signals Categories #############
signal_categori_params = %{name: "Малтретиране на куче", prefix: "mistreatment"}

unless Repo.get_by(SignalsCategories, name: signal_categori_params[:name]) do
  %SignalsCategories{}
  |> SignalsCategories.changeset(signal_categori_params)
  |> Repo.insert!()
end

############## Signals Types #############
signal_type_params = %{name: "Нов", prefix: "new"}

unless Repo.get_by(SignalsTypes, name: signal_type_params[:name]) do
  %SignalsTypes{}
  |> SignalsTypes.changeset(signal_type_params)
  |> Repo.insert!()
end

############## Signals Types #############

signal_type_params = %{name: "Приет", prefix: "accepted"}

unless Repo.get_by(SignalsTypes, name: signal_type_params[:name]) do
  %SignalsTypes{}
  |> SignalsTypes.changeset(signal_type_params)
  |> Repo.insert!()
end

############## Signals Types #############

signal_type_params = %{name: "Изпратен", prefix: "sent"}

unless Repo.get_by(SignalsTypes, name: signal_type_params[:name]) do
  %SignalsTypes{}
  |> SignalsTypes.changeset(signal_type_params)
  |> Repo.insert!()
end

############## Signals Types #############

signal_type_params = %{name: "Приключен", prefix: "closed"}

unless Repo.get_by(SignalsTypes, name: signal_type_params[:name]) do
  %SignalsTypes{}
  |> SignalsTypes.changeset(signal_type_params)
  |> Repo.insert!()
end

Enum.each(0..99, fn _ ->
  ############## Signals #############
  signals_params = %{
    address: Faker.Address.street_address(),
    chip_number: Faker.Address.postcode(),
    description: Faker.Lorem.sentence(),
    support_count: 0,
    title: Faker.Lorem.sentence(),
    view_count: 0,
    signals_categories_id: Faker.random_between(1, 3),
    signals_types_id: Faker.random_between(1, 4),
    users_id: Faker.random_between(1, 4)
  }

  signal = %Signals{} |> Signals.changeset(signals_params) |> Repo.insert!()
  ############## Signals Images #############
  Enum.each(0..5, fn _ ->
    signal_image_params = %{signals_id: signal.id, url: "images/escaped.jpg"}

    %SignalsImages{}
    |> SignalsImages.changeset(signal_image_params)
    |> Repo.insert!()
  end)

  Enum.each(0..5, fn _ ->
    ############## Signals Comments #############
    signal_comment_params = %{
      comment: Faker.Lorem.sentence(),
      users_id: Faker.random_between(1, 4),
      signals_id: signal.id
    }

    %SignalsComments{} |> SignalsComments.changeset(signal_comment_params) |> Repo.insert!()
  end)
end)

Enum.each(0..15, fn _ ->
  ################## Adopt ####################
  adopt_params = %{
    users_id: Faker.random_between(1, 4),
    animals_id: Faker.random_between(1, animals_count)
  }

  %Adopt{}
  |> Adopt.changeset(adopt_params)
  |> Repo.insert!()
end)
