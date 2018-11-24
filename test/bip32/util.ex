defmodule BIP32Test.Util do
  def get_sample_key_inputs do
    Application.get_env(:bip32, :sample_key_inputs)
  end
end
