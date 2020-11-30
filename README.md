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

## Usage

All options and configuration can be done through interacting with the parameters
on the main mailhog class.
These are now documented via [Puppet Strings](https://github.com/puppetlabs/puppet-strings)

You can view example usage in [REFERENCE](REFERENCE.md).

## Reference

See [REFERENCE](REFERENCE.md).

## Limitations

This module currently only exposes a subset of all configuration options.

## Development

### Running tests

This project contains tests for both rspec-puppet and litmus to verify functionality. For detailed information on using these tools, please see their respective documentation.

#### Testing quickstart:

```
pdk bundle install
pdk bundle exec rake 'litmus:provision_list[puppet6]'
pdk bundle exec rake 'litmus:install_agent[puppet6]'
pdk bundle exec rake litmus:install_module
pdk bundle exec rake litmus:acceptance:parallel
pdk bundle exec rake litmus:tear_down
