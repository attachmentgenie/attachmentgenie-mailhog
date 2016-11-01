require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.default_facts = {
      :osfamily => 'RedHat',
      :operatingsystemrelease => '7.2',
      :path => '/usr/bin',
  }
  c.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end
end
