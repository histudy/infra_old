require 'spec_helper'

property['python_packages'].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end
