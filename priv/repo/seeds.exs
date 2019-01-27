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

alias Smartcitydogs.SignalCategory
alias Smartcitydogs.SignalType
alias Smartcitydogs.AnimalStatus

alias Smartcitydogs.User

############## Users Admin #############
[
  %{
    username: "admin",
    password: "password",
    first_name: "Admin",
    last_name: "Admin",
    email: "admin@test.bg",
    phone: "00000000000",
    user_type_id: 1,
    agreed_to_terms: true
  },
  %{
    username: "citizen",
    password: "password",
    first_name: "citizen",
    last_name: "citizen",
    email: "citizen@test.bg",
    phone: "00000000000",
    user_type_id: 2,
    agreed_to_terms: true
  },
  %{
    username: "police",
    first_name: "police",
    last_name: "police",
    email: "police@test.bg",
    password: "password",
    phone: "0000000000",
    user_type_id: 3,
    agreed_to_terms: true
  },
  %{
    username: "municipality",
    first_name: "municipality",
    last_name: "municipality",
    email: "municipality@test.bg",
    password: "password",
    phone: "0000000000",
    user_type_id: 4,
    agreed_to_terms: true
  },
  %{
    username: "shelter",
    first_name: "shelter",
    last_name: "shelter",
    email: "shelter@test.bg",
    password: "password",
    phone: "00000000000",
    user_type_id: 5,
    agreed_to_terms: true
  }
]
|> Enum.each(fn params ->
  User.create(params)
end)

############## Signal Categories #############
[
  %{name: "Бездомно куче", prefix: "homeless"},
  %{name: "Избягало куче", prefix: "escaped"},
  %{name: "Малтретиране на куче", prefix: "mistreatment"}
]
|> Enum.each(fn params ->
  SignalCategory.create(params)
end)

############## Signal Types #############
[
  %{name: "Нов", prefix: "new"},
  %{name: "Приет", prefix: "accepted"},
  %{name: "Изпратен", prefix: "sent"},
  %{name: "Приключен", prefix: "closed"}
]
|> Enum.each(fn params ->
  SignalType.create(params)
end)

############## Animal Status #############
[
  %{name: "На свобода", prefix: "free"},
  %{name: "В приюта", prefix: "shelter"},
  %{name: "Осиновено", prefix: "adopted"}
]
|> Enum.each(fn params ->
  AnimalStatus.create(params)
end)
