# Class to install and configure apache mailhog.
#
# Use this module to install and configure apache mailhog.
#
# @example Declaring the class
#   include ::mailhog
#
# @param install_dir (String) Location of mailhog binary release.
# @param install_method (String) How to install mailhog.
# @param manage_service (Boolean) Manage the mailhog service.
# @param package_name (String) Name of package to install.
# @param package_version (String) Version of mailhog to install.
# @param service_name (String) Name of service to manage.
# @param service_provider (String) init system that is used.
# @param wget_source (String) Location of mailhog binary release.
class mailhog (
  $install_dir      = $::mailhog::params::install_dir,
  $install_method   = $::mailhog::params::install_method,
  $manage_service   = $::mailhog::params::manage_service,
  $package_name     = $::mailhog::params::package_name,
  $package_version  = $::mailhog::params::package_version,
  $service_name     = $::mailhog::params::service_name,
  $service_provider = $::mailhog::params::service_provider,
  $wget_source      = $::mailhog::params::wget_source,
) inherits mailhog::params {
  validate_bool(
    $manage_service,
  )
  validate_string(
    $install_dir,
    $install_method,
    $package_name,
    $package_version,
    $service_name,
    $service_provider,
  )
  if $install_method == 'wget' {
    validate_string(
      $wget_source
    )
  }

  anchor { 'mailhog::begin': } ->
  class{ '::mailhog::install': } ->
  class{ '::mailhog::config': } ~>
  class{ '::mailhog::service': } ->
  anchor { 'mailhog::end': }
}
