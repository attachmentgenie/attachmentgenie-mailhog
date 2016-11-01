# Class to install flink.
#
# Dont include this class directly.
#
class flink::install {
  case $::flink::install_method {
    'package': {
      package { $::flink::package_name:
        ensure => $::flink::package_version,
      }
    }
    'archive': {
      if $::flink::archive_source != undef {
        $real_archive_source = $::flink::archive_source
      }
      else {
        $real_archive_source = "http://apache.40b.nl/flink/flink-${::flink::archive_version}/flink-${::flink::archive_version}-bin-hadoop27-scala_2.10.tgz"
      }

      if $::flink::manage_user {
        user { $::flink::user:
          ensure => present,
          home   => $::flink::install_dir
        }
        group { $::flink::group:
          ensure => present,
        }

        File[$::flink::install_dir] {
          require => User['flink']
        }
      }

      file { $::flink::install_dir:
        ensure => directory,
        group  => $::flink::group,
        owner  => $::flink::user,
      }

      archive { '/tmp/flink.tar.gz':
        cleanup         => true,
        creates         => "${::flink::install_dir}/bin",
        extract         => true,
        extract_command => 'tar xfz %s --strip-components=1',
        extract_path    => $::flink::install_dir,
        source          => $real_archive_source,
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