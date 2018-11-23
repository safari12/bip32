defmodule BIP32Test do
  use ExUnit.Case

  test "bip32_vectors_1" do
    # seed = "000102030405060708090a0b0c0d0e0f" |> Base.decode16!(case: :mixed)
    # master_key = BIP32.generate_master_key(seed, :mainnet, type: :ae)
    #
    # ## Chain m
    # assert "aeub7C9vNZ1egvxzQXZo3vTennMNQNsW8CW2dgjAHAz56ZkdY8GBsDbTMJ45vaUrZau5YjgnNeSUWJg8DFxYTnSmF3MEAYY4QfnYebhWVwgYX3Mq"
    # = master_key |> BIP32.to_public_key |> BIP32.format_key
    # assert "aepv7c8EuKLSHnNLxAPJQVuUh4fTxKLbB1hqx8HYN8QSEQqKxv7JVsoMXLo8WrLsHrujBmzXVeqqZZwGf8VA8QbSYSEKuLA6KAL3F5V6FHCPHo3z"
    # = BIP32.format_key(master_key)
    #
    # ## Chain m/0h
    # assert "aeub7CCb5CfduEGu5KQP8mHMSSX2fwArKza77Xd5UQEuQzCz9BPzRwgJXfYUw7fqcJQ5Nje3MkyPmspjKAuMtVajKP84Rp8pRtgtvYhFdioBbukp"
    # = master_key
    # |> BIP32.derive("M/0'") |> BIP32.format_key()
    # assert "aepv7cAubxzRW5gFcxDtVLjBLiq8DsdwNomvRyBTZMfGYqHgZyF74btChiHXXPU8BwZMxeuoTWryNnzGoydAxxtqDwDjkyxrdc1VCWiNeDUe66ED"
    # = master_key |> BIP32.derive("m/0'") |> BIP32.format_key()
    #
    # ## Chain m/0h/1
    # assert "aeub7CE4ACBNpqf6vLUN3xnKGuwe37VevcUXa1qYnxyufvHj6JjzDV9RHxAxECRABBVhThE8mCxuoerusDY1spXi6KbDSC2tmcWSPJFVr76Y2kdQ"
    # = master_key
    # |> BIP32.derive("M/0'/1") |> BIP32.format_key()
    # assert "aepv7cCNgxWARh4TTyHsQYE9BCFjb3xjyRgLtTPvsvQGomNRX6b6r9MKTzuzpUHj2C2KDa72s4WrJ84W2M7PfQhmQwaZQHeq4vXfFNxKVUwWvttF"
    # = master_key |> BIP32.derive("m/0'/1") |> BIP32.format_key()
  end
end
