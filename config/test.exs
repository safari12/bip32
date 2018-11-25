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

config :bip32, :account_child_key,
path: "m/44'/60'/0'",
public_path: "M/44'/0'/0'",
extended_private_key: "xprv9xrLqrRdQGkdmCuYe2FTAje4ULcfLY5Lrdew7dwp4K7MeUHWetevv1uWTC2qy7CZyKfLf3Xtru9hfvhdRL1hNRe5Cr3hpRQnNvcxU6pusJW",
extended_public_key: "xpub6BqhFMxXEeJvygz1k3nTXsao2NT9jzoCDraXv2MRceeLXGcfCRyBTpDzJTwRSGMHwn92Q6YPTiB4bu3VaD454R5t8okASAH1hFwBPpqgdeo"
