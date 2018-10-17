require 'spec_helper'
describe 'mailhog' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'service' do
        context 'with manage_service set to true' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'mailhog',
            }
          end

          it { is_expected.to contain_service('mailhog') }
        end

        context 'with manage_service set to false' do
          let(:params) do
            {
              manage_service: false,
              service_name: 'mailhog',
            }
          end

          it { is_expected.not_to contain_service('mailhog') }
        end

        context 'with service_name set to specialservice' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'specialservice',
            }
          end

          it { is_expected.to contain_service('mailhog').with_name('specialservice') }
        end

        context 'with service_name set to specialservice and with service_provider set to debian' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'specialservice',
              service_provider: 'debian',
            }
          end

          it { is_expected.to contain_service('mailhog').with_name('specialservice') }
          it { is_expected.to contain_file('mailhog service file').that_notifies('Service[mailhog]').with_content(%r{^NAME="specialservice"}) }
        end

        context 'with install_dir set to /opt/special and manage_service set to true and service_provider set to debian' do
          let(:params) do
            {
              install_dir: '/opt/special',
              manage_service: true,
              service_name: 'mailhog',
              service_provider: 'debian',
            }
          end

          it { is_expected.to contain_file('mailhog service file').with_content(%r{^BIN="\/opt\/special\/mailhog"$}) }
        end

        context 'with install_dir set to /opt/special and manage_service set to true and service_provider set to init' do
          let(:params) do
            {
              install_dir: '/opt/special',
              manage_service: true,
              service_name: 'mailhog',
              service_provider: 'init',
            }
          end

          it { is_expected.to contain_file('mailhog service file').with_content(%r{^BIN="\/opt\/special\/mailhog"$}) }
        end

        context 'with install_dir set to /opt/special and manage_service set to true and service_provider set to redhat' do
          let(:params) do
            {
              install_dir: '/opt/special',
              manage_service: true,
              service_name: 'mailhog',
              service_provider: 'redhat',
            }
          end

          it { is_expected.to contain_file('mailhog service file').with_content(%r{^BIN="\/opt\/special\/mailhog"$}) }
        end

        context 'with service_name set to specialservice and with service_provider set to init' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'specialservice',
              service_provider: 'init',
            }
          end

          it { is_expected.to contain_service('mailhog').with_name('specialservice') }
          it { is_expected.to contain_file('mailhog service file').that_notifies('Service[mailhog]').with_content(%r{^NAME="specialservice"}) }
        end

        context 'with service_name set to specialservice and with service_provider set to redhat' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'specialservice',
              service_provider: 'redhat',
            }
          end

          it { is_expected.to contain_service('mailhog').with_name('specialservice') }
          it { is_expected.to contain_file('mailhog service file').that_notifies('Service[mailhog]').with_content(%r{^NAME="specialservice"}) }
        end

        context 'with service_name set to specialservice and with service_provider set to systemd' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'specialservice',
              service_provider: 'systemd',
            }
          end

          it { is_expected.to contain_service('mailhog').with_name('specialservice') }
          it { is_expected.to contain_systemd__Unit_file('specialservice.service').that_comes_before('Service[mailhog]').with_content(%r{^Description=specialservice}) }
        end

        context 'with service_name set to specialservice and with install_method set to package' do
          let(:params) do
            {
              install_method: 'package',
              manage_service: true,
              package_name: 'mailhog',
              service_name: 'specialservice',
            }
          end

          it { is_expected.to contain_service('mailhog').that_subscribes_to('Package[mailhog]') }
        end

        context 'with service_provider set to init' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'mailhog',
              service_provider: 'init',
            }
          end

          it { is_expected.to contain_file('mailhog service file') }
          it { is_expected.not_to contain_systemd__Unit_file('mailhog.service').that_comes_before('Service[mailhog]') }
          it { is_expected.to contain_service('mailhog') }
        end

        context 'with service_provider set to systemd' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'mailhog',
              service_provider: 'systemd',
            }
          end

          it { is_expected.not_to contain_file('mailhog service file') }
          it { is_expected.to contain_systemd__Unit_file('mailhog.service').that_comes_before('Service[mailhog]') }
          it { is_expected.to contain_service('mailhog') }
        end

        context 'with install_dir set to mailhog install dir and manage_service set to true and service_provider set to systemd' do
          let(:params) do
            {
              install_dir: '/opt/special',
              manage_service: true,
              service_name: 'mailhog',
              service_provider: 'systemd',
            }
          end

          it { is_expected.to contain_systemd__Unit_file('mailhog.service').with_content(%r{^ExecStart=/opt/special/mailhog}) }
        end

        context 'with package_name set to specialpackage and manage_service set to true' do
          let(:params) do
            {
              install_method: 'package',
              manage_service: true,
              package_name: 'specialpackage',
              service_name: 'mailhog',
            }
          end

          it { is_expected.to contain_package('mailhog').with_name('specialpackage') }
          it { is_expected.to contain_service('mailhog').that_subscribes_to('Package[mailhog]') }
        end
      end
    end
  end
end
