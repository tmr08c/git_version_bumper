[![Code Climate](https://codeclimate.com/github/tmr08c/git_version_bumper/badges/gpa.svg)](https://codeclimate.com/github/tmr08c/git_version_bumper)
[![Test Coverage](https://codeclimate.com/github/tmr08c/git_version_bumper/badges/coverage.svg)](https://codeclimate.com/github/tmr08c/git_version_bumper/coverage)
[![Build Status](https://travis-ci.org/tmr08c/git_version_bumper.svg?branch=master)](https://travis-ci.org/tmr08c/git_version_bumper)

# GitVersionBumper

CLI tool to create version bump commit and tag witCLI tool to create version bump commit and tag with newest version in a Git repository. Versioning is based on [Semantic Versioning](http://semver.org/).  Version bump types include `MAJOR`, `MINOR`, and `PATCH`.

## Installation

Add this line to your application's Gemfile:

    gem 'git_version_bumper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install git_version_bumper

## Usage

From within your Git repository you can run the gem using the `versionify`'s `bump` command in combination with a valid version bump type.

```
versionify bump TYPE
```

### Version Bump Types

Valid version bump types include:

* MAJOR
* MINOR
* PATCH

## Contributing

1. Fork it ( https://github.com/tmr08c/git_version_bumper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
