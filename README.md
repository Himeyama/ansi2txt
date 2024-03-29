# ansi2txt
ansi2txt converts ANSI escape sequences to readable plain text.

This library is a Ruby port based on [colorized-logs](https://github.com/kilobyte/colorized-logs).

## Installation

```bash
gem install ansi2txt
```

## Usage

An example of converting input from an IO object to plain text.

```ruby
input = File.open("typescript")
puts Ansi2txt::ANSI2TXT.from_io(input)
```

An example of converting input from standard input to plain text.

```bash
cat typescript | ansi2txt
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Himeyama/ansi2txt.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
