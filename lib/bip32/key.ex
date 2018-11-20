defmodule BIP32.Key do
  @moduledoc """
  Module for holding the struct of BIP32 Key
  """

  defmacro __using__(_options) do
    quote do
      @typedoc "Network Types"
      @type network :: :mainnet | :testnet

      @typedoc "Structure of a key"
      @type t :: %__MODULE__{
        currency: atom(),
        network: network,
        version: integer(),
        depth: integer(),
        f_print: binary(),
        child_num: integer(),
        chain_code: binary(),
        key: binary()
      }

      defstruct [
        :currency,
        :network,
        :version,
        :depth,
        :f_print,
        :child_num,
        :chain_code,
        :key
      ]

      @spec to_base58(t) :: String.t
      def to_base58(%__MODULE__{} = key) do
        {prefix, bip32_serialization} = serialize(key)
        Base58Check.encode(bip32_serialization, prefix)
      end

      @spec create(integer, network, atom) :: t()
      defp create(version, network, currency)
        when network == :mainnet or network == :testnet
      do
        %__MODULE__{
          currency: currency,
          network: network,
          version: version,
          depth: 0,
          f_print: <<0::32>>,
          child_num: 0,
          chain_code: <<0>>,
          key: <<0>>
        }
      end

      @spec serialize(Map.t, binary()) :: tuple
      defp serialize(key_data, serialized_key) do
        {
          <<key_data.version::size(32)>>,
          <<key_data.depth::size(8),
          key_data.f_print::binary-4,
          key_data.child_num::size(32),
          key_data.chain_code::binary,
          serialized_key::binary>>
        }
      end

    end
  end

end
