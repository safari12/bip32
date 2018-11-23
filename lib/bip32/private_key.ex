defmodule BIP32.PrivateKey do
  use BIP32.Key
  use OK.Pipe

  @type seed :: <<_::512>>

  @spec generate_master(seed, currency, version, network) :: t
  def generate_master(
    seed,
    currency,
    version,
    seed_key \\ "BIP32 Seed",
    network \\ :mainnet
  ) do
    # seed
    # ~> (&:crypto.hmac(:sha512, seed_key, &1)).()
    # ~> IO.inspect

    {:ok, seed}
    ~> (&:crypto.hmac(:sha512, seed_key, &1)).()
    ~>> build_master(currency, version, network)
  end

  defp build_master(
    <<priv_key::binary-32, c_code::binary>>,
    currency,
    version,
    network
  ) do
    {:ok, version}
    ~>> create(currency, network)
    ~> Map.put(:data, priv_key)
    ~>> Map.put(:chain_code, c_code)
  end
end
