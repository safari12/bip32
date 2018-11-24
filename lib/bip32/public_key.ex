defmodule BIP32.PublicKey do
  use BIP32.Key

  alias BIP32.PrivateKey

  @spec generate(PrivateKey.t, version) :: t
  def generate(%PrivateKey{} = private_key, version) do
    data = Secp256k1.generate_public_key(private_key.data)
    {:ok, key} = create(
      version,
      private_key.currency,
      private_key.network
    )

    %{key |
      depth: private_key.depth,
      fingerprint: private_key.fingerprint,
      child_num: private_key.child_num,
      chain_code: private_key.chain_code,
      data: data}
  end

  @doc """
  Compresses key's data
  """
  @spec compress(binary) :: binary
  def compress(
    <<_prefix::size(8),
      x_coordinate::size(256),
      y_coordinate::size(256)>>
  ) do
    prefix = case rem(y_coordinate, 2) do
      0 -> 0x02
      _ -> 0x03
    end
    <<prefix::size(8), x_coordinate::size(256)>>
  end
end
