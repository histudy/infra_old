require 'serverspec'
require 'net/ssh'
require 'yaml'

set :backend, :ssh

if ENV['ASK_SUDO_PASSWORD']
  begin
    require 'highline/import'
  rescue LoadError
    fail "highline is not available. Try installing it."
  end
  set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
else
  set :sudo_password, ENV['SUDO_PASSWORD']
end

host = ENV['TARGET_HOST']

options = Net::SSH::Config.for(host)

def e(value)
  Regexp.escape(value.is_a?(String) ? value : value.to_s)
end

class ::Hash
  def deep_merge(other_hash, &block)
    dup.deep_merge!(other_hash, &block)
  end
  def deep_merge!(other_hash, &block)
    other_hash.each_pair do |k,v|
      tv = self[k]
      if tv.is_a?(Hash) && v.is_a?(Hash)
        self[k] = tv.deep_merge(v, &block)
      else
        self[k] = block && tv ? block.call(k, tv, v) : v
      end
    end
    self
  end
end

options[:user] ||= Etc.getlogin

set :host,        options[:host_name] || host
set :ssh_options, options

role_paths = ENV['ROLE_PATHS'].split(',')
role_names = ENV['ROLE_NAMES'].split(',')

test_vars = {}

find_patterns = []
role_paths.each do |role_path|
  find_patterns << role_path + '/{' + role_names.join(',') + '}/defaults/main.yml'
end
variable_files = Dir.glob(find_patterns)
variable_files.each do |default_variable_file|
  role_default_vars = YAML.load_file(default_variable_file)
  test_vars.deep_merge!(role_default_vars) if role_default_vars.is_a?(Hash)
end

test_vars.deep_merge!(YAML.load_file('facts/' + host)['vars'])

find_patterns = []
role_paths.each do |role_path|
  find_patterns << role_path + '/{' + role_names.join(',') + '}/vars/main.yml'
end
variable_files = Dir.glob(find_patterns)

variable_files.each do |role_variable_file|
  role_vars = YAML.load_file(role_variable_file)
  test_vars.deep_merge!(role_vars) if role_vars.is_a?(Hash)
end

set_property test_vars
