defmodule SmartcitydogsWeb.AnimalView do
  use SmartcitydogsWeb, :view
  import Scrivener.HTML
  alias Smartcitydogs.Animal

  def sex(sex) do
    case sex do
      "male" -> "Мъжко"
      "female" -> "Женско"
    end
  end
end
