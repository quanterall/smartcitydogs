defmodule SmartcitydogsWeb.SignalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.Signals
  alias Smartcitydogs.DataUser
  alias Smartcitydogs.DataAnimals
  alias Smartcitydogs.Repo

  plug(:put_layout, false when action in [:filter_index])
  plug(:put_layout, false when action in [:adopted_animals])
  plug(:put_layout, false when action in [:shelter_animals])
  # plug :put_layout, false when action in [:filter_index]

  def index(conn, _params) do
    signal = DataSignals.list_signals()
    render(conn, "filter_index.html", signal: signal)
  end

  def new(conn, _params) do
    changeset = Smartcitydogs.DataSignals.change_signal(%Signals{})

    logged_user_type_id = conn.assigns.current_user.users_types.id
    IO.inspect(logged_user_type_id)

    if logged_user_type_id == 4 || logged_user_type_id == 2 do
      render(conn, "new_signal.html", changeset: changeset)
    else
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end

  def create(conn, %{"signals" => signal_params}) do
    a = conn.assigns.current_user.id
    logged_user_type_id = conn.assigns.current_user.users_types.id

    if logged_user_type_id == 4 || logged_user_type_id == 2 do
      signal_params =
        signal_params
        |> Map.put("signals_types_id", 1)
        |> Map.put("view_count", 1)
        |> Map.put("support_count", 0)
        |> Map.put("users_id", a)

      case DataSignals.create_signal(signal_params) do
        {:ok, signal} ->
          upload = Map.get(conn, :params)
          # IO.inspect(conn)
          upload = Map.get(upload, "signals")
          # IO.inspect(upload)
          upload = Map.get(upload, "url")
          # IO.inspect(upload)
          for n <- upload do
            # [head] = n
            IO.puts("\n N:")
            IO.inspect(n)

            extension = Path.extname(n.filename)

            File.cp(
              n.path,
              "/home/hris/Elixir/smartcitydogs/assets/static/images/#{Map.get(n, :filename)}-profile#{
                extension
              }"
            )

            args = %{
              "url" => "images/#{Map.get(n, :filename)}-profile#{extension}",
              "signals_id" => "#{signal.id}"
            }

            DataSignals.create_signal_images(args)
          end

          redirect(conn, to: signal_path(conn, :show, signal))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new_signal.html", changeset: changeset)
      end
    else
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end

  def show(conn, %{"id" => id}) do
    comments = DataSignals.get_comment_signal_id(id)
    signal = DataSignals.get_signal(id)

    render(conn, "show_signal.html", signal: signal, comments: comments)
  end

  def edit(conn, %{"id" => id}) do
    signal = DataSignals.get_signal(id)

    logged_user_type_id = conn.assigns.current_user.users_types.id

    if logged_user_type_id == 2 do
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    else
      changeset = DataSignals.change_signal(signal)
      render(conn, "edit_signal.html", signal: signal, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "signals" => signal_params}) do
    signal = DataSignals.get_signal(id)

    logged_user_type_id = conn.assigns.current_user.users_types.id

    if logged_user_type_id == 2 do
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    else
      case DataSignals.update_signal(signal, signal_params) do
        {:ok, signal} ->
          conn
          |> put_flash(:info, "Signal updated successfully.")
          |> render("show_signal.html", signal: signal)

        # redirect(to: signal_path(conn, :show, signal))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit_signal.html", signal: signal, changeset: changeset)
      end
    end
  end

  def get_signals_support_count(signal_id) do
    list = Smartcitydogs.DataSignals.get_signal_support_count(signal_id)

    if list != [] do
      [head | tail] = list
      count = head.support_count
      Smartcitydogs.DataSignals.update_signal(head, %{support_count: count + 1})
    end

    head.support_count + 1
  end

  def update_like_count(conn, %{"show-count" => show_count, "show-id" => show_id}) do
    signal = DataSignals.get_signal(show_id)
    count = get_signals_support_count(show_id)

    conn
    |> json(%{new_count: count})
  end

  def update_type(conn, %{"id" => id, "signals_types_id" => signals_types_id}) do
    signal = DataSignals.get_signal(id)
    DataSignals.update_signal(signal, %{"signals_types_id" => signals_types_id})

    signals = DataSignals.list_signals()
    render(conn, "index_signals.html", signals: signals)
  end

  # def my_signals(conn) do
  #   user = conn.assigns.current_user.id
  #   signals = DataSignals.get_user_signal(user)
  #   render("my_signals.html", signals: signals)
  # end

  def comment(conn, %{"show-comment" => show_comment, "show-id" => show_id}) do
    user_id = conn.assigns.current_user.id

    Smartcitydogs.DataSignals.create_signal_comment(%{
      comment: show_comment,
      signals_id: show_id,
      users_id: user_id
    })

    render("show_signal.html")
  end

  def delete(conn, %{"id" => id}) do
    signal = DataSignals.get_signal(id)
    logged_user_id = conn.assigns.current_user.id

    if logged_user_id != signal.users_id do
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    else
      {:ok, _signal} = DataSignals.delete_signal(id)

      conn
      |> put_flash(:info, "Signal deleted successfully.")
      |> redirect(to: signal_path(conn, :index))
    end
  end

  def filter_index(conn, _params) do
    signal = DataSignals.list_signals()
    render(conn, "index_signal.html", signal: signal)
  end

  def adopted_animals(conn, _params) do
    animals = DataAnimals.get_adopted_animals() |> Repo.preload(:animals_status )
    render(conn, "adopted_animals.html", animals: animals)
  end

  def shelter_animals(conn, _params) do
    animals = DataAnimals.get_shelter_animals() |> Repo.preload(:animals_status)
    render(conn, "shelter_animals.html", animals: animals)
  end

end
