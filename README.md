# sensu-plugins-ipvs

[![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-ipvs.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-ipvs)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-ipvs.svg)](http://badge.fury.io/rb/sensu-plugins-ipvs)
[![Code Climate](https://codeclimate.com/github/sensu-plugins/sensu-plugins-ipvs/badges/gpa.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-ipvs)
[![Test Coverage](https://codeclimate.com/github/sensu-plugins/sensu-plugins-ipvs/badges/coverage.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-ipvs)
[![Dependency Status](https://gemnasium.com/sensu-plugins/sensu-plugins-ipvs.svg)](https://gemnasium.com/sensu-plugins/sensu-plugins-ipvs)

## Functionality

## Files
 * bin/metrics-ipvs

## Usage

## Installation

Add the public key (if you haven’t already) as a trusted certificate

```
gem cert --add <(curl -Ls https://raw.githubusercontent.com/sensu-plugins/sensu-plugins.github.io/master/certs/sensu-plugins.pem)
gem install sensu-plugins-ipvs -P MediumSecurity
```

You can also download the key from /certs/ within each repository.

#### Rubygems

`gem install sensu-plugins-ipvs`

#### Bundler

Add *sensu-plugins-ipvs* to your Gemfile and run `bundle install` or `bundle update`

#### Chef

Using the Sensu **sensu_gem** LWRP
```
sensu_gem 'sensu-plugins-ipvs' do
  options('--prerelease')
  version '0.0.1'
end
```

Using the Chef **gem_package** resource
```
gem_package 'sensu-plugins-ipvs' do
  options('--prerelease')
  version '0.0.1'
end
```
