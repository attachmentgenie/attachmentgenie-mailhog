# Class to manage the mailhog service.
#
# Dont include this class directly.
#
class mailhog::service {
  if $::mailhog::manage_service {
    case $::mailhog::service_provider {
      'debian','init','redhat': {
        file { 'mailhog service file':
          path    => "/etc/init.d/${::mailhog::service_name}",
          content => template("mailhog/mailhog.init.${::osfamily}.erb"),
          mode    => '0755',
          notify  => Service['mailhog'],
        }
      }
      'systemd': {
        ::systemd::unit_file { "${::mailhog::service_name}.service":
          content => template('mailhog/mailhog.service.erb'),
          before  => Service['mailhog'],
        }
      }
      default: {
        fail("Service provider ${::mailhog::service_provider} not supported")
      }
    }

    case $::mailhog::install_method {
      'package': {
        Service['mailhog'] {
          subscribe => Package['mailhog'],
        }
      }
      'wget': {}
      default: {
        fail("Installation method ${::mailhog::install_method} not supported")
      }
    }

    service { 'mailhog':
      ensure   => running,
      enable   => true,
      name     => $::mailhog::service_name,
      provider => $::mailhog::service_provider,
    }
  }
}
