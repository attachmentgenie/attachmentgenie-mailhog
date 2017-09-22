# Class to install and configure mailhog.
#
# Use this module to install and configure mailhog.
#
# @example Declaring the class
#   include ::mailhog
#
# @param config Mailhog config.
# @param config_file Mailhog config file.
# @param install_dir Location of mailhog binary release.
# @param install_method How to install mailhog.
# @param manage_service Manage the mailhog service.
# @param manage_user Manage mailhog user and group.
# @param package_name Name of package to install.
# @param package_version Version of mailhog to install.
# @param service_name Name of service to manage.
# @param service_provider Init system that is used.
# @param service_ensure The state of the service.
# @param wget_source Location of mailhog binary release.
class mailhog (
  String $config = $::mailhog::params::config,
  String $config_file = $::mailhog::params::config_file,
  String $install_dir = $::mailhog::params::install_dir,
  Enum['package','wget'] $install_method = $::mailhog::params::install_method,
  Boolean $manage_service = $::mailhog::params::manage_service,
  Boolean $manage_user = $::mailhog::params::manage_user,
  String $package_name = $::mailhog::params::package_name,
  String $package_version = $::mailhog::params::package_version,
  String $service_name = $::mailhog::params::service_name,
  String $service_provider = $::mailhog::params::service_provider,
  Enum['running','stopped'] $service_ensure = $::mailhog::params::service_ensure,
  Optional[String] $wget_source = $::mailhog::params::wget_source,
) inherits mailhog::params {
  anchor { 'mailhog::begin': }
  -> class{ '::mailhog::install': }
  -> class{ '::mailhog::config': }
  ~> class{ '::mailhog::service': }
  -> anchor { 'mailhog::end': }
}
