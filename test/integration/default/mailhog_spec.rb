control 'jobmanager 01' do
  impact 1.0
  title 'mailhog jobmanager service is running'
  desc 'Ensures that the mailhog jobmanager service is up and running'
  describe service('mailhog') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end

control 'jobmanager 02' do
  impact 1.0
  title 'mailhog jobmanager service is listening at port 8081'
  desc 'Ensures that the mailhog jobmanager service is listening at port 8025'
  describe port(8025) do
    it { should be_listening }
    its('processes') { should include 'java'}
    its('protocols') { should include 'tcp6' }
  end
end
