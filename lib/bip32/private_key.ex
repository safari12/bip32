defmodule BIP32.PrivateKey do
  use BIP32.Key

  @doc """
  Generate master BIP32 private key
  """
  @spec generate_master(binary, binary, atom, String.t, atom) :: t
  def generate_master(
    seed,
    version,
    currency,
    chain_code,
    network \\ :mainnet
  ) do
    :crypto.hmac(:sha512, chain_code, seed)
    |> build_master(version, currency, network)
  end

  defp serialize(%__MODULE__{} = key) do
    serialized_key = <<0::size(8), key.key::binary>>
    serialize(key, serialized_key)
  end

  defp build_master(
    <<priv_key::binary-32, c_code::binary>>,
    version,
    currency,
    network
  ) do
    key = create(version, network, currency)
    %{key | key: priv_key, chain_code: c_code}
  end

end
