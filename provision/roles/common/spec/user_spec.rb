require 'spec_helper'

property['common_groups'].each do |group|
  describe group(group['name']) do
    if group.key?('remove') && group['remove']
      it { should_not exist }
    else
      it { should exist }
    end
  end
end
property['common_users'].each do |user|
  describe user(user['name']) do
    if user.key?('remove') && user['remove']
      it { should_not exist }
    else
      it { should exist }
      if user.key?('groups')
        user['groups'].each do |group_name|
          it { should belong_to_group group_name }
        end
      end
      it { should belong_to_group 'adm' } if user.key?('admin') && user['admin']
      user_shell = user['shell'] || '/bin/bash'
      it { should have_login_shell user_shell }
    end
  end
end
