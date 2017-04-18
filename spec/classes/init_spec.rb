require 'spec_helper'
describe 'teampass' do
  context 'with default values for all parameters' do
    it { should contain_class('teampass') }
  end
end
