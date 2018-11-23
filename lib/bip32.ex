defmodule BIP32 do

  alias BIP32.{PrivateKey, PublicKey}

  @spec to_base58(PrivateKey.t | PublicKey.t) :: String.t()
  def to_base58(key) when is_map(key) do
    {prefix, bip32_serialization} = serialize(key)
    Base58Check.encode(bip32_serialization, prefix)
  end

  @spec fingerprint(PrivateKey.t) :: PrivateKey.fingerprint
  defp fingerprint(%PrivateKey{data: key}) do
    key
    |> Secp256k1.generate_public_key
    |> PublicKey.compress
    |> fingerprint
  end

  @spec fingerprint(PublicKey.t) :: PublicKey.fingerprint
  defp fingerprint(%PublicKey{data: key}) do
    key
    |> PublicKey.compress
    |> fingerprint
  end

  @spec fingerprint(binary) :: binary
  defp fingerprint(key) do
    <<fingerprint::binary-4, _rest::binary>> = key
    |> (&:crypto.hash(:sha256, &1)).()
    |> (&:crypto.hash(:ripemd160, &1)).()
    fingerprint
  end

  @spec serialize(PrivateKey.t) :: {PrivateKey.version, binary}
  defp serialize(%PrivateKey{} = private_key) do
    <<0::size(8), private_key.data::binary>>
    |> serialize(private_key)
  end

  @spec serialize(PublicKey.t) :: {PublicKey.version, binary}
  defp serialize(%PublicKey{} = public_key) do
    public_key
    |> PublicKey.compress
    |> serialize(public_key)
  end

  @spec serialize(binary, binary) :: {binary, binary}
  defp serialize(serialized_key, key_meta) do
    {
      <<key_meta.version::size(32)>>,
      <<key_meta.depth::size(8),
        key_meta.fingerprint::binary-4,
        key_meta.child_num::size(32),
        key_meta.chain_code::binary,
        serialized_key::binary>>
    }
  end

end
