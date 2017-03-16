# Class to manage mailhog parameters.
#
# Dont include this class directly.
#
class mailhog::params () {
  $config          = '-ui-bind-addr=127.0.0.1:8025 -api-bind-addr=127.0.0.1:8025'
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
      $config_file = '/etc/default/mailhog'
      case $::operatingsystemrelease {
        /(^7.*|^14\.04.*)/ : {
          $service_provider = 'debian'
        }
        default : {
          $service_provider = 'systemd'
        }
      }
    }
    'RedHat': {
      $config_file = '/etc/sysconfig/mailhog'
      case $::operatingsystemrelease {
        /^6.*/ : {
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