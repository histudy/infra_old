require 'spec_helper'

describe file('/etc/sudoers.d/admin') do
  it { should exist }
  it { should be_file }
end
