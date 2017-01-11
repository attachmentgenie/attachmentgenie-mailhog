require 'spec_helper'
describe 'mailhog' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      context "config" do

        context 'with config set to something special' do
          let(:params) {
            {
                :config => 'something special',
            }
          }
          it { should contain_file('mailhog-config').with_content(/MAILHOG_OPTS=\"something\sspecial\"$/)}
        end

        context 'with config_file set to /etc/default/special' do
          let(:params) {
            {
                :config_file => '/etc/default/special',
            }
          }
          it { should contain_file('mailhog-config').with_path('/etc/default/special')}
        end

        context 'with manage_service set to true' do
          let(:params) {
            {
                :manage_service => true,
                :service_name   => 'mailhog'
            }
          }
          it { should contain_file('mailhog-config').that_notifies('Service[mailhog]') }
        end

        context 'with manage_service set to false' do
          let(:params) {
            {
                :manage_service => false,
                :service_name   => 'mailhog'
            }
          }
          it { should_not contain_file('mailhog-config').that_notifies('Service[mailhog]') }
        end

      end
    end
  end
end
