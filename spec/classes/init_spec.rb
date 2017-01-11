require 'spec_helper'
describe 'mailhog' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      context "config" do

        context 'with defaults for all parameters' do
          it { should contain_class('mailhog') }
          it { should contain_anchor('mailhog::begin').that_comes_before('Class[mailhog::Install]') }
          it { should contain_class('mailhog::install').that_comes_before('Class[mailhog::Config]') }
          it { should contain_class('mailhog::config').that_notifies('Class[mailhog::Service]') }
          it { should contain_class('mailhog::service').that_comes_before('Anchor[mailhog::end]') }
          it { should contain_anchor('mailhog::end') }
          it { should contain_package('mailhog') }
          it { should contain_service('mailhog') }
        end

      end
    end
  end
end
