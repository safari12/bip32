defmodule BIP32.PrivateKeyTest do
  use ExUnit.Case

  alias BIP32Test.Util

  @sample_key_inputs Util.get_sample_key_inputs

  describe "generate_master" do
    test "should generate root private extended key" do
      key = BIP32.PrivateKey.generate_master(
        @sample_key_inputs[:seed],
        @sample_key_inputs[:currency],
        @sample_key_inputs[:version],
        @sample_key_inputs[:seed_key]
      )

      assert key.currency == @sample_key_inputs[:currency]
      assert key.version == @sample_key_inputs[:version]
      assert key.network == :mainnet
      assert key.depth == 0
      assert key.fingerprint == <<0::32>>
      assert key.child_num == 0
      assert byte_size(key.chain_code) == 32
      assert byte_size(key.data) == 32
      assert BIP32.to_base58(key) == @sample_key_inputs[:root_private_extended]
    end

    test "should return invalid network type error" do
      assert {:error, :invalid_network_type} ==
        BIP32.PrivateKey.generate_master(
          @sample_key_inputs[:seed],
          @sample_key_inputs[:currency],
          @sample_key_inputs[:version],
          @sample_key_inputs[:seed_key],
          :blah
        )
    end
  end
end
