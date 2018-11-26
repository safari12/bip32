defmodule BIP32 do

  alias BIP32.{PrivateKey, PublicKey}

  @type key :: PrivateKey.t | PublicKey.t
  @type key_type :: :public | :private

  # Integers modulo the order of the curve (referred to as n)
  @n 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141

  # Used as guard for the key derivation type: normal / hardned
  @mersenne_prime 2_147_483_647

  @spec to_base58(key) :: String.t()
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
    public_key.data
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

  @doc """
  Derive private child keys
  """
  @spec derive(key(), String.t()) :: map()
  def derive(key, <<"m/", path::binary>>) do
    derive(key, path, :private)
  end

  # Deriving public keys.
  def derive(key, <<"M/", path::binary>>) do
    derive(key, path, :public)
  end

  @spec derive(key(), String.t(), key_type()) :: map()
  defp derive(key, path, key_type) do
    derive_pathlist(
      key,
      :lists.map(fn(elem) ->
        case String.reverse(elem) do
          <<"'", hardened::binary>> ->
            {num, _rest} =
              hardened
              |> String.reverse()
              |> Integer.parse()
            num + @mersenne_prime + 1
          _ ->
            {num, _rest} = Integer.parse(elem)
            num
        end
      end, :binary.split(path, <<"/">>, [:global])),
      key_type
    )
  end

  @spec derive_pathlist(key(), list(), key_type()) :: key()
  def derive_pathlist(%PrivateKey{} = key, [], :private), do: key
  def derive_pathlist(%PublicKey{} = key, [], :public), do: key
  def derive_pathlist(key, pathlist, key_type) do
    [index | rest] = pathlist

    key
    |> derive_key(index)
    |> derive_pathlist(rest, key_type)
  end

  @spec derive_key(PrivateKey.t, integer) :: PrivateKey.t
  defp derive_key(%PrivateKey{} = key, index) when index > -1 and index <= @mersenne_prime do
    # Normal derivation
    compressed_pub_key = key.data
    |> Secp256k1.generate_public_key
    |> PublicKey.compress

    <<derived_key::size(256), child_chain::binary>> =
      :crypto.hmac(:sha512, key.chain_code, <<compressed_pub_key::binary, index::size(32)>>)

    <<parent_key_int::size(256)>> = key.data

    child_key =
      derived_key
      |> Kernel.+(parent_key_int)
      |> rem(@n)
      |> :binary.encode_unsigned()

    derive_key(key, child_key, child_chain, index)
  end

  defp derive_key(%PrivateKey{} = key, index) when index > @mersenne_prime do
    # Hardned derivation
    <<derived_key::size(256), child_chain::binary>> =
      :crypto.hmac(:sha512, key.chain_code, <<0::size(8), key.data::binary, index::size(32)>>)

    <<key_int::size(256)>> = key.data

    child_key =
      derived_key
      |> Kernel.+(key_int)
      |> rem(@n)
      |> :binary.encode_unsigned()

    derive_key(key, child_key, child_chain, index)
  end

  @spec derive_key(PublicKey.t, integer) :: PublicKey.t
  defp derive_key(%PublicKey{} = key, index) when index > -1 and index <= @mersenne_prime do
    # Normal derivation
    serialized_pub_key = PublicKey.compress(key.data)

    <<derived_key::binary-32, child_chain::binary>> =
      :crypto.hmac(:sha512, key.chain_code,
        <<serialized_pub_key::binary, index::size(32)>>)

    # Elliptic curve point addition
    {:ok, child_key} = :libsecp256k1.ec_pubkey_tweak_add(key.data, derived_key)

    derive_key(key, child_key, child_chain, index)
  end

  defp derive_key(%PublicKey{}, index) when index > @mersenne_prime do
    # Hardned derivation
    raise(RuntimeError, "Cannot derive Public Hardened child")
  end

  @spec derive_key(key, binary, binary, integer) :: key
  defp derive_key(key, child_key, child_chain, index) when is_map(key) do
    %{key |
      data: child_key,
      chain_code: child_chain,
      depth: key.depth + 1,
      fingerprint: fingerprint(key),
      child_num: index}
  end

  defp to_public_hash(public_key) do
    public_key
    |> (&:crypto.hash(:sha256, &1)).()
    |> (&:crypto.hash(:ripemd160, &1)).()
  end

  def to_public_address(public_key, version \\ <<0x00>>) do
    public_key
    |> to_public_hash
    |> Base58Check.encode(version)
  end

end
