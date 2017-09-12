# Onceover::Helloworld

This is an example plugin for [Onceover](https://github.com/dylanratcliffe/onceover), _The gateway drug to automated infrastructure testing with Puppet_

## Installation

Onceover detects plugins in all gems named `onceover-*`.  Your plugin is then responsible for registering itself and setting up new commands, etc.

This example plugin can be installed by adding it to your `Gemfile` or by running the following command:

```shell
$ gem install onceover-helloworld
```

## Usage
Onceover provides plugins with built-in support for help and argument processing.  Here's how to run this example:

**Built-in help**

```shell
$ onceover run helloworld --help
```

**Default execution**

```shell
$ onceover run helloworld
INFO   -> Hello, World!
```

**Option processing**

```shell
$ onceover run helloworld --name Wednesday
INFO   -> Hello, Wednesday!
```

## Development

Finished - hopefully this makes writing your own plugins for Onceover easier :)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/declarativesystems/onceover-helloworld.
