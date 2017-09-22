# Class to install mailhog.
#
# Dont include this class directly.
#
class mailhog::install {
  case $::mailhog::install_method {
    'package': {
      package { 'mailhog':
        ensure => $::mailhog::package_version,
        name   => $::mailhog::package_name,
      }
    }
    'wget': {
      file { 'mailhog install dir':
        ensure => directory,
        path   => $::mailhog::install_dir,
      }
      -> wget::fetch { 'mailhog binary':
        source      => $::mailhog::wget_source,
        destination => "${::mailhog::install_dir}/mailhog",
        timeout     => 0,
        verbose     => false,
      }
      -> file { 'mailhog binary':
        group => 'root',
        mode  => '0755',
        owner => 'root',
        path  => "${::mailhog::install_dir}/mailhog",
      }
    }
    default: {
      fail("Installation method ${::mailhog::install_method} not supported")
    }
  }
}