control 'jobmanager 01' do
  impact 1.0
  title 'mailhog jobmanager service is running'
  desc 'Ensures that the mailhog jobmanager service is up and running'
  describe service('mailhog') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_installed }
    it { is_expected.to be_running }
  end
end

control 'jobmanager 02' do
  impact 1.0
  title 'mailhog jobmanager service is listening at port 8025'
  desc 'Ensures that the mailhog jobmanager service is listening at port 8025'
  describe port(8025) do
    it { is_expected.to be_listening }
    its('processes') { is_expected.to include 'mailhog' }
    its('protocols') { is_expected.to include 'tcp' }
  end
end
