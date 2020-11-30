# Class to install mailhog.
#
# @api private
class mailhog::install {
  case $::mailhog::install_method {
    'package': {
      package { 'mailhog':
        ensure => $::mailhog::package_version,
        name   => $::mailhog::package_name,
      }
    }
    'archive': {
      file { 'mailhog install dir':
        ensure => directory,
        path   => $::mailhog::install_dir,
      }
      -> archive { "${::mailhog::install_dir}/mailhog":
        source      => $::mailhog::archive_source,
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