# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SmartCityDogs.Repo.insert!(%SmartCityDogs.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SmartCityDogs.Repo

alias SmartCityDogs.Users.User
alias SmartCityDogs.AnimalImages.AnimalImage
alias SmartCityDogs.AnimalStatuses.AnimalStatus
alias SmartCityDogs.Animals.Animal
alias SmartCityDogs.Contacts.Contact
alias SmartCityDogs.HeaderSlides.HeaderSlide
alias SmartCityDogs.News.NewsSchema
alias SmartCityDogs.PerformedProcedures.PerformedProcedure
alias SmartCityDogs.ProcedureTypes.ProcedureType
alias SmartCityDogs.Rescues.Rescue
alias SmartCityDogs.SignalImages.SignalImage
alias SmartCityDogs.Signals.Signal
alias SmartCityDogs.SignalsCategories.SignalCategory
alias SmartCityDogs.SignalsComments.SignalsComment
alias SmartCityDogs.SignalsLikes.SignalsLike
alias SmartCityDogs.SignalsTypes.SignalsType
alias SmartCityDogs.StaticPages.StaticPage
alias SmartCityDogs.UsersTypes.UsersType

############## Users Type Admin #############
users_type_params = %{name: "Admin"}

unless Repo.get_by(UsersType, name: users_type_params[:name]) do
  %UsersType{}
  |> UsersType.changeset(users_type_params)
  |> Repo.insert!()
end

############## Users Type User #############
users_type_params = %{name: "User"}

unless Repo.get_by(UsersType, name: users_type_params[:name]) do
  %UsersType{}
  |> UsersType.changeset(users_type_params)
  |> Repo.insert!()
end

############## Users Type Zoo Police#############
users_type_params = %{name: "zoo police"}

unless Repo.get_by(UsersType, name: users_type_params[:name]) do
  %UsersType{}
  |> UsersType.changeset(users_type_params)
  |> Repo.insert!()
end

############## Users Type  representative of the municipality#############
users_type_params = %{name: "representative of the municipality"}

unless Repo.get_by(UsersType, name: users_type_params[:name]) do
  %UsersType{}
  |> UsersType.changeset(users_type_params)
  |> Repo.insert!()
end

############## Users Type  representative of a municipal shelter#############
users_type_params = %{name: "representative of a municipal shelter"}

unless Repo.get_by(UsersType, name: users_type_params[:name]) do
  %UsersType{}
  |> UsersType.changeset(users_type_params)
  |> Repo.insert!()
end

############## Users #############
users_params = %{
  username: "Admin",
  password_hash: "DDGFDDHRTEWFVFBHJKILOIUJTGERFRVRV",
  first_name: "Admin",
  last_name: "Admin",
  email: "admin@test.bg",
  phone: "0873245473",
  users_types_id: 1
}

unless Repo.get_by(User, username: users_params[:username]) do
  %User{}
  |> User.changeset(users_params)
  |> Repo.insert!()
end

# ############## Users #############
# users_params = %{
#   username: "Sonyft",
#   first_name: "SS",
#   last_name: "admin",
#   email: "sonyft@abv.bg",
#   password: "123456",
#   phone: "0873245473",
#   users_types_id: 1
# }
#
# unless Repo.get_by(User, username: users_params[:username]) do
  # %User{}
  # |> User.registration_changeset(users_params)
  # |> Repo.insert!()
# end
# ############## Users #############
# users_params = %{
#   username: "todor",
#   first_name: "Todor",
#   last_name: "Todorov",
#   email: "t.todorov2505@gmail.com",
#   password: "password",
#   phone: "0896230250",
#   users_types_id: 1
# }
#
# unless Repo.get_by(User, username: users_params[:username]) do
#   %User{}
#   |> User.registration_changeset(users_params)
#   |> Repo.insert!()
# end

############ Animal Status ############
animals_status_params = %{name: "На свобода"}

unless Repo.get_by(AnimalStatus, name: animals_status_params[:name]) do
  %AnimalStatus{}
  |> AnimalStatus.changeset(animals_status_params)
  |> Repo.insert!()
end

############ Animal Status ############
animals_status_params = %{name: "Осиновено"}

unless Repo.get_by(AnimalStatus, name: animals_status_params[:name]) do
  %AnimalStatus{}
  |> AnimalStatus.changeset(animals_status_params)
  |> Repo.insert!()
end

############ Animal Status ############
animals_status_params = %{name: "В приюта"}

unless Repo.get_by(AnimalStatus, name: animals_status_params[:name]) do
  %AnimalStatus{}
  |> AnimalStatus.changeset(animals_status_params)
  |> Repo.insert!()
end

#############  Animals #######
animals_params = %{
  sex: "M",
  chip_number: "dsfdsfs2",
  address: "Kolio Ficheto 24",
  animal_status_id: 1
}

unless Repo.get_by(Animal, chip_number: animals_params[:chip_number]) do
  %Animal{}
  |> Animal.changeset(animals_params)
  |> Repo.insert!()
end

############# Animal Images ################
animals_images_params = %{url: "images/2.jpg", animal_id: 1}

unless Repo.get_by(AnimalImage, url: animals_images_params[:url]) do
  %AnimalImage{}
  |> AnimalImage.changeset(animals_images_params)
  |> Repo.insert!()
end

########     Procedure Type   ###############
procedure_type_prams = %{name: "Kill"}

unless Repo.get_by(ProcedureType, name: procedure_type_prams[:name]) do
  %ProcedureType{}
  |> ProcedureType.changeset(procedure_type_prams)
  |> Repo.insert!()
