require 'spec_helper'

%w[python-certifi python-requests python-future].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

if property['lexicion_install_boto3']
  describe package('python-boto3') do
    it { should be_installed }
  end
end

describe package('dns-lexicon') do
  it { should be_installed.by('pip') }
end
