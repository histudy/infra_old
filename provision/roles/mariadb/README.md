mariadb
=========

MariaDBのインストールとセットアップを行います。

Role Variables
--------------

### mariadb_packages

インストールするMariaDBのパッケージを指定します。

```yml
mariadb_packages:
  - mariadb-client
  - mariadb-server
  - mysqltuner
```

### mariadb_databases

追加/削除するデータベースを指定します。  
また、データベースの作成と同時にそのデータベース用のユーザー情報も同時に設定することができます。

```yml
mariadb_databases:
  - name: sample
    state: yes
    # 文字コード(オプション)
    encoding: utf8mb4
    # 照合順序(オプション)
    collation: utf8mb4_general_ci
    # インポートするデータ(オプション)
    import_data: /tmp/sample.sql.bz2
    # stateがno似設定されていた場合、
    # 同名のデータベースが存在する場合は削除されます
    state: yes
  # データベースの作成とユーザーの登録を同時に行う
  # hostsが設定されているか否かで
  - name: db_with_user_info
    # データベースユーザー名(オプション)
    # ※省略された場合はデータベース名が利用されます
    user: db_user
    # データベース接続パスワード
    password: sample_user_password
    # 接続許可ホスト
    hosts:
      - "127.0.0.1"
      - "::1"
      - localhost
```

### mariadb_users

追加/削除するデータベースユーザーを指定します。

```yml
mariadb_users:
  - name: sample_user
    password: sample_user_password
    hosts:
      - "127.0.0.1"
      - "::1"
      - localhost
    priv: "sample.*:ALL"
    state: no
```

### mariadb_cfg

MariaDBの設定を定義します。

```yml
mariadb_cfg:
  mysqld:
    ## General
    sql_mode:
      - ONLY_FULL_GROUP_BY
      - STRICT_TRANS_TABLES
      - NO_ZERO_IN_DATE
      - NO_ZERO_DATE
      - ERROR_FOR_DIVISION_BY_ZERO
      - NO_AUTO_CREATE_USER
      - NO_ENGINE_SUBSTITUTION
    bind_address: 127.0.0.1
    # datadir: /var/lib/mysql
    # socket: /var/run/mysqld/mysqld.sock
    # innodb_data_home_dir: /var/lib/mysql
    ## Network
    max_connections: "{{ mariadb_max_connections }}"
    # connect_timeout: 10
    skip_name_resolve: no
    # max_allowed_packet: 16M
    # interactive_timeout: 3600
    # wait_timeout: 600
    table_open_cache: "{{ mariadb_max_connections * mariadb_max_table_use_in_query }}"
    thread_cache_size: "{{ mariadb_max_connections }}"
    table_definition_cache: "{{ 400 + (mariadb_max_connections * mariadb_max_table_use_in_query / 2)|int }}"
    ## Global Buffers
    # Total Global Buffer Size =
    #  + key_buffer_size
    #  + innodb_buffer_pool_size
    #  + innodb_log_buffer_size
    #  + max_heap_table_size
    #  + query_cache_size
    ## Cache
    query_cache_limit: 8M
    query_cache_size: 64M
    query_cache_type:  1
    # ------------------
    # InnoDB
    # ------------------
    ## InnoDB General
    innodb_file_per_table: yes
    innodb_flush_log_at_trx_commit: 1
    innodb_buffer_pool_size: "{{ ((ansible_memtotal_mb * 1024 * 1024) * (mariadb_innodb_baffer_pool_rate / 100))|int }}"
    innodb_log_file_size: "{{ (((ansible_memtotal_mb * 1024 * 1024) * (mariadb_innodb_baffer_pool_rate / 100)) / 4)|int }}"
    innodb_log_files_in_group: 2
    innodb_additional_mem_pool_size: 32M
    innodb_log_buffer_size: 32M
    # innodb_strict_mode: no
    # innodb_large_prefix: yes
    # innodb_file_format: Antelope
    max_heap_table_size: 32M
    tmp_table_size: 32M
    ## Thread Buffer
    # Total Thread Buffer Size =
    #  + sort_buffer_size
    #  + read_rnd_buffer_size
    #  + join_buffer_size
    #  + read_buffer_size
    #  + max_allowed_packet
    #  + thread_stack
    sort_buffer_size: 512K
    join_buffer_size: 512K
    read_buffer_size: 512K
    read_rnd_buffer_size: 512K
    # ------------------
    # MyISAM
    # ------------------
    ## Global Buffer
    key_buffer_size: "{{ ((ansible_memtotal_mb * 1024 * 1024) * (mariadb_myisam_key_baffer_rate / 100))|int }}"
    ## Thread Buffer
    # myisam_sort_buffer_size: 64M
    # -----------------
    # Logging
    # -----------------
    slow_query_log: yes
    long_query_time: 1
    # log_warnings: 0
    # min_examined_row_limit: 0
    # log_queries_not_using_indexes: no
    # log_slow_admin_statements: no
    slow_query_log_file: /var/log/mysql/slow_query.log
    # general_log: no
    # general_log_file: /var/log/mysql/general.log
    # -----------------
    # Replication
    # -----------------
    # gtid_domain_id: 1
    # server_id: 1
    # log_bin: mysql-bin
    # binlog_format: ROW
    # expire_logs_days: 10
    # read_only: no
    # log_slave_updates: no
    # -----------------
    # Other Extra Setting
    # -----------------
    # extra_setting: ""
  # mysqld_safe:
  #   datadir: /var/lib/mysql
  #   socket: /var/run/mysqld/mysqld.sock
```

Example Playbook
----------------

```yml
- hosts: servers
  roles:
     - { role: mariadb }
```

License
-------

MIT
