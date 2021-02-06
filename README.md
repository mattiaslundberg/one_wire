# OneWire

Library to help reading one wire sensors from nerves projects on Raspberry PI (any version execept pico).

## Usage

Steps needed to use this library

 * Install Erlang, Elixir and Nerves: https://hexdocs.pm/nerves/installation.html#content
 * Generate a new nerves project (`mix nerves.new <project name>`)
 * Install mix dependency as described below
 * Run `mix deps.get`
 * Activate one wire support as described below
 * Upload the new firmware to the target
 * Read sensors by calling `OneWire.read_sensors()`

### Installation

The package can be installed by adding `one_wire` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:one_wire, "~> 0.1.0", git: "https://github.com/mattiaslundberg/one_wire.git"}
  ]
end
```

### Activating one wire support

This description assumes that you're using a Raspberry PI 3 (change rpi3 to correct name in commands below for other Raspberry PIs).

Add the following to `config/target.exs` to get nerves to use our custom configuration: 

``` elixir
config :nerves, :firmware, fwup_conf: "config/#{Mix.target()}/fwup.conf"
```

Copy the default configuration:

``` sh
$ mkdir -p config/rpi3/
$ cp deps/nerves_system_rpi3/fwup.conf config/rpi3/fwup.conf
$ cp deps/nerves_system_rpi3/config.txt config/rpi3/config.txt
```

Edit the following block in `fwup.conf` from

```
file-resource config.txt {
    host-path = "${NERVES_APP}/config/rpi3/config.txt"
}
```

to
```
file-resource config.txt {
    host-path = "${NERVES_APP}/config/rpi3/config.txt"
}
```

Remove the `#` from the following line in `config.txt`

```
#dtoverlay=w1-gpio-pullup,gpiopin=4
```
