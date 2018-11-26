use Mix.Config

config :bip32, :sample_key_inputs,
seed: "71cfb4483cfc7b070429edb0a8f9d8c831c1d95e5ab4ca0cea0c1cf9ddbe5ae3db01c814fe99e4152709b27b491eb9b613be993b3048285f0c664e3f1087cc40" |> Base.decode16!(case: :lower),
currency: :btc,
version: 0x0488ADE4,
public_version: 0x0488B21E,
seed_key: "Bitcoin seed",
root_private_extended: "xprv9s21ZrQH143K3NXtFdpuMnVET2CZxxCBYWufqrmAHa8mKtsoBDdJougGFHdN8MQJkEYnf1G6xagBYM5mw1n42U518FUXCTyo9rnqLKKRTAA",
root_public_extended: "xpub661MyMwAqRbcFrcMMfMuivRy1434NQv2ujqGeFAmqufkChCwikwZMhzk6ajRwNfN2cLtfe8yZbZMwzhFbEH5EAGSg5x9bdjpZ6CbDdaKXPz",
mnemonic: "crucial milk insane problem bonus kingdom obvious outdoor inner write melt happy"

config :bip32, :sample_account,
path: "m/44'/0'/0'",
public_path: "M/44'/0'/0'",
extended_private_key: "xprv9zPCqBrVpxpNRijtWEqwtWVGtE5sthargarWyZKUfmu4BASUhtWCCwzSXS9P91msQ5aeBMyvXPKwwU5DhTyX4kM7MSgMGBA37nYnf7eKieh",
extended_public_key: "xpub6DNZEhPPfLNfeCpMcGNxFeS1SFvNJAJi3on7mwj6E7S33xmdFRpSkkJvNgXtouBvD9nKyejikgZRVnAEgm5Lv91K3EYw1jDgPRqcxcFURML",
children: [%{
  private_key: "1da5212e1e056cf109be1fade8e878de9adf690c616dfd4430afa5cd60688151",
  public_key: "0add1d3d2d480bcae66537a873470903895b3a06910ba0b7cfc684a90defcb5393bc9fd1b3ad494e186e28f771905793f7078259ff6646221bb6a43ea81a5239"
}, %{
  private_key: "a1b267d22eb8547e78e093dc18e56578c6356f62d55875820bba0360b0fa65ba",
  public_key: "1a1468a126a78ae4eda32b921ea57ea86ed14f287ca8448bb3e796f9526abe70ea0318469211c2b73b32d1f3b2e076f76eacfd9b285ba28bd58c7b81e2110057"
}, %{
  private_key: "0131a490c9efefb087e51ffe4e138a4abab3fef0cec4079c479b64c698a68e2d",
  public_key: "d47a70c6b3de40ae05e593df2d1725cb11208832d7466f77f2779a87e17908ce92e9f80995c68cb7b98b0eb43b82d082e2742e713fb45b1614d8eeed502cd69c"
}, %{
  private_key: "0ecb726538a6b8ae58f388a4edd0dbc92e4ed14da22de76a5441b08559d3f9e2",
  public_key: "83e891bf1a971545b0dbd2532b15d3c0c64304f5683894ee8913b9b7ab26b3c69d40666032d1a026c2f2cb640c8c4074c33dcaa8b37ad20d1f3dfd3b914d86c2"
}]
