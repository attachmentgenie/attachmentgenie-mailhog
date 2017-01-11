# attachmentgenie-mailhog

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
2. [Setup - The basics of getting started with mailhog](#setup)
    * [What mailhog affects](#what-mailhog-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with mailhog](#beginning-with-mailhog)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Module Description

MailHog is an email testing tool for developers:

    - Configure your application to use MailHog for SMTP delivery
    - View messages in the web UI, or retrieve them with the JSON API

## Setup

### What mailhog affects

- Configuration files and directories (created and written to)
- Package/service/configuration files for Mailhog
- Listened-to ports

### Setup Requirements

none

### Beginning with mailhog

To have Puppet install Mailhog with the default parameters, declare the mailhog class:

``` puppet
class { 'mailhog': }
```

You can customize parameters when declaring the `mailhog` class. For instance,
 this declaration installs Mailhog by downloading a tarball instead of instead of using a package.

``` puppet
class { '::mailhog':
  install_method => 'wget',
  wget_source    => 'https://github.com/mailhog/MailHog/releases/download/v0.2.1/MailHog_linux_amd64',
}
```

## Limitations

This module currently only exposes a subset of all configuration options.

## Development

### Running tests

This project contains tests for both rspec-puppet and test kitchen to verify functionality. For detailed information on using these tools, please see their respective documentation.

#### Testing quickstart:

```
gem install bundler
bundle install
bundle exec rake guard
bundle exec kitchen test
