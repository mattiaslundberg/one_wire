defmodule OneWire do
  require Logger
  @base_path "/sys/bus/w1/devices/"

  def read_sensors do
    File.ls!(@base_path)
    |> Enum.filter(&String.starts_with?(&1, "28-"))
    |> Enum.into(%{}, fn sensor_id ->
      {sensor_id, read_sensor(sensor_id)}
    end)
  end

  def read_sensor(sensor_id) do
    raw_data = File.read!("#{@base_path}#{sensor_id}/w1_slave")
    Logger.debug("Reading sensor #{sensor_id}: #{raw_data}")

    parse_data(raw_data)
  end

  def parse_data(raw_data) do
    [_, temp] = Regex.run(~r/t=(-?\d+)/, raw_data)

    temp
    |> String.to_integer()
    |> (fn t -> t / 1000.0 end).()
    |> Float.round(1)
  end
end
