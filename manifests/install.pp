# Class to install flink.
#
# Dont include this class directly.
#
class flink::install {
  if $::flink::manage_user {
    user { $::flink::user:
      ensure => present,
      home   => $::flink::install_dir
    }
    group { $::flink::group:
      ensure => present,
    }
  }
  case $::flink::install_method {
    'package': {
      package { $::flink::package_name:
        ensure => $::flink::package_version,
      }
    }
    'archive': {
      file { $::flink::install_dir:
        ensure => directory,
        group  => $::flink::group,
        owner  => $::flink::user,
      }
      if $::flink::manage_user {
        File[$::flink::install_dir] {
          require => [Group[$::flink::group],User[$::flink::user]],
        }
      }

      archive { '/tmp/flink.tar.gz':
        cleanup         => true,
        creates         => "${::flink::install_dir}/bin",
        extract         => true,
        extract_command => 'tar xfz %s --strip-components=1',
        extract_path    => $::flink::install_dir,
        source          => $::flink::archive_source,
        user            => $::flink::user,
        group           => $::flink::group,
        require         => File[$::flink::install_dir]
      }

    }
    default: {
      fail("Installation method ${::flink::install_method} not supported")
    }
  }
}