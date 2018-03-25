require 'spec_helper'

describe file('/etc/sudoers.d/admin') do
  it { should exist }
  it { should be_file }
  if property['common_requre_sudo_password']
    its(:content) { should_not match(/NOPASSWD:/) }
  else
    its(:content) { should match(/NOPASSWD:/) }
  end
end
