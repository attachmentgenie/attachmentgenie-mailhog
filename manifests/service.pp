# Class to manage the flink service.
#
# Dont include this class directly.
#
class flink::service {
  if $::flink::manage_service {
    case $::flink::service_provider {
      'init': {
        file { "/etc/init.d/${::flink::service_name}":
          content => template('flink/flink.init.erb'),
          group   => $::flink::group,
          mode    => '0755',
          notify  => Service[$::flink::service_name],
          owner   => $::flink::user,
        }
      }
      'systemd': {
        ::systemd::unit_file { "${::flink::service_name}.service":
          content => template('flink/flink.service.erb'),
          before  => Service[$::flink::service_name],
        }
      }
      default: {
        fail("Service provider ${::flink::service_provider} not supported")
      }
    }

    case $::flink::install_method {
      'archive': {}
      'package': {
        Service[$::flink::service_name] {
          subscribe => Package[$::flink::package_name],
        }
      }
      default: {
        fail("Installation method ${::flink::install_method} not supported")
      }
    }

    service { $::flink::service_name:
      ensure => running,
      enable => true,
    }
  }
}
