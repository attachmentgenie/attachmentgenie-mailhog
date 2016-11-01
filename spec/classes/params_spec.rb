require 'spec_helper'
describe 'flink::params' do
  context 'Should not contain any resources' do
    it { should contain_class('flink::params') }
    it { should have_resource_count(0) }
  end
end