require 'spec_helper'
describe 'mailhog' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'install' do
        context 'with wget_source set to special_mailhog' do
          let(:params) do
            {
              install_method: 'wget',
              wget_source: 'special_mailhog',
            }
          end

          it { is_expected.to contain_wget__fetch('mailhog binary').with_source('special_mailhog') }
        end

        context 'with install_dir set to mailhog install dir' do
          let(:params) do
            {
              install_dir: '/opt/special',
              install_method: 'wget',
            }
          end

          it { is_expected.to contain_file('mailhog install dir').with_path('/opt/special') }
          it { is_expected.to contain_wget__fetch('mailhog binary').with_destination('/opt/special/mailhog') }
          it { is_expected.to contain_wget__fetch('mailhog binary').that_requires('File[mailhog install dir]') }
        end

        context 'with install_method set to package' do
          let(:params) do
            {
              install_dir: '/usr/bin',
              install_method: 'package',
              package_name: 'mailhog',
            }
          end

          it { is_expected.not_to contain_file('mailhog install dir').that_comes_before('Wget::Fetch[mailhog binary]') }
          it { is_expected.not_to contain_wget__fetch('mailhog binary') }
          it { is_expected.to contain_package('mailhog') }
        end

        context 'with install_method set to wget' do
          let(:params) do
            {
              install_dir: '/usr/bin',
              install_method: 'wget',
              package_name: 'mailhog',
            }
          end

          it { is_expected.to contain_file('mailhog install dir').that_comes_before('Wget::Fetch[mailhog binary]') }
          it { is_expected.to contain_wget__fetch('mailhog binary') }
          it { is_expected.to contain_file('mailhog binary') }
          it { is_expected.not_to contain_package('mailhog') }
        end

        context 'with package_name set to specialpackage' do
          let(:params) do
            {
              install_method: 'package',
              package_name: 'specialpackage',
            }
          end

          it { is_expected.to contain_package('mailhog').with_name('specialpackage') }
        end

        context 'with package_version set to 42.42.42' do
          let(:params) do
            {
              install_method: 'package',
              package_name: 'mailhog',
              package_version: '42.42.42',
            }
          end

          it { is_expected.to contain_package('mailhog').with_ensure('42.42.42') }
        end
      end
    end
  end
end
