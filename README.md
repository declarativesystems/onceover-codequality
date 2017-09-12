# Onceover::CodeQuality

This is the Code Quality plugin for [Onceover](https://github.com/dylanratcliffe/onceover), _The gateway drug to automated infrastructure testing with Puppet_

## What does it do?
The plugin checks your control repository for:

* Linting
* Syntax


## Installation

Install the `onceover-codequality` gem by adding it to your `Gemfile` or by running the following command:

```shell
$ gem install onceover-codequality
```

## Usage

Installing the codequality gem creates a new item within onceover's `run` command: `codequality`.  See `onceover run codequality --help` for all available options.

The command will return `1` to the system if any tests fail, otherwise `0`, which makes it perfect to include in build pipelines.


**Check all code in the control repository for Lint and Syntax errors**

```shell
$ onceover run codequality
```

**Skip Lint check**

```
$onceover run codequality --no_lint
```

**Skip syntax check**

```
$ onceover run codequality --no_syntax
```

## Development

If you have new ideas for things to check this might be a handy place to add them, please open a ticket, otherwise see the [helloworld plugin](https://github.com/declarativesystems/onceover-helloworld) if you want to have a go at writing a plugin of your own.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/declarativesystems/onceover-codequality.
