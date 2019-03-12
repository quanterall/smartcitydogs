defmodule SmartcitydogsWeb.RoomChannel do
  use Phoenix.Channel

  alias Smartcitydogs.Blockchain

  @auth_password Application.fetch_env!(:smartcitydogs, :blockchain_secret)
  @blockchain_url Application.fetch_env!(:smartcitydogs, :blockchain_url)
  @topic "room:blockchain_validation"
  def join("room:blockchain_validation", _mesage, socket) do
    {:ok, socket}
  end

  def join(_room, _mesage, _socket) do
    {:error, %{reason: "You cant join!"}}
  end

  def handle_in("check_validation", %{"body" => body}, socket) do
    Task.Supervisor.start_child(
      Smartcitydogs.TaskSupervisor,
      __MODULE__,
      :async_check,
      [body]
    )

    {:noreply, socket}
  end

  def async_check(%{"id" => id, "table" => table}) do
    case Blockchain.get(id, table) do
      %{key: key, table_id: id, table_name: name, hash: hash} ->
        url = "#{@blockchain_url}/#{key}"
        headers = [Authorization: "Bearer #{@auth_password}", "Content-type": "application/json"]
        options = [recv_timeout: 100_000]

        case HTTPoison.get(url, headers, options) do
          {:ok, %{status_code: 200, body: body}} ->
            %{"hash" => hash_from_blockchain} = Jason.decode!(body)

            if hash == hash_from_blockchain do
              SmartcitydogsWeb.Endpoint.broadcast(
                @topic,
                "validation_success",
                %{
                  body: Jason.encode!(%{key: key, table_id: id, table_name: name})
                }
              )
            else
              SmartcitydogsWeb.Endpoint.broadcast(
                @topic,
                "validation_error",
                %{
                  body: Jason.encode!(%{key: key, table_id: id, table_name: name})
                }
              )
            end

          _ ->
            SmartcitydogsWeb.Endpoint.broadcast(
              @topic,
              "validation_error",
              %{
                body: Jason.encode!(%{key: key, table_id: id, table_name: name})
              }
            )
        end

      _ ->
        nil
    end
  end
end
