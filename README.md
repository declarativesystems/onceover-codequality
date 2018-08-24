# Onceover::CodeQuality

This is the Code Quality plugin for [Onceover](https://github.com/dylanratcliffe/onceover), _The gateway drug to automated infrastructure testing with Puppet_

## What does it do?
The plugin checks your control repository for:

* Linting
* Syntax

And then generates documentation using [Puppet Strings](https://github.com/puppetlabs/puppet-strings/)

For sure you can hack around with rake/make and hack something up each time but aint nobody got time for that!

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

```shell
$onceover run codequality --no_lint
```

**Skip syntax check**

```shell
$ onceover run codequality --no_syntax
```

**Skip documentation generation**

```shell
$ onceover run codequality --no_doc
```


## Sample output

**All clear**

```shell
$ onceover run codequality
INFO   -> Checking for lint...
INFO   -> checking manifests
INFO   -> checking site/role
INFO   -> Checking syntax...
---> syntax:manifests
---> syntax:templates
---> syntax:hiera:yaml
INFO   -> Code Quality tests passed, have a nice day
```

**Lint and syntax errors**

```shell
$ onceover run codequality
INFO   -> Checking for lint...
INFO   -> checking manifests
INFO   -> checking site/role
./manifests/example.pp - WARNING: class not documented on line 1
./manifests/webserver.pp - WARNING: class not documented on line 1
./manifests/database_server.pp - WARNING: class not documented on line 1
ERROR  -> Lint test failed, see previous errors
INFO   -> Checking syntax...
---> syntax:manifests
Could not parse for environment *root*: Syntax error at 'ensure' at /home/geoff/crud/control-repo/manifests/bogus.pp:2:3
ERROR  -> Syntax test failed, see previous errors
ERROR  -> Code Quality tests failed, see previous error
$ echo $?
1
```

## FAQ

**`WARN: Unresolved specs during Gem::Specification.reset`?**

I get these errors when I run `onceover run codequality` but everything seems to work, what gives?:

```
WARN: Unresolved specs during Gem::Specification.reset:
      rake (>= 0)
      hiera (< 4, >= 2.0)
      gettext (>= 3.0.2)
WARN: Clearing out unresolved specs.
Please report a bug if this causes problems.
```

Beats me - something to do with rubygems.  The best way to beat this message is to use [bundler](https://github.com/bundler/bundler) which basically you should already be doing anyway (for your own sanity):

```shell
$ bundle exec onceover run codequality
```

**What are you using under-the-hood?**

* [puppet-lint](https://github.com/rodjek/puppet-lint)
* [puppet-syntax](https://github.com/voxpupuli/puppet-syntax)
* [puppet-strings](https://github.com/puppetlabs/puppet-strings/) 


## Development

If you have new ideas for things to check this might be a handy place to add them, please open a ticket, otherwise see the [helloworld plugin](https://github.com/declarativesystems/onceover-helloworld) if you want to have a go at writing a plugin of your own.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/declarativesystems/onceover-codequality.
