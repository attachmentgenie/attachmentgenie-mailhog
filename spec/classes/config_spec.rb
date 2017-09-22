require 'spec_helper'
describe 'mailhog' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      context 'config' do
        context 'with config set to something special' do
          let(:params) do
            {
              config: 'something special'
            }
          end
          it { is_expected.to contain_file('mailhog-config').with_content(%r{MAILHOG_OPTS=\"something\sspecial\"$}) }
        end

        context 'with config_file set to /etc/default/special' do
          let(:params) do
            {
              config_file: '/etc/default/special'
            }
          end
          it { is_expected.to contain_file('mailhog-config').with_path('/etc/default/special') }
        end

        context 'with manage_service set to true' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'mailhog'
            }
          end
          it { is_expected.to contain_file('mailhog-config').that_notifies('Service[mailhog]') }
        end

        context 'with manage_service set to false' do
          let(:params) do
            {
              manage_service: false,
              service_name: 'mailhog'
            }
          end
          it { is_expected.not_to contain_file('mailhog-config').that_notifies('Service[mailhog]') }
        end
      end
    end
  end
end
