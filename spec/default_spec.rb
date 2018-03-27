require 'spec_helper'

describe file('/etc/apt/sources.list.d/mackerel.list') do
  it { should exist }
  it { should be_file }
  it { should contain 'deb http://apt.mackerel.io/v2/ mackerel contrib' }
end

describe package('mackerel-agent') do
  it { should be_installed }
end

describe file('/etc/mackerel-agent/mackerel-agent.conf') do
  it { should exist }
  it { should be_file }
  its(:content) { should match(/^apikey = "#{e(property['mackerel_agent_api_key'])}"$/) }
  mackerel_cfg = property['mackerel_agent_cfg']
  mackerel_cfg = property['mackerel_agent_cfg'].to_h if property['mackerel_agent_cfg'].is_a?(Array)
  its(:content) { should match(/^pidfile = "#{e(mackerel_cfg['pidfile'])}"$/) } if mackerel_cfg.key?('pidfile')
  its(:content) { should match(/^root = "#{e(mackerel_cfg['root'])}"$/) } if mackerel_cfg.key?('root')
  if mackerel_cfg.key?('verbose')
    verbose = mackerel_cfg['verbose'] ? 'true' : 'false'
    its(:content) { should match(/^verbose = #{verbose}$/) }
  end
  if mackerel_cfg.key?('display_name')
    its(:content) { should match(/^display_name = "#{e(mackerel_cfg['display_name'])}"$/) }
  end
  its(:content) { should match(/^http_proxy = "#{e(mackerel_cfg['http_proxy'])}"$/) } if mackerel_cfg.key?('http_proxy')
  its(:content) { should match(/^roles = \[ "#{mackerel_cfg.join('","')}" \]$/) } if mackerel_cfg.key?('roles')
  if mackerel_cfg.key?('host_status')
    host_status_cfg = mackerel_cfg['host_status']
    if host_status_cfg.key?('on_start')
      its(:content) { should match(/^on_start = "#{host_status_cfg['on_start']}"$/).after(/^\[host_status\]/) }
    end
    if host_status_cfg.key?('on_stop')
      its(:content) { should match(/^on_stop = "#{host_status_cfg['on_stop']}"$/).after(/^\[host_status\]/) }
    end
  end
  if mackerel_cfg.key?('filesystems')
    filesystems_cfg = mackerel_cfg['filesystems']
    if filesystems_cfg.key?('ignore')
      its(:content) { should match(/^ignore = "#{filesystems_cfg['ignore']}"$/).after(/^\[filesystems\]/) }
    end
    if filesystems_cfg.key?('use_mountpoint')
      verbose = filesystems_cfg['use_mountpoint'] ? 'true' : 'false'
      its(:content) { should match(/^use_mountpoint = #{verbose}$/).after(/^\[filesystems\]/) }
    end
  end
  if mackerel_cfg.key?('diagnostic')
    diagnostic = mackerel_cfg['diagnostic'] ? 'true' : 'false'
    its(:content) { should match(/^diagnostic = #{diagnostic}$/) }
  end
  if mackerel_cfg.key?('plugin')
    plugin_cfg = mackerel_cfg['plugin']
    if plugin_cfg.key?('metrics')
      plugin_cfg['metrics'].each do |k, v|
        its(:content) { should match(/^command = "#{e(v)}"$/) }
      end
    end
    if mackerel_cfg.key?('checkes')
      plugin_cfg['checkes'].each do |k, v|
        if v.is_a?(Hash)
          its(:content) { should match(/^command = "#{e(v['command'])}"$/) }
        else
          its(:content) { should match(/^command = "#{e(v)}"$/) }
        end
      end
    end
  end
end

describe package('mackerel-agent-plugins') do
  if property['mackerel_agent_install_agent_plugins']
    it { should be_installed }
  else
    it { should_not be_installed }
  end
end

describe package('mackerel-check-plugins') do
  if property['mackerel_agent_install_check_plugins']
    it { should be_installed }
  else
    it { should_not be_installed }
  end
end

describe service('mackerel-agent') do
  if property['mackerel_agent_active_and_enabled_on_system_startup']
    it { should be_enabled }
    it { should be_running }
  else
    it { should_not be_enabled }
    it { should_not be_running }
  end
end
