# Class to manage the mailhog service.
#
# Dont include this class directly.
#
class mailhog::service {
  if $::mailhog::manage_service {
    case $::mailhog::service_provider {
      'debian','init','redhat': {
        file { "/etc/init.d/${::mailhog::service_name}":
          content => template('mailhog/mailhog.init.erb'),
          mode    => '0755',
          notify  => Service[$::mailhog::service_name],
        }
      }
      'systemd': {
        ::systemd::unit_file { "${::mailhog::service_name}.service":
          content => template('mailhog/mailhog.service.erb'),
          before  => Service[$::mailhog::service_name],
        }
      }
      default: {
        fail("Service provider ${::mailhog::service_provider} not supported")
      }
    }

    case $::mailhog::install_method {
      'package': {
        Service[$::mailhog::service_name] {
          subscribe => Package[$::mailhog::package_name],
        }
      }
      'wget': {}
      default: {
        fail("Installation method ${::mailhog::install_method} not supported")
      }
    }

    service { $::mailhog::service_name:
      ensure   => running,
      enable   => true,
      provider => $::mailhog::service_provider,
    }
  }
}
