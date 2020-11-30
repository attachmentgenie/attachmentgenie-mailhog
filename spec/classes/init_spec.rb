require 'spec_helper'
describe 'mailhog' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'config' do
        context 'with defaults for all parameters' do
          it { is_expected.to contain_class('mailhog') }
          it { is_expected.to contain_anchor('mailhog::begin').that_comes_before('Class[mailhog::Install]') }
          it { is_expected.to contain_class('mailhog::install').that_comes_before('Class[mailhog::Config]') }
          it { is_expected.to contain_class('mailhog::config').that_notifies('Class[mailhog::Service]') }
          it { is_expected.to contain_class('mailhog::service').that_comes_before('Anchor[mailhog::end]') }
          it { is_expected.to contain_anchor('mailhog::end') }
          it { is_expected.to contain_package('mailhog') }
          it { is_expected.to contain_service('mailhog') }
        end
      end
    end
  end
end
