require 'spec_helper'

%w[histudy kakogawa_infra].each do |name|
  describe group(name) do
    it { should exist }
  end
end

%w[wate sperkbird nogajun 223n fu7mu4].each do |name|
  describe user(name) do
    it { should exist }
  end
end
