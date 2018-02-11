require 'spec_helper'

describe file('/etc/apt/sources.list.d/backports.list') do
  it { should exist }
  it { should be_file }
end
