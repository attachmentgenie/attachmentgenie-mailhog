require 'spec_helper'
describe 'flink' do
  context 'with defaults for all parameters' do
    it { should contain_class('flink') }
    it { should contain_anchor('flink::begin').that_comes_before('Class[Flink::Install]') }
    it { should contain_class('flink::install').that_comes_before('Class[Flink::Config]') }
    it { should contain_class('flink::config').that_notifies('Class[Flink::Service]') }
    it { should contain_class('flink::service').that_comes_before('Anchor[flink::end]') }
    it { should contain_anchor('flink::end') }
  end

  context 'with install_method set to archive' do
    let(:params) { {:install_method => 'archive'} }
    it { should contain_file('/opt/flink').that_comes_before('Archive[/tmp/flink.tar.gz]') }
    it { should contain_archive('/tmp/flink.tar.gz') }
    it { should contain_user('flink') }
    it { should contain_group('flink') }
    it { should_not contain_package('flink') }
  end

  context 'with install_method set to package' do
    let(:params) { {:install_method => 'package'} }
    it { should_not contain_file('/opt/flink').that_comes_before('Archive[/tmp/flink.tar.gz]') }
    it { should_not contain_archive('/tmp/flink.tar.gz') }
    it { should_not contain_user('flink') }
    it { should_not contain_group('flink') }
    it { should contain_package('flink') }
  end

  context 'with install_method set to invalid' do
    let(:params) { {:install_method => 'invalid'} }
    it { should raise_error(/Installation method invalid not supported/) }
  end

  context 'with service_provider set to init' do
    let(:params) { {:service_provider => 'init'} }
    it { should contain_file('/etc/init.d/flink') }
    it { should_not contain_systemd__Unit_file('flink.service').that_comes_before('Service[flink]') }
    it { should contain_service('flink') }
  end

  context 'with service_provider set to systemd' do
    let(:params) { {:service_provider => 'systemd'} }
    it { should_not contain_file('/etc/init.d/flink') }
    it { should contain_systemd__Unit_file('flink.service').that_comes_before('Service[flink]') }
    it { should contain_service('flink') }
  end

  context 'with service_provider set to invalid' do
    let(:params) { {:service_provider => 'invalid'} }
    it { should raise_error(/Service provider invalid not supported/) }
  end
end
