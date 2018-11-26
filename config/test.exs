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
child_keys: [%{
  private: "1da5212e1e056cf109be1fade8e878de9adf690c616dfd4430afa5cd60688151",
  public: "0add1d3d2d480bcae66537a873470903895b3a06910ba0b7cfc684a90defcb5393bc9fd1b3ad494e186e28f771905793f7078259ff6646221bb6a43ea81a5239"
}, %{
  private: "a1b267d22eb8547e78e093dc18e56578c6356f62d55875820bba0360b0fa65ba",
  public: "1a1468a126a78ae4eda32b921ea57ea86ed14f287ca8448bb3e796f9526abe70ea0318469211c2b73b32d1f3b2e076f76eacfd9b285ba28bd58c7b81e2110057"
}, %{
  private: "0131a490c9efefb087e51ffe4e138a4abab3fef0cec4079c479b64c698a68e2d",
  public: "d47a70c6b3de40ae05e593df2d1725cb11208832d7466f77f2779a87e17908ce92e9f80995c68cb7b98b0eb43b82d082e2742e713fb45b1614d8eeed502cd69c"
}, %{
  private: "0ecb726538a6b8ae58f388a4edd0dbc92e4ed14da22de76a5441b08559d3f9e2",
  public: "83e891bf1a971545b0dbd2532b15d3c0c64304f5683894ee8913b9b7ab26b3c69d40666032d1a026c2f2cb640c8c4074c33dcaa8b37ad20d1f3dfd3b914d86c2"
}, %{
  private: "d85d488b57f160e20c91a3cde739b591532aa09e3b29092c91582c298834e8ea",
  public: "69a7f142301c77131b429728efe7e72e6cfa7328f8f8929e7a2a66e85d8932559937455b327fb6f00867f871f3d0f443a6dcea0b075d6e196391224d10f51eb9"
}, %{
  private: "e899d1a340a576d8bc86c878168e32ad85c8a45899e5c9607b82e23bb0ed4a07",
  public: "fb375f50b8f3a3ee6b96f9df2d62fcb07946555d7c13ce417dd112ab6b5f7c65e85f4397ba3894e257c540af2186a73bcfe698ea44eea6f6ba27c38adb50d065"
}, %{
  private: "a88c71afd97e7f79a82f90a4b07983afd641a5a608bc8e1c13c3732e10e60c6c",
  public: "31a97fbe9c6de6b9b564a7aac3b569fb5700c530bc0d270708ffa31bf479ca4a46a6a137cd0080c0abaa489ce4192ef59f578d5ba1c02e0ff9e8f2ac8e819440"
}, %{
  private: "e6cb7c04975eb6e94a26bb52b336ca7195a251b8f74d08271a96e879fb07c5d7",
  public: "c1afcb4fcec4f0c8927776f0f974ea366589ed72e7d8174995d29ea95f7ebb38bac7957e28111cab6aba5f5e05ec772b50d316b16a2481cbd267ebb2d68a04ed"
}, %{
  private: "c48a9120e9c33d6f3c928268b71050212015ea355608491793a02bafcbc3616d",
  public: "ec5fc147c9daec51d678755289289312346b58f6ea8408c27335eed5981075295a5b0c04b27891ff7d74dac36add069cc40d63e4b96bf52a290fcfe49c632b03"
}, %{
  private: "758fadce08514bc2e32911e9f69780be947f1c35d9eeb3e2e380504265ba6a5d",
  public: "ed7c9b75fa2c0d5d685763ea0082f34428194d8668c66c531a9aeb9744e2389248f71729784e47732d2f26ac9b6d3314d7e7efcca61e9d6a70024be08d0d0d4b"  
}]
