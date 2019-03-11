defmodule Smartcitydogs.Blockchain do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smartcitydogs.Repo
  alias SmartcitydogsWeb.Encoder
  import Ecto.Query

  schema "blockchain_hashes" do
    field(:table_id, :integer)
    field(:table_name, :string)
    field(:hash, :string)
    field(:key, :string)

    timestamps()
  end

  @blockchain_url Application.fetch_env!(:smartcitydogs, :blockchain_url)
  @doc false
  def changeset(hash, attrs \\ %{}) do
    hash
    |> cast(attrs, [
      :table_id,
      :table_name,
      :hash,
      :key
    ])
    |> unique_constraint(:hash)
    |> validate_required([
      :table_id,
      :table_name,
      :hash,
      :key
    ])
  end

  def get(id, table) do
    Repo.one(
      from(x in __MODULE__,
        where: [table_id: ^id, table_name: ^table],
        order_by: [desc: x.id],
        limit: 1
      )
    )
  end

  def create(data) do
    Task.Supervisor.start_child(Smartcitydogs.TaskSupervisor, __MODULE__, :async_create, [
      data
    ])

    data
  end

  def async_create(%{id: id} = data) do
    table = data.__struct__.__schema__(:source)

    json = data |> Encoder.struct_to_map() |> Jason.encode!()
    hash = :crypto.hash(:sha256, json) |> Base.encode16()

    key = save_blockchain(id, table, hash)

    data = %{
      table_id: id,
      table_name: table,
      hash: hash,
      key: key
    }

    %__MODULE__{}
    |> changeset(data)
    |> Repo.insert!()

    SmartcitydogsWeb.Endpoint.broadcast("room:blockchain_validation", "validation_success", %{
      body: Jason.encode!(%{key: key, table_id: id, table_name: table})
    })
  end

  defp save_blockchain(id, table, hash) do
    token = Application.fetch_env!(:smartcitydogs, :blockchain_secret)
    headers = [Authorization: "Bearer #{token}", "Content-type": "application/json"]
    options = [recv_timeout: 100_000]
    body = %{id: id, entry_type: table, hash: hash} |> Poison.encode!()
    {:ok, %{body: key}} = HTTPoison.post(@blockchain_url, body, headers, options)
    key
  end
end
