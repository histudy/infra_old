require 'serverspec'
require 'net/ssh'
require 'yaml'
require 'deep_merge'

set :backend, :ssh

def e(value)
  Regexp.escape(value.is_a?(String) ? value : value.to_s)
end

host = ENV['TARGET_HOST']

options = Net::SSH::Config.for(host)

options[:user] ||= Etc.getlogin

set :host,        options[:host_name] || host
set :ssh_options, options

role_paths = ENV['ROLE_PATHS'].split(',')
role_names = ENV['ROLE_NAMES'].split(',')

ansible_vars = {}

deep_merge_option = {
  overwrite_arrays: true
}

find_file_patterns = []
role_paths.each do |role_path|
  find_file_patterns << role_path + '/{' + role_names.join(',') + '}/defaults/main.yml'
end

variable_files = Dir.glob(find_file_patterns)
variable_files.each do |role_default_variable_file|
  role_default_vars = YAML.load_file(role_default_variable_file)
  ansible_vars.deep_merge!(role_default_vars, deep_merge_option) if role_default_vars.is_a?(Hash)
end

trim_string = host + ' | SUCCESS => '
dump = `ansible -m setup #{host}`
dump.slice!(0, trim_string.length)
ansible_vars.deep_merge!(YAML.load(dump)['ansible_facts'], deep_merge_option)

dump = `ansible -m debug -a 'var=vars' #{host}`
dump.slice!(0, trim_string.length)
ansible_vars.deep_merge!(YAML.load(dump)['vars']['hostvars'][host], deep_merge_option)

find_file_patterns = []
role_paths.each do |role_path|
  find_file_patterns << role_path + '/{' + role_names.join(',') + '}/vars/main.yml'
end
variable_files = Dir.glob(find_file_patterns)
variable_files.each do |role_variable_file|
  role_vars = YAML.load_file(role_variable_file)
  ansible_vars.deep_merge!(role_vars, deep_merge_option) if role_vars.is_a?(Hash)
end

set_property ansible_vars
