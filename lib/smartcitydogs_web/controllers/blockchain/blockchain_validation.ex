defmodule BlockchainValidation do
  def create_dogs_tx(data) do
    hashed_data = :crypto.hash(:sha256, data)
    encoded_hashed_data = Base.encode64(hashed_data)
    body = Poison.encode!(%{hashed_data: encoded_hashed_data, pubkey: pubkey_base()})
    url = build_url("/tx/create_dogs_tx")

    headers = [{"Content-type", "application/json"}]
    {:ok, %HTTPoison.Response{body: response_body}} = HTTPoison.post(url, body, headers)
    hd(Regex.run(~r{\"(.*)\"}, response_body, capture: :all_but_first))
  end

  def sign_tx(tx_data) do
    decoded_tx_data = Base.decode64!(tx_data)
    Ed25519.sign(decoded_tx_data, privkey_bin())
  end

  def pubkey_bin, do: Base.decode64!(System.get_env("PUBLIC_KEY"))
  def privkey_bin, do: Base.decode64!(System.get_env("PRIVATE_KEY"))

  def pubkey_base, do: System.get_env("PUBLIC_KEY")
  def privkey_base, do: System.get_env("PRIVATE_KEY")

  def build_url(path) do
    endpoint = System.get_env("BLOCKCHAIN_ENDPOINT")
    port = System.get_env("BLOCKCHAIN_PORT")
    "#{endpoint}:#{port}#{path}"
  end

  ## Връща хеша на транзакцията трябва при добавяне на на сигнал да се записва в базата към сигнала (да променя таблицата)
  def add_dogs_tx_to_blockchain(encoded_tx_data, signature) do
    encoded_signature = Base.encode64(signature)
    body = Poison.encode!(%{tx: encoded_tx_data, signature: encoded_signature})

    url = build_url("/tx/add_dogs_tx")

    headers = [{"Content-type", "application/json"}]
    {:ok, %HTTPoison.Response{body: response_body}} = HTTPoison.post(url, body, headers)
    hd(Regex.run(~r{\"(.*)\"}, response_body, capture: :all_but_first))
  end
end
