control 'jobmanager 01' do
  impact 1.0
  title 'Flink jobmanager service is running'
  desc 'Ensures that the flink jobmanager service is up and running'
  describe service('flink') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end

control 'jobmanager 02' do
  impact 1.0
  title 'Flink jobmanager service is listening at port 8081'
  desc 'Ensures that the flink jobmanager service is listening at port 8081'
  describe port(8081) do
    it { should be_listening }
    its('processes') { should include 'java'}
    its('protocols') { should include 'tcp6' }
  end
end