end

###############  Performed Procedures #################

time = Ecto.DateTime.utc()
performed_paramas = %{date: Ecto.DateTime.to_string(time), animal_id: 1, procedure_type_id: 1}

# performed_paramas = %{date: "2018-05-22 11:56:16", animals_id: 10, procedure_type_id: 1}

unless Repo.get_by(PerformedProcedure, date: performed_paramas[:date]) do
  %PerformedProcedure{}
  |> PerformedProcedure.changeset(performed_paramas)
  |> Repo.insert!()
end

#########    Rescues    ##############

rescue_param = %{name: "Danger", animal_id: 1}

unless Repo.get_by(Rescue, name: rescue_param[:name]) do
  %Rescue{}
  |> Rescue.changeset(rescue_param)
  |> Repo.insert!()
end

###########   Header Slides ############
header_params = %{image_url: "images/2.jpg", text: "Hello Phoenix"}

unless Repo.get_by(HeaderSlide, image_url: header_params[:image_url]) do
  %HeaderSlide{}
  |> HeaderSlide.changeset(header_params)
  |> Repo.insert!()
end

############# News #####################
news_params = %{
  image_url: "images/2.jpg",
  title: "Изгубено куче!",
  meta: "kuce, miss",
  keywords: "miss, lost",
  content: "Obatede se ako go namerite",
  short_content: "Help my",
  date: "2018-05-22 11:56:16"
}

unless Repo.get_by(NewsSchema, image_url: news_params[:image_url]) do
  %NewsSchema{}
  |> NewsSchema.changeset(news_params)
  |> Repo.insert!()
end

############## Static Pages #############
static_params = %{content: "Home", keywords: "smart, dogs", meta: "wertrs", title: "Начало"}

unless Repo.get_by(StaticPage, content: static_params[:content]) do
  %StaticPage{}
  |> StaticPage.changeset(static_params)
  |> Repo.insert!()
end

############## Signals Categories #############
signal_categori_params = %{name: "Бездомно куче"}

unless Repo.get_by(SignalCategory, name: signal_categori_params[:name]) do
  %SignalCategory{}
  |> SignalCategory.changeset(signal_categori_params)
  |> Repo.insert!()
end

############## Signals Categories #############
signal_categori_params = %{name: "Избягало куче"}

unless Repo.get_by(SignalCategory, name: signal_categori_params[:name]) do
  %SignalCategory{}
  |> SignalCategory.changeset(signal_categori_params)
  |> Repo.insert!()
end

############## Signals Categories #############
signal_categori_params = %{name: "Малтретиране на куче"}

unless Repo.get_by(SignalCategory, name: signal_categori_params[:name]) do
  %SignalCategory{}
  |> SignalCategory.changeset(signal_categori_params)
  |> Repo.insert!()
end

############## Signals Types #############
signal_type_params = %{name: "Нов"}

unless Repo.get_by(SignalsType, name: signal_type_params[:name]) do
  %SignalsType{}
  |> SignalsType.changeset(signal_type_params)
  |> Repo.insert!()
end

############## Signals Types #############

signal_type_params = %{name: "Приет"}

unless Repo.get_by(SignalsType, name: signal_type_params[:name]) do
  %SignalsType{}
  |> SignalsType.changeset(signal_type_params)
  |> Repo.insert!()
end

############## Signals Types #############

signal_type_params = %{name: "Изпратен към компетентен орган"}

unless Repo.get_by(SignalsType, name: signal_type_params[:name]) do
  %SignalsType{}
  |> SignalsType.changeset(signal_type_params)
  |> Repo.insert!()
end

############## Signals Types #############

signal_type_params = %{name: "Приключен"}

unless Repo.get_by(SignalsType, name: signal_type_params[:name]) do
  %SignalsType{}
  |> SignalsType.changeset(signal_type_params)
  |> Repo.insert!()
end

############## Signals #############
signals_params = %{
  address: "бул. Владислав Варненчик",
  chip_number: "2343565645",
  description: "Нападение",
  support_count: 0,
  title: "Внимавайте",
  view_count: 0,
  signals_categories_id: 1,
  signals_types_id: 1,
  users_id: 1
}

%Signal{} |> Signal.changeset(signals_params) |> Repo.insert!()

############## Signals Images #############
signal_image_params = %{url: "images/1.jpg", signals_id: 1}

unless Repo.get_by(SignalImage, url: signal_image_params[:url]) do
  %SignalImage{}
  |> SignalImage.changeset(signal_image_params)
  |> Repo.insert!()
end

############## Signals Comments #############
signal_comment_params = %{
  comment: "Още е там никой не го е прибрал??",
  users_id: 1,
  signals_id: 1
}

%SignalsComment{} |> SignalsComment.changeset(signal_comment_params) |> Repo.insert!()

############# Signals Likes ##############

signal_likes_params = %{
  like: 2,
  signals_id: 1,
  users_id: 1
}

%SignalsLike{} |> SignalsLike.changeset(signal_likes_params) |> Repo.insert!()

############# Contacts ##############

contacts_params = %{
  topic: "Въпрос",
  text: "Как да изтрия сигнал?",
  users_id: 1
}

%Contact{} |> Contact.changeset(contacts_params) |> Repo.insert!()

########### GET Data from databse ##########
# Repo.all(Animals)
# Repo.all(AnimalStatus)
# Repo.all(AnimalImages)
# Repo.all(PerformedProcedures)
# Repo.all(ProcedureType)
