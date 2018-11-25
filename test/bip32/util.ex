defmodule BIP32Test.Util do
  def get_sample_key_inputs do
    Application.get_env(:bip32, :sample_key_inputs)
  end

  def get_account_child_key do
    Application.get_env(:bip32, :account_child_key)
  end

  def generate_sample_master_key do
    inputs = get_sample_key_inputs()
    BIP32.PrivateKey.generate_master(
      inputs[:seed],
      inputs[:currency],
      inputs[:version],
      inputs[:seed_key]
    )
  end
end
