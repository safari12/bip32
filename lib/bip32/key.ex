defmodule BIP32.Key do

  defmacro __using__(_options) do
    quote do
      @type version :: <<_::32>>
      @type depth :: <<_::8>>
      @type fingerprint :: <<_::32>>
      @type child_num :: <<_::32>>
      @type chain_code :: <<_::256>>
      @type data :: <<_::264>>
      @type currency :: atom

      @type network :: :mainnet | :testnet

      @type t :: %__MODULE__{
        version: version,
        depth: depth,
        fingerprint: fingerprint,
        child_num: child_num,
        chain_code: chain_code,
        data: data
      }

      defstruct [
        :version,
        :depth,
        :fingerprint,
        :child_num,
        :chain_code,
        :data,
        :network,
        :currency
      ]

      @spec create(version, currency, network) :: {:ok, t}
      defp create(version, currency, network)
        when network in [:mainnet, :testnet]
      do
        {:ok, %__MODULE__{
          currency: currency,
          network: network,
          version: version,
          depth: 0,
          fingerprint: <<0::32>>,
          child_num: 0,
          chain_code: <<0>>,
          data: <<0>>
        }}
      end

      defp create(_, _, _), do: {:error, :invalid_network_type}

    end
  end

end
