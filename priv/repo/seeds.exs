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
alias Smartcitydogs.SignalImages

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

############## Users #############
users_params = %{
  username: "Sonyft",
  first_name: "SS",
  last_name: "admin",
  email: "sonyft@abv.bg",
  password: "123456",
  phone: "0873245473",
  users_types_id: 1
}

unless Repo.get_by(User, username: users_params[:username]) do
  %User{}
  |> User.registration_changeset(users_params)
  |> Repo.insert!()
end

############## Users #############
users_params = %{
  username: "todor",
  first_name: "Todor",
  last_name: "Todorov",
  email: "t.todorov2505@gmail.com",
  password: "password",
  phone: "0896230250",
  users_types_id: 1
}

unless Repo.get_by(User, username: users_params[:username]) do
  %User{}
  |> User.registration_changeset(users_params)
  |> Repo.insert!()
end

############## Users #############
users_params = %{
  username: "hris",
  first_name: "Hristislav",
  last_name: "Gospodinov",
  email: "test@abv.bg",
  password: "123456",
  phone: "0896230250",
  users_types_id: 2
}

unless Repo.get_by(User, username: users_params[:username]) do
  %User{}
  |> User.registration_changeset(users_params)
  |> Repo.insert!()
end

############## Users #############
users_params = %{
  username: "todor_municipaty",
  first_name: "Todor",
  last_name: "Todorov",
  email: "todor_municipaty@gmail.com",
  password: "password",
  phone: "0896230250",
  users_types_id: 4
}

unless Repo.get_by(User, username: users_params[:username]) do
  %User{}
  |> User.registration_changeset(users_params)
  |> Repo.insert!()
end

############ Animal Status ############
animals_status_params = %{name: "На свобода"}

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

############ Animal Status ############
animals_status_params = %{name: "Осиновено"}

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
  description: "ala bala 1",
  animals_status_id: 1
}

unless Repo.get_by(Animals, chip_number: animals_params[:chip_number]) do
  %Animals{}
  |> Animals.changeset(animals_params)
  |> Repo.insert!()
end

#############  Animals #######
animals_params = %{
  sex: "M",
  chip_number: "adopted234",
  address: "Kolio Ficheto 24",
  description: "ala bala 2",
  animals_status_id: 2
}

unless Repo.get_by(Animals, chip_number: animals_params[:chip_number]) do
  %Animals{}
  |> Animals.changeset(animals_params)
  |> Repo.insert!()
end

#############  Animals #######
animals_params = %{
  sex: "M",
  chip_number: "shelter789",
  address: "Kolio Ficheto 24",
  description: "ala bala 3",
  animals_status_id: 3
}

unless Repo.get_by(Animals, chip_number: animals_params[:chip_number]) do
  %Animals{}
  |> Animals.changeset(animals_params)
  |> Repo.insert!()
end

### Insert in table Animals (animals_params)
# unless Repo.get_by(Animals, chip_number: animals_params[:chip_number]) do
# %Animals{sex: "M", chip_number: "2321243242", address: "Kolio Ficheto 24",  animals_status_id: 1}
# |>Repo.insert!
# end

############# Animal Images ################
animals_images_params = %{url: "images/2.jpg", animals_id: 1}

unless Repo.get_by(AnimalImages, url: animals_images_params[:url]) do
  %AnimalImages{}
  |> AnimalImages.changeset(animals_images_params)
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
performed_paramas = %{date: Ecto.DateTime.to_string(time), animals_id: 1, procedure_type_id: 1}

# performed_paramas = %{date: "2018-05-22 11:56:16", animals_id: 10, procedure_type_id: 1}

unless Repo.get_by(PerformedProcedures, date: performed_paramas[:date]) do
  %PerformedProcedures{}
  |> PerformedProcedures.changeset(performed_paramas)
  |> Repo.insert!()
end

#########    Rescues    ##############

rescue_param = %{name: "Danger", animals_id: 1}

unless Repo.get_by(Rescues, name: rescue_param[:name]) do
  %Rescues{}
  |> Rescues.changeset(rescue_param)
  |> Repo.insert!()
end

###########   Header Slides ############
header_params = %{image_url: "images/2.jpg", text: "Hello Phoenix"}

unless Repo.get_by(HeaderSlides, image_url: header_params[:image_url]) do
  %HeaderSlides{}
  |> HeaderSlides.changeset(header_params)
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

unless Repo.get_by(News, image_url: news_params[:image_url]) do
  %News{}
  |> News.changeset(news_params)
  |> Repo.insert!()
end

############## Static Pages #############
static_params = %{content: "Home", keywords: "smart, dogs", meta: "wertrs", title: "Начало"}

unless Repo.get_by(StaticPages, content: static_params[:content]) do
  %StaticPages{}
  |> StaticPages.changeset(static_params)
  |> Repo.insert!()
end

############## Signals Categories #############
signal_categori_params = %{name: "Бездомно куче"}

unless Repo.get_by(SignalsCategories, name: signal_categori_params[:name]) do
  %SignalsCategories{}
  |> SignalsCategories.changeset(signal_categori_params)
  |> Repo.insert!()
end

############## Signals Categories #############
signal_categori_params = %{name: "Избягало куче"}

unless Repo.get_by(SignalsCategories, name: signal_categori_params[:name]) do
  %SignalsCategories{}
  |> SignalsCategories.changeset(signal_categori_params)
  |> Repo.insert!()
end

############## Signals Categories #############
signal_categori_params = %{name: "Малтретиране на куче"}

unless Repo.get_by(SignalsCategories, name: signal_categori_params[:name]) do
  %SignalsCategories{}
  |> SignalsCategories.changeset(signal_categori_params)
  |> Repo.insert!()
end

############## Signals Types #############
signal_type_params = %{name: "Нов"}

unless Repo.get_by(SignalsTypes, name: signal_type_params[:name]) do
  %SignalsTypes{}
  |> SignalsTypes.changeset(signal_type_params)
  |> Repo.insert!()
end

############## Signals Types #############

signal_type_params = %{name: "Приет"}

unless Repo.get_by(SignalsTypes, name: signal_type_params[:name]) do
  %SignalsTypes{}
  |> SignalsTypes.changeset(signal_type_params)
  |> Repo.insert!()
end

############## Signals Types #############

signal_type_params = %{name: "Изпратен"}

unless Repo.get_by(SignalsTypes, name: signal_type_params[:name]) do
  %SignalsTypes{}
  |> SignalsTypes.changeset(signal_type_params)
  |> Repo.insert!()
end

############## Signals Types #############

signal_type_params = %{name: "Приключен"}

unless Repo.get_by(SignalsTypes, name: signal_type_params[:name]) do
  %SignalsTypes{}
  |> SignalsTypes.changeset(signal_type_params)
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

%Signals{} |> Signals.changeset(signals_params) |> Repo.insert!()

############## Signals Images #############
signal_image_params = %{url: "images/1.jpg", signals_id: 1}

unless Repo.get_by(SignalImages, url: signal_image_params[:url]) do
  %SignalImages{}
  |> SignalImages.changeset(signal_image_params)
  |> Repo.insert!()
end

############## Signals Comments #############
signal_comment_params = %{
  comment: "Още е там никой не го е прибрал??",
  users_id: 1,
  signals_id: 1
}

%SignalsComments{} |> SignalsComments.changeset(signal_comment_params) |> Repo.insert!()

########### GET Data from databse ##########
Repo.all(Animals)
Repo.all(AnimalStatus)
Repo.all(AnimalImages)
Repo.all(PerformedProcedures)
Repo.all(ProcedureType)
