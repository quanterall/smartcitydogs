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
alias Smartcitydogs.Animal
alias Smartcitydogs.Signal

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
    user_type: "admin",
    agreed_to_terms: true
  },
  %{
    username: "citizen",
    password: "password",
    first_name: "citizen",
    last_name: "citizen",
    email: "citizen@test.bg",
    phone: "00000000000",
    user_type: "citizen",
    agreed_to_terms: true
  },
  %{
    username: "police",
    first_name: "police",
    last_name: "police",
    email: "police@test.bg",
    password: "password",
    phone: "0000000000",
    user_type: "police",
    agreed_to_terms: true
  },
  %{
    username: "municipality",
    first_name: "municipality",
    last_name: "municipality",
    email: "municipality@test.bg",
    password: "password",
    phone: "0000000000",
    user_type: "municipality",
    agreed_to_terms: true
  },
  %{
    username: "shelter",
    first_name: "shelter",
    last_name: "shelter",
    email: "shelter@test.bg",
    password: "password",
    phone: "00000000000",
    user_type: "shelter",
    agreed_to_terms: true
  }
]
|> Enum.each(&User.create(&1))

############## Signal Categories #############
[
  %{name: "Бездомно куче", prefix: "homeless"},
  %{name: "Избягало куче", prefix: "escaped"},
  %{name: "Малтретиране на куче", prefix: "mistreatment"}
]
|> Enum.each(&SignalCategory.create(&1))

############## Signal Types #############
[
  %{name: "Нов", prefix: "new"},
  %{name: "Приет", prefix: "accepted"},
  %{name: "Изпратен", prefix: "sent"},
  %{name: "Приключен", prefix: "closed"}
]
|> Enum.each(&SignalType.create(&1))

############## Animal Status #############
[
  %{name: "На свобода", prefix: "free"},
  %{name: "В приюта", prefix: "shelter"},
  %{name: "Осиновено", prefix: "adopted"}
]
|> Enum.each(&AnimalStatus.create(&1))

############## Animal #############
[
  %{
    sex: "male",
    chip_number: "1",
    address: "lorem asd asda",
    longitude: "123123.123",
    latitude: "1231.123123",
    description: "adja sd alsjkdh laksjdhlaks",
    adopted_at: nil,
    animal_status_id: 1
  },
  %{
    sex: "male",
    chip_number: "2",
    address: "lorem asd asda",
    longitude: "123123.123",
    latitude: "1231.123123",
    description: "adja sd alsjkdh laksjdhlaks",
    adopted_at: nil,
    animal_status_id: 2
  },
  %{
    sex: "male",
    chip_number: "3",
    address: "lorem asd asda",
    longitude: "123123.123",
    latitude: "1231.123123",
    description: "adja sd alsjkdh laksjdhlaks",
    adopted_at: nil,
    animal_status_id: 3
  },
  %{
    sex: "male",
    chip_number: "4",
    address: "lorem asd asda",
    longitude: "123123.123",
    latitude: "1231.123123",
    description: "adja sd alsjkdh laksjdhlaks",
    adopted_at: nil,
    animal_status_id: 3
  }
]
|> Enum.each(&Animal.create(&1))

[
  %{
    address: "nov adrees",
    chip_number: "1",
    description: "asdfasfasdasd",
    latitude: nil,
    longitude: nil,
    signal_category_id: 1,
    signal_type_id: 1,
    title: "new dog",
    user_id: 1,
    view_count: 1
  },
  %{
    address: "nov adrees",
    chip_number: "2",
    description: "asdfasfasdasd",
    latitude: nil,
    longitude: nil,
    signal_category_id: 2,
    signal_type_id: 2,
    title: "new dog",
    user_id: 1,
    view_count: 1
  },
  %{
    address: "nov adrees",
    chip_number: "3",
    description: "asdfasfasdasd",
    latitude: nil,
    longitude: nil,
    signal_category_id: 3,
    signal_type_id: 3,
    title: "new dog",
    user_id: 1,
    view_count: 1
  },
  %{
    address: "nov adrees",
    chip_number: "4",
    description: "asdfasfasdasd",
    latitude: nil,
    longitude: nil,
    signal_category_id: 3,
    signal_type_id: 4,
    title: "new dog",
    user_id: 1,
    view_count: 1
  }
]
|> Enum.each(&Signal.create(&1))
