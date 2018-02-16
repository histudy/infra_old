require 'spec_helper'

%w[python-requests python-future python-boto3].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end
describe package('dns-lexicon') do
  it { should be_installed.by('pip') }
end
