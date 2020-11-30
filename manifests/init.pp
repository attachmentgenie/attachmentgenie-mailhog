# Class to install and configure mailhog.
#
# Use this module to install and configure mailhog.
#
# @example Declaring the class
#   class { '::mailhog':
#     install_method => 'archive',
#     archive_source => 'https://github.com/mailhog/MailHog/releases/download/v1.0.1/MailHog_linux_amd64',
#   }
#
# @param config Mailhog config.
# @param config_file Mailhog config file.
# @param install_dir Location of mailhog binary release.
# @param install_method How to install mailhog.
# @param manage_service Manage the mailhog service.
# @param package_name Name of package to install.
# @param package_version Version of mailhog to install.
# @param service_name Name of service to manage.
# @param service_provider Init system that is used.
# @param service_ensure The state of the service.
# @param archive_source Location of mailhog binary release.
class mailhog (
  String[1] $config ,
  Stdlib::Absolutepath $config_file ,
  Stdlib::Absolutepath $install_dir ,
  Enum['package','archive'] $install_method,
  Boolean $manage_service,
  String[1] $package_name,
  String[1] $package_version,
  String[1] $service_name,
  String[1] $service_provider,
  Enum['running','stopped'] $service_ensure,
  Optional[Stdlib::HTTPUrl] $archive_source = undef,
) {
  anchor { 'mailhog::begin': }
  -> class{ '::mailhog::install': }
  -> class{ '::mailhog::config': }
  ~> class{ '::mailhog::service': }
  -> anchor { 'mailhog::end': }
}
