defmodule BIP32.PublicKey do
  use BIP32.Key

  @doc """
  Compresses key's data
  """
  @spec compress(t) :: binary
  def compress(
    <<_prefix::size(8),
      x_coordinate::size(256),
      y_coordinate::size(256)>>
  ) do
    prefix = case rem(y_coordinate, 2) do
      0 -> 0x02
      _ -> 0x03
    end
    <<prefix::size(8), x_coordinate::size(256)>>
  end
end
