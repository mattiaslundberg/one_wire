defmodule OneWireTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  test "parse_data" do
    raw_data = "ae 01 0e 04 7f ff 02 10 5e : crc=5e YES\nae 01 0e 04 7f ff 02 10 5e t=26875"

    assert 26.9 == OneWire.parse_data(raw_data)
  end

  property "parse data" do
    check all bin <- binary(),
              temp <- StreamData.float() do
      assert is_number(OneWire.parse_data("#{bin} t=#{temp}"))
    end
  end
end
