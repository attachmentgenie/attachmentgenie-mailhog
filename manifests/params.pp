# Class to manage flink parameters.
#
# Dont include this class directly.
#
class flink::params () {
  $archive_source  = undef
  $archive_version = '1.1.3'
  $group           = 'flink'
  $install_dir     = '/opt/flink'
  $install_method  = 'archive'
  $manage_service  = true
  $manage_user     = true
  $package_version = 'present'
  $package_name    = 'flink'
  $service_name    = 'flink'
  $user            = 'flink'
  case $::osfamily {
    'Debian': {
      case $::operatingsystemrelease {
        /(7.*|14\.04.*)/ : {
          $service_provider = 'init'
        }
        default : {
          $service_provider = 'systemd'
        }
      }
    }
    'RedHat': {
      case $::operatingsystemrelease {
        /6.*/ : {
          $service_provider = 'init'
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