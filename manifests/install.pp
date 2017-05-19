# Class to install mailhog.
#
# Dont include this class directly.
#
class mailhog::install {
  case $::mailhog::install_method {
    'package': {
      package { $::mailhog::package_name:
        ensure => $::mailhog::package_version,
      }
    }
    'wget': {
      file { $::mailhog::install_dir:
        ensure => directory,
      }
      -> wget::fetch { '/usr/bin/mailhog':
        source      => $::mailhog::wget_source,
        destination => "${::mailhog::install_dir}/mailhog",
        timeout     => 0,
        verbose     => false,
      }
      -> file { "${::mailhog::install_dir}/mailhog":
        group => 'root',
        mode  => '0755',
        owner => 'root',
      }
    }
    default: {
      fail("Installation method ${::mailhog::install_method} not supported")
    }
  }
}