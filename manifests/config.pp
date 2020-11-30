# Class to configure mailhog.
#
# @api private
class mailhog::config {
  file { 'mailhog-config':
    path    => $::mailhog::config_file,
    content => template('mailhog/mailhog-config.erb'),
    mode    => '0644',
  }

  if $::mailhog::manage_service {
    File['mailhog-config'] {
      notify  => Service['mailhog'],
    }
  }
}