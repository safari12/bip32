defmodule BIP32.DeriveKeyTest do
  use ExUnit.Case

  alias BIP32Test.Util

  @sample_key_inputs Util.get_sample_key_inputs
  @sample_account Util.get_sample_account

  setup do
    {:ok, master_key: Util.generate_sample_master_key()}
  end

  describe "derive account" do
    test "extended private key", %{master_key: master_key} do
      key = master_key
      |> BIP32.derive(@sample_account[:path])
      |> BIP32.to_base58


      assert key == @sample_account[:extended_private_key]
    end

    test "extended public key", %{master_key: master_key} do
      key = master_key
      |> BIP32.derive(@sample_account[:path])
      |> BIP32.PublicKey.generate(@sample_key_inputs[:public_version])
      |> BIP32.to_base58

      assert key == @sample_account[:extended_public_key]
    end
  end

  describe "derive account children" do
    test "children", %{master_key: master_key} do
      @sample_account[:children]
      |> Enum.with_index
      |> Enum.each(fn {expected_child_key, index} ->
        priv_key = master_key |> account_child_private_key(index)
        pub_key = priv_key |> account_child_public_key

        encoded_priv_key = priv_key
        |> Map.get(:data)
        |> Base.encode16(case: :lower)

        encoded_pub_key = pub_key
        |> Map.get(:data)
        |> Base.encode16(case: :lower)

        <<_prefixs::binary-2, encoded_pub_key_data::binary>> =
          encoded_pub_key

        assert encoded_priv_key  == expected_child_key[:private_key]
        assert encoded_pub_key_data == expected_child_key[:public_key]
      end)
    end
  end

  defp account_child_private_key(master_key, index) do
    master_key
    |> BIP32.derive(@sample_account[:path] <> "/0/#{index}")
  end

  defp account_child_public_key(private_key) do
    private_key
    |> BIP32.PublicKey.generate(@sample_key_inputs[:public_version])
  end

end
