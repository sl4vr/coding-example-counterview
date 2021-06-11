# Counterview

Counterview is a simple page view log parser.

## Requirements

* [Ruby 2.6.3](https://www.ruby-lang.org/en/documentation/installation/)

## Development

### Install dependencies
```
$ gem intall bundler
$ bundle install
```
### Run tests
```
$ bundle exec rspec
```

### Linting
```
$ bundle exec rubocop
```

## Usage

Run command line script from bin directory with a filename as an argument.
Expected file format is space separated lines of route and ip address (kinda),
lines that do not match the format will be ignored.

```
$ bin/parse FILENAME
```
