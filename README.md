# Commitsu - Stop writing bad commit messages

Introduction
------------

Commitsu is a command-line tool for writing commit messages that meet an arbitrary definition of quality.

It attempts to accomplish this by exposing a template engine and form generation in order to prompt users for the
items that should be inside their commit messages.

Disclaimer
----------

This gem was just released (pre 1.0) and probably doesn't have everything (or anything) you want yet.

During pre 1.0, things may change that break backwards compatibility between releases. Most likely these breaking
changes would be the DSL governing message forms.

You can help things along by submitting pull requests and reporting bugs.

### Current TODO List

- Support a 'TextField' form type for multi-line text
- Optional support for GUI interface
- More test coverage for existing features
- Add feature to define issue trackers outside of the gem

Installation
------------

TODO: Publish to RubyGems.org

Usage
-----

```
Commitsu commands:
  commitsu generate_home               # Generates the commitsu home directory with a skeleton configuration.
  commitsu help [COMMAND]              # Describe available commands or one specific command
  commitsu prompt FILE [MESSAGE_TYPE]  # Prompts for a commit message and prints the result to the FILE
  commitsu version                     # Shows the current version of commitsu

Options:
  [--home=HOME]                  # Commitsu home directory. (Default: ~/.commitsu)
  [--issuetracker=ISSUETRACKER]  # Issue tracker name (Configured in config.yaml).
```

### Notes

- The only issue-tracker supported in `ISSUETRACKER` is `trello`. Submit a patch if you want others supported.
- Currently, the only built-in `MESSAGE_TYPE` is `git`. You have to write your own in `~/.commitsu/messages`

Configuration
-------------
If you want to customize your configuration, run `commitsu generate_home` and look in `~/.commitsu` for an example.

How to Contribute
-----------------

### Running the tests

    $ bundle
    $ bundle exec rake test

### Installing locally

    $ bundle
    $ [bundle exec] rake install

### Reporting Issues

Please include a reproducible test case.

License
-------

Copyright (c) 2013 Justen Walker.

Released under the terms of the MIT License. For further information, please see the file `LICENSE`.
