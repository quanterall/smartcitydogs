defmodule SmartcitydogsWeb.NewsView do
  use SmartcitydogsWeb, :view
  alias Smartcitydogs.Markdown

  def render_markdown(binary) do
    Markdown.to_html(binary)
    |> Phoenix.HTML.raw() # Convert to {:safe, iodata} tuple
  end

end

defmodule Smartcitydogs.Markdown do
  defstruct text: "", html: nil
  def to_html(%__MODULE__{html: html}) when is_binary(html) do
    html
  end
  def to_html(%__MODULE__{text: text}), do: to_html(text)
  def to_html(binary) when is_binary(binary) do
    Cmark.to_html(binary)
  end
  def to_html(_other), do: ""
  defimpl Phoenix.HTML.Safe do    
    def to_iodata(%Smartcitydogs.Markdown{} = markdown) do
      Smartcitydogs.Markdown.to_html(markdown)
    end
  end
end