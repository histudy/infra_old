require 'spec_helper'

property['mariadb_packages'].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe package('python-mysqldb') do
  it { should be_installed }
end

describe file('/etc/mysql/mariadb.conf.d/99-custom.cnf') do
  it { should exist }
  it { should be_file }
  # ----------
  # client section
  # ----------
  # Charset
  its(:content) { should match(/^default-character-set = #{e(property['mariadb_default_charset'])}/) }
  # ----------
  # mysql section
  # ----------
  # Charset
  its(:content) { should match(/^default-character-set = #{e(property['mariadb_default_charset'])}/) }
  # ----------
  # mysqld section
  # ----------
  # Charset
  its(:content) { should match(/^character-set-server = #{e(property['mariadb_default_charset'])}/) }
  its(:content) { should match(/^collation-server = #{e(property['mariadb_default_collation'])}/) }

  # General
  mysqld_setting = property['mariadb_cfg']['mysqld']
  sql_mode = mysqld_setting['sql_mode'].is_a?(Array) ? mysqld_setting['sql_mode'].join(',') : mysqld_setting['sql_mode']
  its(:content) { should match(/^sql_mode = "#{e(sql_mode)}"/) }
  its(:content) { should match(/^bind-address = #{e(mysqld_setting['bind_address'])}/) }
  its(:content) { should match(/^datadir = #{e(mysqld_setting['datadir'])}/) } if mysqld_setting.key?('datadir')
  its(:content) { should match(/^socket = #{e(mysqld_setting['socket'])}/) } if mysqld_setting.key?('socket')
  if mysqld_setting.key?('innodb_data_home_dir')
    its(:content) { should match(/^innodb_data_home_dir = #{e(mysqld_setting['innodb_data_home_dir'])}/) }
  end
  # Network
  if mysqld_setting.key?('max_connections')
    its(:content) { should match(/^max_connections = #{mysqld_setting['max_connections']}/) }
  end
  if mysqld_setting.key?('connect_timeout')
    its(:content) { should match(/^connect_timeout = #{mysqld_setting['connect_timeout']}/) }
  end
  if mysqld_setting.key?('skip_name_resolve')
    skip_name_resolve_value = mysqld_setting['skip_name_resolve'] ? 'ON' : 'OFF'
    its(:content) { should match(/^skip_name_resolve = #{skip_name_resolve_value}$/) }
  end
  if mysqld_setting.key?('max_allowed_packet')
    its(:content) { should match(/^max_allowed_packet = #{e(mysqld_setting['max_allowed_packet'])}/) }
  end
  if mysqld_setting.key?('interactive_timeout')
    its(:content) { should match(/^interactive_timeout = #{mysqld_setting['interactive_timeout']}/) }
  end
  if mysqld_setting.key?('wait_timeout')
    its(:content) { should match(/^wait_timeout = #{mysqld_setting['wait_timeout']}/) }
  end
  # Cache
  its(:content) { should match(/^query_cache_limit = #{e(mysqld_setting['query_cache_limit'])}/) }
  its(:content) { should match(/^query_cache_size = #{e(mysqld_setting['query_cache_size'])}/) }
  its(:content) { should match(/^query_cache_type = #{e(mysqld_setting['query_cache_type'])}/) }
  if mysqld_setting.key?('table_open_cache')
    its(:content) { should match(/^table_open_cache = #{mysqld_setting['table_open_cache']}/) }
  end
  if mysqld_setting.key?('thread_cache_size')
    its(:content) { should match(/^thread_cache_size = #{e(mysqld_setting['thread_cache_size'])}/) }
  end
  if mysqld_setting.key?('table_definition_cache')
    its(:content) { should match(/^table_definition_cache = #{e(mysqld_setting['table_definition_cache'])}/) }
  end
  # InnoDB

  innodb_flush_log_at_trx_commit_value = mysqld_setting['innodb_flush_log_at_trx_commit']
  its(:content) { should match(/^innodb_flush_log_at_trx_commit = #{e(innodb_flush_log_at_trx_commit_value)}/) }

  innodb_additional_mem_pool_size_value = mysqld_setting['innodb_additional_mem_pool_size']
  its(:content) { should match(/^innodb_additional_mem_pool_size = #{e(innodb_additional_mem_pool_size_value)}/) }
  if mysqld_setting.key?('innodb_log_file_size')
    its(:content) { should match(/^innodb_log_file_size = #{e(mysqld_setting['innodb_log_file_size'])}/) }
  end
  if mysqld_setting.key?('innodb_log_files_in_group')
    its(:content) { should match(/^innodb_log_files_in_group = #{e(mysqld_setting['innodb_log_files_in_group'])}/) }
  end
  if mysqld_setting.key?('innodb_strict_mode')
    innodb_strict_mode_value = mysqld_setting['innodb_strict_mode'] ? 'ON' : 'OFF'
    its(:content) { should match(/^innodb_strict_mode = #{innodb_strict_mode_value}/) }
  end
  if mysqld_setting.key?('innodb_large_prefix')
    innodb_large_prefix_value = mysqld_setting['innodb_large_prefix'] ? 'ON' : 'OFF'
    its(:content) { should match(/^innodb_large_prefix = #{innodb_large_prefix_value}/) }
  end
  if mysqld_setting.key?('innodb_file_format')
    its(:content) { should match(/^innodb_file_format = #{e(mysqld_setting['innodb_file_format'])}/) }
  end

  ## Global Buffer
  its(:content) { should match(/^innodb_buffer_pool_size = #{e(mysqld_setting['innodb_buffer_pool_size'])}/) }
  its(:content) { should match(/^innodb_log_buffer_size = #{e(mysqld_setting['innodb_log_buffer_size'])}/) }

  ## Thread Buffer
  if mysqld_setting.key?('sort_buffer_size')
    its(:content) { should match(/^sort_buffer_size = #{e(mysqld_setting['sort_buffer_size'])}/) }
  end
  if mysqld_setting.key?('join_buffer_size')
    its(:content) { should match(/^join_buffer_size = #{e(mysqld_setting['join_buffer_size'])}/) }
  end
  if mysqld_setting.key?('read_buffer_size')
    its(:content) { should match(/^read_buffer_size = #{e(mysqld_setting['read_buffer_size'])}/) }
  end
  if mysqld_setting.key?('read_rnd_buffer_size')
    its(:content) { should match(/^read_rnd_buffer_size = #{e(mysqld_setting['read_rnd_buffer_size'])}/) }
  end

  # MyISAM
  ## Global Buffer
  its(:content) { should match(/^key_buffer_size = #{e(mysqld_setting['key_buffer_size'])}/) }

  ## Thread Buffer
  if mysqld_setting.key?('myisam_sort_buffer_size')
    its(:content) { should match(/^myisam_sort_buffer_size = #{e(mysqld_setting['myisam_sort_buffer_size'])}/) }
  end

  # Temp Tables
  if mysqld_setting.key?('max_heap_table_size')
    its(:content) { should match(/^max_heap_table_size = #{e(mysqld_setting['max_heap_table_size'])}/) }
  end
  if mysqld_setting.key?('tmp_table_size')
    its(:content) { should match(/^tmp_table_size = #{e(mysqld_setting['tmp_table_size'])}/) }
  end

  # Logging
  if mysqld_setting.key?('slow_query_log')
    slow_query_log_value = mysqld_setting['slow_query_log'] ? 'ON' : 'OFF'
    its(:content) { should match(/^slow_query_log = #{slow_query_log_value}/) }
  end
  if mysqld_setting.key?('long_query_time')
    its(:content) { should match(/^long_query_time = #{e(mysqld_setting['long_query_time'])}/) }
  end
  if mysqld_setting.key?('log_warnings')
    its(:content) { should match(/^log_warnings = #{e(mysqld_setting['log_warnings'])}/) }
  end
  if mysqld_setting.key?('min_examined_row_limit')
    its(:content) { should match(/^min_examined_row_limit = #{mysqld_setting['min_examined_row_limit']}/) }
  end
  if mysqld_setting.key?('log_queries_not_using_indexes')
    log_queries_not_using_indexes_value = mysqld_setting['log_queries_not_using_indexes'] ? 'ON' : 'OFF'
    its(:content) { should match(/^log_queries_not_using_indexes = #{log_queries_not_using_indexes_value}/) }
  end
  if mysqld_setting.key?('log_slow_admin_statements')
    log_slow_admin_statements_value = mysqld_setting['log_slow_admin_statements'] ? 'ON' : 'OFF'
    its(:content) { should match(/^log_slow_admin_statements = #{log_slow_admin_statements_value}/) }
  end
  if mysqld_setting.key?('slow_query_log_file')
    its(:content) { should match(/^slow_query_log_file = #{e(mysqld_setting['slow_query_log_file'])}/) }
  end

  if mysqld_setting.key?('general_log')
    general_log = mysqld_setting['general_log'] ? 'ON' : 'OFF'
    its(:content) { should match(/^general_log = #{general_log}/) }
  end
  if mysqld_setting.key?('general_log_file')
    its(:content) { should match(/^general_log_file = #{e(mysqld_setting['general_log_file'])}/) }
  end

  # Replication
  if mysqld_setting.key?('gtid_domain_id')
    its(:content) { should match(/^gtid_domain_id = #{e(mysqld_setting['gtid_domain_id'])}/) }
  end
  its(:content) { should match(/^server_id = #{e(mysqld_setting['server_id'])}/) } if mysqld_setting.key?('server_id')
  its(:content) { should match(/^log_bin = #{e(mysqld_setting['log_bin'])}/) } if mysqld_setting.key?('log_bin')
  if mysqld_setting.key?('binlog_format')
    its(:content) { should match(/^binlog_format = #{e(mysqld_setting['binlog_format'])}/) }
  end
  if mysqld_setting.key?('expire_logs_days')
    its(:content) { should match(/^expire_logs_days = #{e(mysqld_setting['expire_logs_days'])}/) }
  end
  if mysqld_setting.key?('read_only')
    read_only_value = mysqld_setting['read_only'] ? 'ON' : 'OFF'
    its(:content) { should match(/^read_only = #{read_only_value}$/) }
  end
  if mysqld_setting.key?('log_slave_updates')
    log_slave_updates_value = mysqld_setting['log_slave_updates'] ? 'ON' : 'OFF'
    its(:content) { should match(/^log_slave_updates = #{log_slave_updates_value}$/) }
  end

  # ----------
  # mysqld_safe section
  # ----------
  if property['mariadb_cfg'].key?('mysqld_safe')
    if property['mariadb_cfg']['mysqld_safe'].key?('datadir')
      its(:content) { should match(/^datadir = #{e(property['mariadb_cfg']['mysqld_safe']['datadir'])}/) }
    end
    if property['mariadb_cfg']['mysqld_safe'].key?('socket')
      its(:content) { should match(/^socket = #{e(property['mariadb_cfg']['mysqld_safe']['socket'])}/) }
    end
  end
end

describe service('mariadb') do
  it { should be_enabled }
  it { should be_running }
end

describe port(3306) do
  it { should be_listening }
end
