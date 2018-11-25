defmodule BIP32.DeriveKeyTest do
  use ExUnit.Case

  alias BIP32Test.Util

  @sample_key_inputs Util.get_sample_key_inputs
  @account_child_key Util.get_account_child_key

  setup do
    {:ok, master_key: Util.generate_sample_master_key()}
  end

  describe "derive account" do
    test "extended private key", %{master_key: master_key} do
      key = master_key
      |> BIP32.derive(@account_child_key[:path])
      |> BIP32.to_base58


      assert key == @account_child_key[:extended_private_key]
    end

    test "extended public key", %{master_key: master_key} do
      key = master_key
      |> BIP32.derive(@account_child_key[:path])
      |> BIP32.PublicKey.generate(@sample_key_inputs[:public_version])
      |> BIP32.to_base58

      assert key == @account_child_key[:extended_public_key]
    end
  end

end
