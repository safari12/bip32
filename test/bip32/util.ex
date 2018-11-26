defmodule BIP32Test.Util do
  def get_sample_key_inputs do
    Application.get_env(:bip32, :sample_key_inputs)
  end

  def get_sample_account do
    Application.get_env(:bip32, :sample_account)
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
