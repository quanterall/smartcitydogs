defmodule SmartcitydogsWeb.SignalControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Signal
  alias Smartcitydogs.DataSignal
  alias Smartcitydogs.DataUsers
  alias Smartcitydogs.Repo
  action_fallback(SmartcitydogsWeb.FallbackController)

  plug(:put_layout, false when action in [:minicipality_signals])
  plug(:put_layout, false when action in [:minicipality_registered])
  plug(:put_layout, false when action in [:minicipality_adopted])
  plug(:put_layout, false when action in [:minicipality_shelter])
  plug(:put_layout, false when action in [:new])

  def index(conn, _params) do
    signals =
      Repo.all(Signal)
      |> Repo.preload([
        :user,
        :signal_images,
        :signal_comments,
        {:signal_comments, :user},
        :signal_category,
        :signal_type
      ])
      |> SmartcitydogsWeb.Encoder.struct_to_map()

    json(conn, signals)
  end

  def show(conn, %{"id" => id}) do
    signal =
      Repo.get(Signal, id)
      |> Repo.preload([
        :user,
        :signal_images,
        :signal_comments,
        :signal_category,
        :signal_type
      ])
      |> SmartcitydogsWeb.Encoder.struct_to_map()

    json(conn, signal)
  end

  def create(conn, params) do
    #  a = conn.assigns.current_user.id
    user_id = conn.private.plug_session["current_user_id"]
    IO.inspect(params)

    signal_params =
      params
      |> Map.put("signal_type_id", 1)
      |> Map.put("signal_category_id", 1)
      |> Map.put("view_count", 0)
      |> Map.put("support_count", 0)
      |> Map.put("user_id", user_id)

    signal = DataSignal.create_signal(signal_params)
    images = Map.get(params, "images")

    if images do
      for n <- images do
        extension = Path.extname(n.filename)

        File.cp(
          n.path,
          File.cwd!() <> "/priv/static/images/#{Map.get(n, :filename)}-profile#{extension}"
        )

        args = %{
          "url" => "images/#{Map.get(n, :filename)}-profile#{extension}",
          "signal_id" => "#{signal.id}"
        }

        DataSignal.create_signal_images(args)
      end
    end

    redirect(conn, to: signal_controller_api_path(conn, :show, signal))

    # redirect(conn, to: signal_path(conn, :show, signal))
  end

  def update(conn, signal_params) do
    signal = DataSignal.get_signal(signal_params.id)

    with {:ok, %Signal{} = signal} <- DataSignal.update_signal(signal, signal_params) do
      render(conn, "show.json", signal: signal)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Signal{}} <- DataSignal.delete_signal(id) do
      send_resp(conn, :no_content, "")
    end
  end

  def like(conn, params) do
    user_id = conn.private.plug_session["current_user_id"]
    signal = DataSignal.get_signal(params["id"])
    like = DataSignal.create_signal_like(%{user_id: user_id, signal_id: signal.id})

    conn
    |> json(%{new_count: like})
  end

  def unlike(conn, %{"user_id" => user_id, "signal_id" => signal_id}) do
    %{id: id} = DataSignal.get_signal_like_by_user_and_signal(user_id, signal_id)

    DataSignal.delete_signal_like(id)

    conn
    |> json(%{status: "success"})
  end

  def comment(conn, map) do
    show_comment = map["show-comment"]
    show_id = String.to_integer(map["show-id"])
    user_id = conn.private.plug_session["current_user_id"]

    Smartcitydogs.DataSignal.create_signal_comment(%{
      comment: show_comment,
      signal_id: show_id,
      user_id: user_id
    })

    comments = Smartcitydogs.DataSignal.get_comment_signal_id(show_id)
    signal = Smartcitydogs.DataSignal.get_signal(show_id)
    sorted_comments = Smartcitydogs.DataSignal.sort_signal_comment_by_id()

    redirect(conn,
      to:
        signal_path(conn, :show, signal, %{
          "comments" => comments,
          "sorted_comments" => sorted_comments
        })
    )
  end
end
