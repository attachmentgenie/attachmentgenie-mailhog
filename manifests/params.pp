# Class to manage mailhog parameters.
#
# Dont include this class directly.
#
class mailhog::params () {
  $install_dir     = '/usr/bin'
  $install_method  = 'package'
  $manage_service  = true
  $manage_user     = true
  $package_name    = 'mailhog'
  $package_version = 'present'
  $service_name    = 'mailhog'
  $wget_source     = undef
  case $::osfamily {
    'Debian': {
      case $::operatingsystemrelease {
        /(7.*|14\.04.*)/ : {
          $service_provider = 'debian'
        }
        default : {
          $service_provider = 'systemd'
        }
      }
    }
    'RedHat': {
      case $::operatingsystemrelease {
        /6.*/ : {
          $service_provider = 'redhat'
        }
        default : {
          $service_provider = 'systemd'
        }
      }
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}, currently only supports Debian and RedHat")
    }
  }
}