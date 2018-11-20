defmodule BIP32.PublicKey do
  use BIP32.Key

  alias __MODULE__
  alias BIP32.PrivateKey

  @doc """
  Generates BIP32 Public Key from BIP32 Private Key
  """
  @spec generate(PrivateKey.t) :: t
  def generate(%PrivateKey{} = private_key) do
    public_key = Secp256k1.generate_public_key(private_key.key)
    key = create_from_private_key(private_key)

    %{key | key: public_key}
  end

  @doc """
  Generates a compressed BIP32 Public Key from BIP32 Private Key
  """
  def generate_compress(%PrivateKey{} = private_key) do
    public_key = private_key.key
    |> Secp256k1.generate_public_key
    |> compress

    key = create_from_private_key(private_key)

    %{key | key: public_key}
  end

  @spec fingerprint(PrivateKey.t) :: binary()
  def fingerprint(%PrivateKey{key: private_key}) do
    private_key
    |> Secp256k1.generate_public_key
    |> compress
    |> fingerprint
  end

  @spec fingerprint(t) :: binary()
  def fingerprint(%PublicKey{key: public_key}) do
    public_key
    |> compress
    |> fingerprint
  end

  @spec fingerprint(binary) :: binary
  def fingerprint(public_key) do
    <<f_print::binary-4, _rest::binary>> = public_key
    |> (&:crypto.hash(:sha256, &1)).()
    |> (&:crypto.hash(:ripemd160, &1)).()
    f_print
  end

  defp serialize(%PublicKey{} = key) do
    serialized_key = compress(key.key)
    serialize(key, serialized_key)
  end

  defp create_from_private_key(%PrivateKey{} = private_key) do
    key = create(
      private_key.version,
      private_key.network,
      private_key.currency
    )

    %{key |
      depth: private_key.depth,
      f_print: private_key.f_print,
      child_num: private_key.child_num,
      chain_code: private_key.chain_code}
  end

  defp compress(<<_prefix::size(8), x_coordinate::size(256), y_coordinate::size(256)>>) do
    prefix = case rem(y_coordinate, 2) do
      0 -> 0x02
      _ -> 0x03
    end
    <<prefix::size(8), x_coordinate::size(256)>>
  end
end
