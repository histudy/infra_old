require 'spec_helper'

def to_ini_value(value)
  return '' if value.nil?

  return value ? 'On' : 'Off' if !!value === value

  escape_value = value.is_a?(String) ? value : value.to_s
  Regexp.escape(escape_value)
end

if property['php_packages'].include?(property['php_fpm_package_name'])
  describe file(property['php_ini_dir'] + '/fpm/php.ini') do
    php_ini = property['php_ini_fpm_cfg']
    # Core
    if php_ini.key?('user_ini')
      if php_ini['user_ini'].key?('filename')
        its(:content) { should match(/^user_ini.filename = #{to_ini_value(php_ini['user_ini']['filename'])}$/) }
      end
      if php_ini['user_ini'].key?('cache_ttl')
        its(:content) { should match(/^user_ini.cache_ttl = #{to_ini_value(php_ini['user_ini']['cache_ttl'])}$/) }
      end
    end
    its(:content) { should match(/^engine = #{to_ini_value(php_ini['engine'])}$/) }
    its(:content) { should match(/^short_open_tag = #{to_ini_value(php_ini['short_open_tag'])}$/) }
    its(:content) { should match(/^precision = #{to_ini_value(php_ini['precision'])}$/) }
    its(:content) { should match(/^output_buffering = #{to_ini_value(php_ini['output_buffering'])}$/) }
    if php_ini.key?('output_handler')
      its(:content) { should match(/^output_handler = #{to_ini_value(php_ini['output_handler'])}$/) }
    end
    its(:content) { should match(/^implicit_flush = #{to_ini_value(php_ini['implicit_flush'])}$/) }
    unserialize_callback_func = to_ini_value(php_ini['unserialize_callback_func'])
    its(:content) { should match(/^unserialize_callback_func = #{unserialize_callback_func}$/) }
    its(:content) { should match(/^serialize_precision = #{to_ini_value(php_ini['serialize_precision'])}$/) }
    if php_ini.key?('open_basedir')
      its(:content) { should match(/^open_basedir = #{to_ini_value(php_ini['open_basedir'])}$/) }
    end
    its(:content) { should match(/^disable_functions = #{to_ini_value(php_ini['disable_functions'].join(','))}$/) }
    its(:content) { should match(/^disable_classes = #{to_ini_value(php_ini['disable_classes'])}$/) }
    if php_ini.key?('ignore_user_abort')
      its(:content) { should match(/^ignore_user_abort = #{to_ini_value(php_ini['ignore_user_abort'])}$/) }
    end
    if php_ini.key?('realpath_cache_size')
      its(:content) { should match(/^realpath_cache_size = #{to_ini_value(php_ini['realpath_cache_size'])}$/) }
    end
    if php_ini.key?('realpath_cache_ttl')
      its(:content) { should match(/^realpath_cache_ttl = #{to_ini_value(php_ini['realpath_cache_ttl'])}$/) }
    end
    its(:content) { should match(/^expose_php = #{to_ini_value(php_ini['expose_php'])}$/) }
    its(:content) { should match(/^max_execution_time = #{to_ini_value(php_ini['max_execution_time'])}$/) }
    its(:content) { should match(/^max_input_time = #{to_ini_value(php_ini['max_input_time'])}$/) }
    if php_ini.key?('max_input_nesting_level')
      its(:content) { should match(/^max_input_nesting_level = #{to_ini_value(php_ini['max_input_nesting_level'])}$/) }
    end
    if php_ini.key?('max_input_vars')
      its(:content) { should match(/^max_input_vars = #{to_ini_value(php_ini['max_input_vars'])}$/) }
    end
    its(:content) { should match(/^memory_limit = #{to_ini_value(php_ini['memory_limit'])}$/) }
    its(:content) { should match(/^error_reporting = #{to_ini_value(php_ini['error_reporting'])}$/) }
    its(:content) { should match(/^display_errors = #{to_ini_value(php_ini['display_errors'])}$/) }
    its(:content) { should match(/^display_startup_errors = #{to_ini_value(php_ini['display_startup_errors'])}$/) }
    its(:content) { should match(/^log_errors = #{to_ini_value(php_ini['log_errors'])}$/) }
    its(:content) { should match(/^log_errors_max_len = #{to_ini_value(php_ini['log_errors_max_len'])}$/) }
    its(:content) { should match(/^ignore_repeated_errors = #{to_ini_value(php_ini['ignore_repeated_errors'])}$/) }
    its(:content) { should match(/^ignore_repeated_source = #{to_ini_value(php_ini['ignore_repeated_source'])}$/) }
    its(:content) { should match(/^report_memleaks = #{to_ini_value(php_ini['report_memleaks'])}$/) }
    if php_ini.key?('report_zend_debug')
      its(:content) { should match(/^report_zend_debug = #{to_ini_value(php_ini['report_zend_debug'])}$/) }
    end
    its(:content) { should match(/^track_errors = #{to_ini_value(php_ini['track_errors'])}$/) }
    if php_ini.key?('xmlrpc_errors')
      its(:content) { should match(/^xmlrpc_errors = #{to_ini_value(php_ini['xmlrpc_errors'])}$/) }
    end
    if php_ini.key?('xmlrpc_error_number')
      its(:content) { should match(/^xmlrpc_error_number = #{to_ini_value(php_ini['xmlrpc_error_number'])}$/) }
    end
    its(:content) { should match(/^html_errors = #{to_ini_value(php_ini['html_errors'])}$/) }
    if php_ini.key?('docref_root')
      its(:content) { should match(/^docref_root = #{to_ini_value(php_ini['docref_root'])}$/) }
    end
    if php_ini.key?('docref_ext')
      its(:content) { should match(/^docref_ext = #{to_ini_value(php_ini['docref_ext'])}$/) }
    end
    if php_ini.key?('error_prepend_string')
      its(:content) { should match(/^error_prepend_string = #{to_ini_value(php_ini['error_prepend_string'])}$/) }
    end
    if php_ini.key?('error_append_string')
      its(:content) { should match(/^error_append_string = #{to_ini_value(php_ini['error_append_string'])}$/) }
    end
    its(:content) { should match(/^error_log = #{to_ini_value(php_ini['error_log'])}$/) } if php_ini.key?('error_log')
    its(:content) { should match(/^variables_order = "#{to_ini_value(php_ini['variables_order'])}"$/) }
    its(:content) { should match(/^request_order = "#{to_ini_value(php_ini['request_order'])}"$/) }
    its(:content) { should match(/^register_argc_argv = #{to_ini_value(php_ini['register_argc_argv'])}$/) }
    its(:content) { should match(/^auto_globals_jit = #{to_ini_value(php_ini['auto_globals_jit'])}$/) }
    if php_ini.key?('enable_post_data_reading')
      enable_post_data_reading = to_ini_value(php_ini['enable_post_data_reading'])
      its(:content) { should match(/^enable_post_data_reading = #{enable_post_data_reading}$/) }
    end
    its(:content) { should match(/^post_max_size = #{to_ini_value(php_ini['post_max_size'])}$/) }
    its(:content) { should match(/^auto_prepend_file = #{to_ini_value(php_ini['auto_prepend_file'])}$/) }
    its(:content) { should match(/^auto_append_file = #{to_ini_value(php_ini['auto_append_file'])}$/) }
    its(:content) { should match(/^default_mimetype = "#{to_ini_value(php_ini['default_mimetype'])}"$/) }
    its(:content) { should match(/^default_charset = "#{to_ini_value(php_ini['default_charset'])}"$/) }
    if php_ini.key?('internal_encoding')
      its(:content) { should match(/^internal_encoding = #{to_ini_value(php_ini['internal_encoding'])}$/) }
    end
    if php_ini.key?('input_encoding')
      its(:content) { should match(/^input_encoding = #{to_ini_value(php_ini['input_encoding'])}$/) }
    end
    if php_ini.key?('output_encoding')
      its(:content) { should match(/^output_encoding = #{to_ini_value(php_ini['output_encoding'])}$/) }
    end
    if php_ini.key?('include_path')
      its(:content) { should match(/^include_path = #{to_ini_value(php_ini['include_path'])}$/) }
    end
    its(:content) { should match(/^doc_root = #{to_ini_value(php_ini['doc_root'])}$/) }
    its(:content) { should match(/^user_dir = #{to_ini_value(php_ini['user_dir'])}$/) }
    if php_ini.key?('extension_dir')
      its(:content) { should match(/^extension_dir = #{to_ini_value(php_ini['extension_dir'])}$/) }
    end
    if php_ini.key?('sys_temp_dir')
      its(:content) { should match(/^sys_temp_dir = #{to_ini_value(php_ini['sys_temp_dir'])}$/) }
    end
    its(:content) { should match(/^enable_dl = #{to_ini_value(php_ini['enable_dl'])}$/) }
    its(:content) { should match(/^file_uploads = #{to_ini_value(php_ini['file_uploads'])}$/) }
    if php_ini.key?('upload_tmp_dir')
      its(:content) { should match(/^upload_tmp_dir = #{to_ini_value(php_ini['upload_tmp_dir'])}$/) }
    end
    its(:content) { should match(/^upload_max_filesize = #{to_ini_value(php_ini['upload_max_filesize'])}$/) }
    its(:content) { should match(/^max_file_uploads = #{to_ini_value(php_ini['max_file_uploads'])}$/) }
    its(:content) { should match(/^allow_url_fopen = #{to_ini_value(php_ini['allow_url_fopen'])}$/) }
    its(:content) { should match(/^allow_url_include = #{to_ini_value(php_ini['allow_url_include'])}$/) }
    its(:content) { should match(/^from = #{to_ini_value(php_ini['from'])}$/) } if php_ini.key?('from')
    if php_ini.key?('user_agent')
      its(:content) { should match(/^user_agent = #{to_ini_value(php_ini['user_agent'])}$/) }
    end
    its(:content) { should match(/^default_socket_timeout = #{to_ini_value(php_ini['default_socket_timeout'])}$/) }
    if php_ini.key?('auto_detect_line_endings')
      auto_detect_line_endings = to_ini_value(php_ini['auto_detect_line_endings'])
      its(:content) { should match(/^auto_detect_line_endings = #{auto_detect_line_endings}$/) }
    end
    if php_ini.key?('sendmail_path')
      its(:content) { should match(/^sendmail_path = #{to_ini_value(php_ini['sendmail_path'])}$/) }
    end
    its(:content) { should match(/^browscap = #{to_ini_value(php_ini['browscap'])}$/) } if php_ini.key?('browscap')
    its(:content) { should match(/^cli_server.color = #{to_ini_value(php_ini['cli_server']['color'])}$/) }
    its(:content) { should match(/^url_rewriter.tags = "#{to_ini_value(php_ini['url_rewriter']['tags'])}"$/) }
    if php_ini['mail'].key?('force_extra_parameters')
      force_extra_parameters = to_ini_value(php_ini['mail']['force_extra_parameters'])
      its(:content) { should match(/^mail.force_extra_parameters = #{force_extra_parameters}$/) }
    end
    its(:content) { should match(/^mail.add_x_header = #{to_ini_value(php_ini['mail']['add_x_header'])}$/) }
    if php_ini['mail'].key?('log')
      its(:content) { should match(/^mail.log = #{to_ini_value(php_ini['mail']['log'])}$/) }
    end
    if php_ini.key?('arg_separator')
      if php_ini['arg_separator'].key?('output')
        its(:content) { should match(/^arg_separator.output = #{to_ini_value(php_ini['arg_separator']['output'])}$/) }
      end
      if php_ini['arg_separator'].key?('input')
        its(:content) { should match(/^arg_separator.input = #{to_ini_value(php_ini['arg_separator']['input'])}$/) }
      end
    end
    if php_ini.key?('birdstep') && php_ini['birdstep'].key?('max_links')
      its(:content) { should match(/^birdstep.max_links = #{to_ini_value(php_ini['birdstep']['max_links'])}$/) }
    end
    if php_ini.key?('highlight')
      ini_highlight = php_ini['highlight']
      if ini_highlight.key?('string')
        its(:content) { should match(/^highlight.string = #{to_ini_value(ini_highlight['string'])}$/) }
      end
      if ini_highlight.key?('comment')
        its(:content) { should match(/^highlight.comment = #{to_ini_value(ini_highlight['comment'])}$/) }
      end
      if ini_highlight.key?('keyword')
        its(:content) { should match(/^highlight.keyword = #{to_ini_value(ini_highlight['keyword'])}$/) }
      end
      if ini_highlight.key?('default')
        its(:content) { should match(/^highlight.default = #{to_ini_value(ini_highlight['default'])}$/) }
      end
      if ini_highlight.key?('html')
        its(:content) { should match(/^highlight.html = #{to_ini_value(ini_highlight['html'])}$/) }
      end
    end
    if php_ini.key?('sysvshm') && php_ini['sysvshm'].key?('init_mem')
      its(:content) { should match(/^sysvshm.init_mem = #{to_ini_value(php_ini['sysvshm']['init_mem'])}$/) }
    end
    # bcmath
    its(:content) { should match(/^bcmath.scale = #{to_ini_value(php_ini['bcmath']['scale'])}$/) }
    # curl
    if php_ini.key?('curl') && php_ini['curl'].key?('cainfo')
      its(:content) { should match(/^curl.cainfo = #{to_ini_value(php_ini['curl']['cainfo'])}$/) }
    end
    # Session
    its(:content) { should match(/^session.save_handler = #{to_ini_value(php_ini['session']['save_handler'])}$/) }
    if php_ini['session'].key?('save_path')
      its(:content) { should match(/^session.save_path = #{to_ini_value(php_ini['session']['save_path'])}$/) }
    end
    its(:content) { should match(/^session.use_strict_mode = #{to_ini_value(php_ini['session']['use_strict_mode'])}$/) }
    its(:content) { should match(/^session.use_cookies = #{to_ini_value(php_ini['session']['use_cookies'])}$/) }
    if php_ini['session'].key?('cookie_secure')
      its(:content) { should match(/^session.cookie_secure = #{to_ini_value(php_ini['session']['cookie_secure'])}$/) }
    end
    use_only_cookies = to_ini_value(php_ini['session']['use_only_cookies'])
    its(:content) { should match(/^session.use_only_cookies = #{use_only_cookies}$/) }
    its(:content) { should match(/^session.name = #{to_ini_value(php_ini['session']['name'])}$/) }
    its(:content) { should match(/^session.auto_start = #{to_ini_value(php_ini['session']['auto_start'])}$/) }
    its(:content) { should match(/^session.cookie_lifetime = #{to_ini_value(php_ini['session']['cookie_lifetime'])}$/) }
    its(:content) { should match(/^session.cookie_path = #{to_ini_value(php_ini['session']['cookie_path'])}$/) }
    its(:content) { should match(/^session.cookie_domain = #{to_ini_value(php_ini['session']['cookie_domain'])}$/) }
    its(:content) { should match(/^session.cookie_httponly = #{to_ini_value(php_ini['session']['cookie_httponly'])}$/) }

    serialize_handler = to_ini_value(php_ini['session']['serialize_handler'])
    its(:content) { should match(/^session.serialize_handler = #{serialize_handler}$/) }

    its(:content) { should match(/^session.gc_probability = #{to_ini_value(php_ini['session']['gc_probability'])}$/) }
    its(:content) { should match(/^session.gc_divisor = #{to_ini_value(php_ini['session']['gc_divisor'])}$/) }
    its(:content) { should match(/^session.gc_maxlifetime = #{to_ini_value(php_ini['session']['gc_maxlifetime'])}$/) }
    its(:content) { should match(/^session.referer_check = #{to_ini_value(php_ini['session']['referer_check'])}$/) }
    if php_ini['session'].key?('entropy_length')
      its(:content) { should match(/^session.entropy_length = #{to_ini_value(php_ini['session']['entropy_length'])}$/) }
    end
    if php_ini['session'].key?('entropy_file')
      its(:content) { should match(/^session.entropy_file = #{to_ini_value(php_ini['session']['entropy_file'])}$/) }
    end
    its(:content) { should match(/^session.cache_limiter = #{to_ini_value(php_ini['session']['cache_limiter'])}$/) }
    its(:content) { should match(/^session.cache_expire = #{to_ini_value(php_ini['session']['cache_expire'])}$/) }
    its(:content) { should match(/^session.use_trans_sid = #{to_ini_value(php_ini['session']['use_trans_sid'])}$/) }
    its(:content) { should match(/^session.hash_function = #{to_ini_value(php_ini['session']['hash_function'])}$/) }

    hash_bits_per_character = to_ini_value(php_ini['session']['hash_bits_per_character'])
    its(:content) { should match(/^session.hash_bits_per_character = #{hash_bits_per_character}$/) }

    if php_ini['session'].key?('upload_progress')
      ini_up_progress = php_ini['session']['upload_progress']
      if ini_up_progress.key?('enabled')
        up_progress_enabled = to_ini_value(ini_up_progress['enabled'])
        its(:content) { should match(/^session.upload_progress.enabled = #{up_progress_enabled}$/) }
      end
      if ini_up_progress.key?('cleanup')
        up_progress_cleanup = to_ini_value(ini_up_progress['cleanup'])
        its(:content) { should match(/^session.upload_progress.cleanup = #{up_progress_cleanup}$/) }
      end
      if ini_up_progress.key?('prefix')
        up_progress_prefix = to_ini_value(ini_up_progress['prefix'])
        its(:content) { should match(/^session.upload_progress.prefix = #{up_progress_prefix}$/) }
      end
      if ini_up_progress.key?('name')
        its(:content) { should match(/^session.upload_progress.name = #{to_ini_value(ini_up_progress['name'])}$/) }
      end
      if ini_up_progress.key?('freq')
        its(:content) { should match(/^session.upload_progress.freq = #{to_ini_value(ini_up_progress['freq'])}$/) }
      end
      if ini_up_progress.key?('min_freq')
        min_freq = to_ini_value(ini_up_progress['min_freq'])
        its(:content) { should match(/^session.upload_progress.min_freq = #{min_freq}$/) }
      end
    end
    if php_ini['session'].key?('lazy_write')
      its(:content) { should match(/^session.lazy_write = #{to_ini_value(php_ini['session']['lazy_write'])}$/) }
    end
    its(:content) { should match(/^sql.safe_mode = #{to_ini_value(php_ini['sql']['safe_mode'])}$/) }
    # Date
    its(:content) { should match(/^date.timezone = #{to_ini_value(php_ini['date']['timezone'])}$/) }
    if php_ini['date'].key?('default_latitude')
      its(:content) { should match(/^date.default_latitude = #{to_ini_value(php_ini['date']['default_latitude'])}$/) }
    end
    if php_ini['date'].key?('default_longitude')
      its(:content) { should match(/^date.default_longitude = #{to_ini_value(php_ini['date']['default_longitude'])}$/) }
    end
    if php_ini['date'].key?('sunrise_zenith')
      its(:content) { should match(/^date.sunrise_zenith = #{to_ini_value(php_ini['date']['sunrise_zenith'])}$/) }
    end
    if php_ini['date'].key?('sunset_zenith')
      its(:content) { should match(/^date.sunset_zenith = #{to_ini_value(php_ini['date']['sunset_zenith'])}$/) }
    end
    # zend
    its(:content) { should match(/^zend.enable_gc = #{to_ini_value(php_ini['zend']['enable_gc'])}$/) }
    if php_ini['zend'].key?('multibyte')
      its(:content) { should match(/^zend.multibyte = #{to_ini_value(php_ini['zend']['multibyte'])}$/) }
    end
    if php_ini['zend'].key?('script_encoding')
      its(:content) { should match(/^zend.script_encoding = #{to_ini_value(php_ini['zend']['script_encoding'])}$/) }
    end
    its(:content) { should match(/^zend.assertions = #{to_ini_value(php_ini['zend']['assertions'])}$/) }
    # DBA
    if php_ini.key?('dba') && php_ini['dba'].key?('default_handler')
      its(:content) { should match(/^dba.default_handler = #{to_ini_value(php_ini['dba']['default_handler'])}$/) }
    end
    # CGI
    if php_ini.key?('cgi')
      ini_cgi = php_ini['cgi']
      if ini_cgi.key?('force_redirect')
        its(:content) { should match(/^cgi.force_redirect = #{to_ini_value(ini_cgi['force_redirect'])}$/) }
      end
      its(:content) { should match(/^cgi.nph = #{to_ini_value(ini_cgi['nph'])}$/) } if ini_cgi.key?('nph')
      if ini_cgi.key?('redirect_status_env')
        its(:content) { should match(/^cgi.redirect_status_env = #{to_ini_value(ini_cgi['redirect_status_env'])}$/) }
      end
      if ini_cgi.key?('fix_pathinfo')
        its(:content) { should match(/^cgi.fix_pathinfo = #{to_ini_value(ini_cgi['fix_pathinfo'])}$/) }
      end
      if ini_cgi.key?('discard_path')
        its(:content) { should match(/^cgi.discard_path = #{to_ini_value(ini_cgi['discard_path'])}$/) }
      end
      if ini_cgi.key?('rfc2616_headers')
        its(:content) { should match(/^cgi.rfc2616_headers = #{to_ini_value(ini_cgi['rfc2616_headers'])}$/) }
      end
      if ini_cgi.key?('check_shebang_line')
        its(:content) { should match(/^cgi.check_shebang_line = #{to_ini_value(ini_cgi['check_shebang_line'])}$/) }
      end
    end
    # fastcgi
    if php_ini.key?('fastcgi')
      if php_ini['fastcgi'].key?('impersonate')
        its(:content) { should match(/^fastcgi.impersonate = #{to_ini_value(php_ini['fastcgi']['impersonate'])}$/) }
      end
      if php_ini['fastcgi'].key?('logging')
        its(:content) { should match(/^fastcgi.logging = #{to_ini_value(php_ini['fastcgi']['logging'])}$/) }
      end
    end
    # ibase
    ini_ibase = php_ini['ibase']
    its(:content) { should match(/^ibase.allow_persistent = #{to_ini_value(ini_ibase['allow_persistent'])}$/) }
    its(:content) { should match(/^ibase.max_persistent = #{to_ini_value(ini_ibase['max_persistent'])}$/) }
    its(:content) { should match(/^ibase.max_links = #{to_ini_value(ini_ibase['max_links'])}$/) }
    if ini_ibase.key?('default_db')
      its(:content) { should match(/^ibase.default_db = #{to_ini_value(ini_ibase['default_db'])}$/) }
    end
    if ini_ibase.key?('default_user')
      its(:content) { should match(/^ibase.default_user = #{to_ini_value(ini_ibase['default_user'])}$/) }
    end
    if ini_ibase.key?('default_password')
      its(:content) { should match(/^ibase.default_password = #{to_ini_value(ini_ibase['default_password'])}$/) }
    end
    if ini_ibase.key?('default_charset')
      its(:content) { should match(/^ibase.default_charset = #{to_ini_value(ini_ibase['default_charset'])}$/) }
    end
    its(:content) { should match(/^ibase.timestampformat = "#{to_ini_value(ini_ibase['timestampformat'])}"$/) }
    its(:content) { should match(/^ibase.dateformat = "#{to_ini_value(ini_ibase['dateformat'])}"$/) }
    its(:content) { should match(/^ibase.timeformat = "#{to_ini_value(ini_ibase['timeformat'])}"$/) }
    # ODBC
    ini_odbc = php_ini['odbc']
    if ini_odbc.key?('default_db')
      its(:content) { should match(/^odbc.default_db = #{to_ini_value(ini_odbc['default_db'])}$/) }
    end
    if ini_odbc.key?('default_user')
      its(:content) { should match(/^odbc.default_user = #{to_ini_value(ini_odbc['default_user'])}$/) }
    end
    if ini_odbc.key?('default_pw')
      its(:content) { should match(/^odbc.default_pw = #{to_ini_value(ini_odbc['default_pw'])}$/) }
    end
    if ini_odbc.key?('default_cursortype')
      its(:content) { should match(/^odbc.default_cursortype = #{to_ini_value(ini_odbc['default_cursortype'])}$/) }
    end
    its(:content) { should match(/^odbc.allow_persistent = #{to_ini_value(ini_odbc['allow_persistent'])}$/) }
    its(:content) { should match(/^odbc.check_persistent = #{to_ini_value(ini_odbc['check_persistent'])}$/) }
    its(:content) { should match(/^odbc.max_persistent = #{to_ini_value(ini_odbc['max_persistent'])}$/) }
    its(:content) { should match(/^odbc.max_links = #{to_ini_value(ini_odbc['max_links'])}$/) }
    its(:content) { should match(/^odbc.defaultlrl = #{to_ini_value(ini_odbc['defaultlrl'])}$/) }
    its(:content) { should match(/^odbc.defaultbinmode = #{to_ini_value(ini_odbc['defaultbinmode'])}$/) }
    # OpenSSL
    if php_ini.key?('openssl')
      if php_ini['openssl'].key?('cafile')
        its(:content) { should match(/^openssl.cafile = #{to_ini_value(php_ini['openssl']['cafile'])}$/) }
      end
      if php_ini['openssl'].key?('capath')
        its(:content) { should match(/^openssl.capath = #{to_ini_value(php_ini['openssl']['capath'])}$/) }
      end
    end
    # PDO(MySQL)
    its(:content) { should match(/^pdo_mysql.cache_size = #{to_ini_value(php_ini['pdo_mysql']['cache_size'])}$/) }
    pdo_mysql_default_socket = to_ini_value(php_ini['pdo_mysql']['default_socket'])
    its(:content) { should match(/^pdo_mysql.default_socket = #{pdo_mysql_default_socket}$/) }
    # PDO(ODBC)
    if php_ini.key?('pdo_odbc')
      ini_pdo_odbc = php_ini['pdo_odbc']
      if ini_pdo_odbc.key?('connection_pooling')
        connection_pooling = to_ini_value(ini_pdo_odbc['connection_pooling'])
        its(:content) { should match(/^pdo_odbc.connection_pooling = #{connection_pooling}$/) }
      end
      if ini_pdo_odbc.key?('db2_instance_name')
        db2_instance_name = to_ini_value(ini_pdo_odbc['db2_instance_name'])
        its(:content) { should match(/^pdo_odbc.db2_instance_name = #{db2_instance_name}$/) }
      end
    end
    # PCRE
    if php_ini.key?('pcre')
      ini_pcre = php_ini['pcre']
      if ini_pcre.key?('backtrack_limit')
        its(:content) { should match(/^pcre.backtrack_limit = #{to_ini_value(ini_pcre['backtrack_limit'])}$/) }
      end
      if ini_pcre.key?('recursion_limit')
        its(:content) { should match(/^pcre.recursion_limit = #{to_ini_value(ini_pcre['recursion_limit'])}$/) }
      end
      its(:content) { should match(/^pcre.jit = #{to_ini_value(ini_pcre['jit'])}$/) } if ini_pcre.key?('jit')
    end
    # Phar
    if php_ini.key?('phar')
      ini_phar = php_ini['phar']
      if ini_phar.key?('readonly')
        its(:content) { should match(/^phar.readonly = #{to_ini_value(ini_phar['readonly'])}$/) }
      end
      if ini_phar.key?('require_hash')
        its(:content) { should match(/^phar.require_hash = #{to_ini_value(ini_phar['require_hash'])}$/) }
      end
      if ini_phar.key?('cache_list')
        its(:content) { should match(/^phar.cache_list = #{to_ini_value(ini_phar['cache_list'])}$/) }
      end
    end
    # zlib
    its(:content) { should match(/^zlib.output_compression = #{to_ini_value(php_ini['zlib']['output_compression'])}$/) }
    if php_ini['zlib'].key?('output_compression_level')
      output_compression_level = to_ini_value(php_ini['zlib']['output_compression_level'])
      its(:content) { should match(/^zlib.output_compression_level = #{output_compression_level}$/) }
    end
    if php_ini['zlib'].key?('output_handler')
      its(:content) { should match(/^zlib.output_handler = #{to_ini_value(php_ini['zlib']['output_handler'])}$/) }
    end
    # SQLite3
    if php_ini.key?('sqlite3') && php_ini['sqlite3'].key?('extension_dir')
      its(:content) { should match(/^sqlite3.extension_dir = #{to_ini_value(php_ini['sqlite3']['extension_dir'])}$/) }
    end
    # intl
    if php_ini.key?('intl')
      ini_intl = php_ini['intl']
      if ini_intl.key?('default_locale')
        its(:content) { should match(/^intl.default_locale = #{to_ini_value(ini_intl['default_locale'])}$/) }
      end
      if ini_intl.key?('error_level')
        its(:content) { should match(/^intl.error_level = #{to_ini_value(ini_intl['error_level'])}$/) }
      end
      if ini_intl.key?('use_exceptions')
        its(:content) { should match(/^intl.use_exceptions = #{to_ini_value(ini_intl['use_exceptions'])}$/) }
      end
    end
    # MySQLi
    its(:content) { should match(/^mysqli.max_persistent = #{to_ini_value(php_ini['mysqli']['max_persistent'])}$/) }
    if php_ini['mysqli'].key?('allow_local_infile')
      allow_local_infile = to_ini_value(php_ini['mysqli']['allow_local_infile'])
      its(:content) { should match(/^mysqli.allow_local_infile = #{allow_local_infile}$/) }
    end
    its(:content) { should match(/^mysqli.allow_persistent = #{to_ini_value(php_ini['mysqli']['allow_persistent'])}$/) }
    its(:content) { should match(/^mysqli.max_links = #{to_ini_value(php_ini['mysqli']['max_links'])}$/) }
    its(:content) { should match(/^mysqli.cache_size = #{to_ini_value(php_ini['mysqli']['cache_size'])}$/) }
    its(:content) { should match(/^mysqli.default_port = #{to_ini_value(php_ini['mysqli']['default_port'])}$/) }
    its(:content) { should match(/^mysqli.default_socket = #{to_ini_value(php_ini['mysqli']['default_socket'])}$/) }
    its(:content) { should match(/^mysqli.default_host = #{to_ini_value(php_ini['mysqli']['default_host'])}$/) }
    its(:content) { should match(/^mysqli.default_user = #{to_ini_value(php_ini['mysqli']['default_user'])}$/) }
    its(:content) { should match(/^mysqli.default_pw = #{to_ini_value(php_ini['mysqli']['default_pw'])}$/) }
    its(:content) { should match(/^mysqli.reconnect = #{to_ini_value(php_ini['mysqli']['reconnect'])}$/) }
    # MySQL Native Driver
    ini_mysqlnd = php_ini['mysqlnd']
    its(:content) { should match(/^mysqlnd.collect_statistics = #{to_ini_value(ini_mysqlnd['collect_statistics'])}$/) }
    collect_memory_statistics = to_ini_value(ini_mysqlnd['collect_memory_statistics'])
    its(:content) { should match(/^mysqlnd.collect_memory_statistics = #{collect_memory_statistics}$/) }
    if ini_mysqlnd.key?('debug')
      its(:content) { should match(/^mysqlnd.debug = #{to_ini_value(ini_mysqlnd['debug'])}$/) }
    end
    if ini_mysqlnd.key?('log_mask')
      its(:content) { should match(/^mysqlnd.log_mask = #{to_ini_value(ini_mysqlnd['log_mask'])}$/) }
    end
    if ini_mysqlnd.key?('mempool_default_size')
      mempool_default_size = to_ini_value(ini_mysqlnd['mempool_default_size'])
      its(:content) { should match(/^mysqlnd.mempool_default_size = #{mempool_default_size}$/) }
    end
    if ini_mysqlnd.key?('net_cmd_buffer_size')
      net_cmd_buffer_size = to_ini_value(ini_mysqlnd['net_cmd_buffer_size'])
      its(:content) { should match(/^mysqlnd.net_cmd_buffer_size = #{net_cmd_buffer_size}$/) }
    end
    if ini_mysqlnd.key?('net_read_buffer_size')
      net_read_buffer_size = to_ini_value(ini_mysqlnd['net_read_buffer_size'])
      its(:content) { should match(/^mysqlnd.net_read_buffer_size = #{net_read_buffer_size}$/) }
    end
    if ini_mysqlnd.key?('net_read_timeout')
      its(:content) { should match(/^mysqlnd.net_read_timeout = #{to_ini_value(ini_mysqlnd['net_read_timeout'])}$/) }
    end
    if ini_mysqlnd.key?('sha256_server_public_key')
      sha256_server_public_key = to_ini_value(ini_mysqlnd['sha256_server_public_key'])
      its(:content) { should match(/^mysqlnd.sha256_server_public_key = #{sha256_server_public_key}$/) }
    end

    # mcrypt
    if php_ini.key?('mcrypt')
      ini_mcrypt = php_ini['mcrypt']
      if ini_mcrypt.key?('algorithms_dir')
        its(:content) { should match(/^mcrypt.algorithms_dir = #{to_ini_value(ini_mcrypt['algorithms_dir'])}$/) }
      end
      if ini_mcrypt.key?('modes_dir')
        its(:content) { should match(/^mcrypt.modes_dir = #{to_ini_value(ini_mcrypt['modes_dir'])}$/) }
      end
    end
    # filter
    if php_ini.key?('filter')
      ini_filter = php_ini['filter']
      if ini_filter.key?('default')
        its(:content) { should match(/^filter.default = #{to_ini_value(ini_filter['default'])}$/) }
      end
      if ini_filter.key?('default_flags')
        its(:content) { should match(/^filter.default_flags = #{to_ini_value(ini_filter['default_flags'])}$/) }
      end
    end
    # pgsql
    its(:content) { should match(/^pgsql.allow_persistent = #{to_ini_value(php_ini['pgsql']['allow_persistent'])}$/) }
    auto_reset_persistent = to_ini_value(php_ini['pgsql']['auto_reset_persistent'])
    its(:content) { should match(/^pgsql.auto_reset_persistent = #{auto_reset_persistent}$/) }
    its(:content) { should match(/^pgsql.max_persistent = #{to_ini_value(php_ini['pgsql']['max_persistent'])}$/) }
    its(:content) { should match(/^pgsql.max_links = #{to_ini_value(php_ini['pgsql']['max_links'])}$/) }
    its(:content) { should match(/^pgsql.ignore_notice = #{to_ini_value(php_ini['pgsql']['ignore_notice'])}$/) }
    its(:content) { should match(/^pgsql.log_notice = #{to_ini_value(php_ini['pgsql']['log_notice'])}$/) }
    # GD
    if php_ini.key?('gd') && php_ini['gd'].key?('jpeg_ignore_warning')
      its(:content) { should match(/^gd.jpeg_ignore_warning = #{to_ini_value(php_ini['gd']['jpeg_ignore_warning'])}$/) }
    end
    # exif
    if php_ini.key?('exif')
      ini_exif = php_ini['exif']
      if ini_exif.key?('encode_unicode')
        its(:content) { should match(/^exif.encode_unicode = #{to_ini_value(ini_exif['encode_unicode'])}$/) }
      end
      if ini_exif.key?('decode_unicode_motorola')
        decode_unicode_motorola = to_ini_value(ini_exif['decode_unicode_motorola'])
        its(:content) { should match(/^exif.decode_unicode_motorola = #{decode_unicode_motorola}$/) }
      end
      if ini_exif.key?('decode_unicode_intel')
        decode_unicode_intel = to_ini_value(ini_exif['decode_unicode_intel'])
        its(:content) { should match(/^exif.decode_unicode_intel = #{decode_unicode_intel}$/) }
      end
      if ini_exif.key?('encode_jis')
        its(:content) { should match(/^exif.encode_jis = #{to_ini_value(ini_exif['encode_jis'])}$/) }
      end
      if ini_exif.key?('decode_jis_motorola')
        its(:content) { should match(/^exif.decode_jis_motorola = #{to_ini_value(ini_exif['decode_jis_motorola'])}$/) }
      end
      if ini_exif.key?('decode_jis_intel')
        its(:content) { should match(/^exif.decode_jis_intel = #{to_ini_value(ini_exif['decode_jis_intel'])}$/) }
      end
    end
    # tidy
    if php_ini['tidy'].key?('default_config')
      its(:content) { should match(/^tidy.default_config = #{to_ini_value(php_ini['tidy']['default_config'])}$/) }
    end
    its(:content) { should match(/^tidy.clean_output = #{to_ini_value(php_ini['tidy']['clean_output'])}$/) }
    # iconv
    if php_ini.key?('iconv')
      ini_iconv = php_ini['iconv']
      if ini_iconv.key?('input_encoding')
        its(:content) { should match(/^iconv.input_encoding = #{to_ini_value(ini_iconv['input_encoding'])}$/) }
      end
      if ini_iconv.key?('internal_encoding')
        its(:content) { should match(/^iconv.internal_encoding = #{to_ini_value(ini_iconv['internal_encoding'])}$/) }
      end
      if ini_iconv.key?('output_encoding')
        its(:content) { should match(/^iconv.output_encoding = #{to_ini_value(ini_iconv['output_encoding'])}$/) }
      end
    end
    # imagick
    if php_ini.key?('imagick')
      ini_imagick = php_ini['imagick']
      if ini_imagick.key?('locale_fix')
        locale_fix = to_ini_value(ini_imagick['locale_fix'])
        its(:content) { should match(/^extra_parameters.imagick.locale_fix = #{locale_fix}$/) }
      end
      if ini_imagick.key?('progress_monitor')
        progress_monitor = to_ini_value(ini_imagick['progress_monitor'])
        its(:content) { should match(/^extra_parameters.imagick.progress_monitor = #{progress_monitor}$/) }
      end
      if ini_imagick.key?('skip_version_check')
        skip_version_check = to_ini_value(ini_imagick['skip_version_check'])
        its(:content) { should match(/^extra_parameters.imagick.skip_version_check = #{skip_version_check}$/) }
      end
    end
    # mbstring
    if php_ini.key?('mbstring')
      ini_mbstring = php_ini['mbstring']
      if ini_mbstring.key?('language')
        its(:content) { should match(/^mbstring.language = #{to_ini_value(ini_mbstring['language'])}$/) }
      end
      if ini_mbstring.key?('internal_encoding')
        internal_encoding = to_ini_value(ini_mbstring['internal_encoding'])
        its(:content) { should match(/^mbstring.internal_encoding = #{internal_encoding}$/) }
      end
      if ini_mbstring.key?('http_input')
        its(:content) { should match(/^mbstring.http_input = #{to_ini_value(ini_mbstring['http_input'])}$/) }
      end
      if ini_mbstring.key?('http_output')
        its(:content) { should match(/^mbstring.http_output = #{to_ini_value(ini_mbstring['http_output'])}$/) }
      end
      if ini_mbstring.key?('encoding_translation')
        encoding_translation = to_ini_value(ini_mbstring['encoding_translation'])
        its(:content) { should match(/^mbstring.encoding_translation = #{encoding_translation}$/) }
      end
      if ini_mbstring.key?('detect_order')
        its(:content) { should match(/^mbstring.detect_order = #{to_ini_value(ini_mbstring['detect_order'])}$/) }
      end
      if ini_mbstring.key?('substitute_character')
        substitute_character = to_ini_value(ini_mbstring['substitute_character'])
        its(:content) { should match(/^mbstring.substitute_character = #{substitute_character}$/) }
      end
      if ini_mbstring.key?('func_overload')
        its(:content) { should match(/^mbstring.func_overload = #{to_ini_value(ini_mbstring['func_overload'])}$/) }
      end
      if ini_mbstring.key?('strict_detection')
        strict_detection = to_ini_value(ini_mbstring['strict_detection'])
        its(:content) { should match(/^mbstring.strict_detection = #{strict_detection}$/) }
      end
      if ini_mbstring.key?('http_output_conv_mimetype')
        http_output_conv_mimetype = to_ini_value(ini_mbstring['http_output_conv_mimetype'])
        its(:content) { should match(/^mbstring.http_output_conv_mimetype = #{http_output_conv_mimetype}$/) }
      end
    end
    # soap
    its(:content) { should match(/^soap.wsdl_cache_enabled = #{to_ini_value(php_ini['soap']['wsdl_cache_enabled'])}$/) }
    its(:content) { should match(/^soap.wsdl_cache_dir = "#{to_ini_value(php_ini['soap']['wsdl_cache_dir'])}"$/) }
    its(:content) { should match(/^soap.wsdl_cache_ttl = #{to_ini_value(php_ini['soap']['wsdl_cache_ttl'])}$/) }
    its(:content) { should match(/^soap.wsdl_cache_limit = #{to_ini_value(php_ini['soap']['wsdl_cache_limit'])}$/) }
    # LDAP
    its(:content) { should match(/^ldap.max_links = #{to_ini_value(php_ini['ldap']['max_links'])}$/) }
    # Assert
    if php_ini.key?('assert')
      ini_assert = php_ini['assert']
      if ini_assert.key?('active')
        its(:content) { should match(/^assert.active = #{to_ini_value(ini_assert['active'])}$/) }
      end
      if ini_assert.key?('exception')
        its(:content) { should match(/^assert.exception = #{to_ini_value(ini_assert['exception'])}$/) }
      end
      if ini_assert.key?('warning')
        its(:content) { should match(/^assert.warning = #{to_ini_value(ini_assert['warning'])}$/) }
      end
      its(:content) { should match(/^assert.bail = #{to_ini_value(ini_assert['bail'])}$/) } if ini_assert.key?('bail')
      if ini_assert.key?('callback')
        its(:content) { should match(/^assert.callback = #{to_ini_value(ini_assert['callback'])}$/) }
      end
      if ini_assert.key?('quiet_eval')
        its(:content) { should match(/^assert.quiet_eval = #{to_ini_value(ini_assert['quiet_eval'])}$/) }
      end
    end
    # oci8
    if php_ini.key?('oci8')
      ini_oci8 = php_ini['oci8']
      if ini_oci8.key?('privileged_connect')
        its(:content) { should match(/^oci8.privileged_connect = #{to_ini_value(ini_oci8['privileged_connect'])}$/) }
      end
      if ini_oci8.key?('max_persistent')
        its(:content) { should match(/^oci8.max_persistent = #{to_ini_value(ini_oci8['max_persistent'])}$/) }
      end
      if ini_oci8.key?('persistent_timeout')
        its(:content) { should match(/^oci8.persistent_timeout = #{to_ini_value(ini_oci8['persistent_timeout'])}$/) }
      end
      if ini_oci8.key?('ping_interval')
        its(:content) { should match(/^oci8.ping_interval = #{to_ini_value(ini_oci8['ping_interval'])}$/) }
      end
      if ini_oci8.key?('connection_class')
        its(:content) { should match(/^oci8.connection_class = #{to_ini_value(ini_oci8['connection_class'])}$/) }
      end
      its(:content) { should match(/^oci8.events = #{to_ini_value(ini_oci8['events'])}$/) } if ini_oci8.key?('events')
      if ini_oci8.key?('statement_cache_size')
        statement_cache_size = to_ini_value(ini_oci8['statement_cache_size'])
        its(:content) { should match(/^oci8.statement_cache_size = #{statement_cache_size}$/) }
      end
      if ini_oci8.key?('default_prefetch')
        its(:content) { should match(/^oci8.default_prefetch = #{to_ini_value(ini_oci8['default_prefetch'])}$/) }
      end
      if ini_oci8.key?('old_oci_close_semantics')
        old_oci_close_semantics = to_ini_value(ini_oci8['old_oci_close_semantics'])
        its(:content) { should match(/^oci8.old_oci_close_semantics = #{old_oci_close_semantics}$/) }
      end
    end
    # Opcache
    if php_ini.key?('opcache')
      ini_opcache = php_ini['opcache']
      if ini_opcache.key?('enable')
        its(:content) { should match(/^opcache.enable = #{to_ini_value(ini_opcache['enable'])}$/) }
      end
      if ini_opcache.key?('enable_cli')
        its(:content) { should match(/^opcache.enable_cli = #{to_ini_value(ini_opcache['enable_cli'])}$/) }
      end
      if ini_opcache.key?('memory_consumption')
        memory_consumption = to_ini_value(ini_opcache['memory_consumption'])
        its(:content) { should match(/^opcache.memory_consumption = #{memory_consumption}$/) }
      end
      if ini_opcache.key?('interned_strings_buffer')
        interned_strings_buffer = to_ini_value(ini_opcache['interned_strings_buffer'])
        its(:content) { should match(/^opcache.interned_strings_buffer = #{interned_strings_buffer}$/) }
      end
      if ini_opcache.key?('max_accelerated_files')
        max_accelerated_files = to_ini_value(ini_opcache['max_accelerated_files'])
        its(:content) { should match(/^opcache.max_accelerated_files = #{max_accelerated_files}$/) }
      end
      if ini_opcache.key?('max_wasted_percentage')
        max_wasted_percentage = to_ini_value(ini_opcache['max_wasted_percentage'])
        its(:content) { should match(/^opcache.max_wasted_percentage = #{max_wasted_percentage}$/) }
      end
      if ini_opcache.key?('use_cwd')
        its(:content) { should match(/^opcache.use_cwd = #{to_ini_value(ini_opcache['use_cwd'])}$/) }
      end
      if ini_opcache.key?('validate_timestamps')
        validate_timestamps = to_ini_value(ini_opcache['validate_timestamps'])
        its(:content) { should match(/^opcache.validate_timestamps = #{validate_timestamps}$/) }
      end
      if ini_opcache.key?('revalidate_freq')
        its(:content) { should match(/^opcache.revalidate_freq = #{to_ini_value(ini_opcache['revalidate_freq'])}$/) }
      end
      if ini_opcache.key?('revalidate_path')
        its(:content) { should match(/^opcache.revalidate_path = #{to_ini_value(ini_opcache['revalidate_path'])}$/) }
      end
      if ini_opcache.key?('save_comments')
        its(:content) { should match(/^opcache.save_comments = #{to_ini_value(ini_opcache['save_comments'])}$/) }
      end
      if ini_opcache.key?('fast_shutdown')
        its(:content) { should match(/^opcache.fast_shutdown = #{to_ini_value(ini_opcache['fast_shutdown'])}$/) }
      end
      if ini_opcache.key?('enable_file_override')
        enable_file_override = to_ini_value(ini_opcache['enable_file_override'])
        its(:content) { should match(/^opcache.enable_file_override = #{enable_file_override}$/) }
      end
      if ini_opcache.key?('optimization_level')
        optimization_level = to_ini_value(ini_opcache['optimization_level'])
        its(:content) { should match(/^opcache.optimization_level = #{optimization_level}$/) }
      end
      if ini_opcache.key?('inherited_hack')
        inherited_hack = to_ini_value(ini_opcache['inherited_hack'])
        its(:content) { should match(/^opcache.inherited_hack = #{inherited_hack}$/) }
      end
      if ini_opcache.key?('dups_fix')
        its(:content) { should match(/^opcache.dups_fix = #{to_ini_value(ini_opcache['dups_fix'])}$/) }
      end
      if ini_opcache.key?('blacklist_filename')
        blacklist_filename = to_ini_value(ini_opcache['blacklist_filename'])
        its(:content) { should match(/^opcache.blacklist_filename = #{blacklist_filename}$/) }
      end
      if ini_opcache.key?('max_file_size')
        max_file_size = to_ini_value(ini_opcache['max_file_size'])
        its(:content) { should match(/^opcache.max_file_size = #{max_file_size}$/) }
      end
      if ini_opcache.key?('consistency_checks')
        consistency_checks = to_ini_value(ini_opcache['consistency_checks'])
        its(:content) { should match(/^opcache.consistency_checks = #{consistency_checks}$/) }
      end
      if ini_opcache.key?('force_restart_timeout')
        force_restart_timeout = to_ini_value(ini_opcache['force_restart_timeout'])
        its(:content) { should match(/^opcache.force_restart_timeout = #{force_restart_timeout}$/) }
      end
      if ini_opcache.key?('error_log')
        its(:content) { should match(/^opcache.error_log = #{to_ini_value(ini_opcache['error_log'])}$/) }
      end
      if ini_opcache.key?('log_verbosity_level')
        log_verbosity_level = to_ini_value(ini_opcache['log_verbosity_level'])
        its(:content) { should match(/^opcache.log_verbosity_level = #{log_verbosity_level}$/) }
      end
      if ini_opcache.key?('preferred_memory_model')
        preferred_memory_model = to_ini_value(ini_opcache['preferred_memory_model'])
        its(:content) { should match(/^opcache.preferred_memory_model = #{preferred_memory_model}$/) }
      end
      if ini_opcache.key?('protect_memory')
        protect_memory = to_ini_value(ini_opcache['protect_memory'])
        its(:content) { should match(/^opcache.protect_memory = #{protect_memory}$/) }
      end
      if ini_opcache.key?('file_update_protection')
        file_update_protection = to_ini_value(ini_opcache['file_update_protection'])
        its(:content) { should match(/^opcache.file_update_protection = #{file_update_protection}$/) }
      end
      if ini_opcache.key?('restrict_api')
        its(:content) { should match(/^opcache.restrict_api = #{to_ini_value(ini_opcache['restrict_api'])}$/) }
      end
      if ini_opcache.key?('mmap_base')
        its(:content) { should match(/^opcache.mmap_base = #{to_ini_value(ini_opcache['mmap_base'])}$/) }
      end
      if ini_opcache.key?('file_cache')
        its(:content) { should match(/^opcache.file_cache = #{to_ini_value(ini_opcache['file_cache'])}$/) }
      end
      if ini_opcache.key?('file_cache_only')
        file_cache_only = to_ini_value(ini_opcache['file_cache_only'])
        its(:content) { should match(/^opcache.file_cache_only = #{file_cache_only}$/) }
      end
      if ini_opcache.key?('file_cache_consistency_checks')
        file_cache_consistency_checks = to_ini_value(ini_opcache['file_cache_consistency_checks'])
        its(:content) { should match(/^opcache.file_cache_consistency_checks = #{file_cache_consistency_checks}$/) }
      end
      if ini_opcache.key?('file_cache_fallback')
        file_cache_fallback = to_ini_value(ini_opcache['file_cache_fallback'])
        its(:content) { should match(/^opcache.file_cache_fallback = #{file_cache_fallback}$/) }
      end
      if ini_opcache.key?('huge_code_pages')
        huge_code_pages = to_ini_value(ini_opcache['huge_code_pages'])
        its(:content) { should match(/^opcache.huge_code_pages = #{huge_code_pages}$/) }
      end
      if ini_opcache.key?('validate_permission')
        validate_permission = to_ini_value(ini_opcache['validate_permission'])
        its(:content) { should match(/^opcache.validate_permission = #{validate_permission}$/) }
      end
      if ini_opcache.key?('validate_root')
        validate_root = to_ini_value(ini_opcache['validate_root'])
        its(:content) { should match(/^opcache.validate_root = #{validate_root}$/) }
      end
    end
  end
end
