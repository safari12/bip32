defmodule BIP32.PublicKeyTest do
  use ExUnit.Case

  alias BIP32Test.Util

  @sample_key_inputs Util.get_sample_key_inputs

  describe "generate" do
    test "should generate root public extended key" do
      private_key = BIP32.PrivateKey.generate_master(
        @sample_key_inputs[:seed],
        @sample_key_inputs[:currency],
        @sample_key_inputs[:version],
        @sample_key_inputs[:seed_key]
      )

      key = BIP32.PublicKey.generate(
        private_key,
        @sample_key_inputs[:public_version]
      )

      assert key.currency == @sample_key_inputs[:currency]
      assert key.version == @sample_key_inputs[:public_version]
      assert key.network == :mainnet
      assert key.depth == 0
      assert key.fingerprint == <<0::32>>
      assert key.child_num == 0
      assert byte_size(key.chain_code) == 32
      assert byte_size(key.data) == 65
      assert BIP32.to_base58(key) == @sample_key_inputs[:root_public_extended]
    end
  end
end
