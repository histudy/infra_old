mackerel-agent
=========

mackerel-agentのインストールとセットアップを行います。

Role Variables
--------------

### mackerel_agent_api_key

mackerel-agentのAPIキーを指定します。

### mackerel_agent_cfg

mackerel-agentの設定を指定します。

```yml
mackerel_agent_cfg:
  pidfile: /var/run/mackerel-agent.pid
  root: /var/lib/mackerel-agent
  verbose: no
  display_name: My Host
  http_proxy: http://localhost:8080
  roles:
    - My-Service:app
    - Another-Service:db
  host_status:
    on_start: working
    on_stop: poweroff
  filesystems:
    ignore: /dev/ram.*
    use_mountpoint: yes
  plugin:
    metrics:
      apache2: /usr/bin/mackerel-plugin-apache2
      mailq: /usr/bin/mackerel-plugin-mailq -M postfix
    checkes:
      log: "/usr/bin/check-log --file=/path/to/file --pattern=REGEXP --warning-over=N --critical-over=N"
      procs:
        command: "/usr/bin/check-procs --pattern=PROCESS_NAME --state=STATE --warning-under=N"
      load_average:
        command: "/usr/bin/check-load -w 3,2,1 -c 3,2,1"
        # optional
        notification_interval: 60
        max_check_attempts: 1
        check_interval: 5
        timeout_seconds: 45
        prevent_alert_auto_close: yes
        memo: "メモをここに記載することができます"
        env:
          ENV_NAME: value
        action:
          command: "pa -auxf"
          env:
            ENV_NAME: value
          user: "mackerel"
```

### mackerel_agent_install_agent_plugins

この変数に`yes`が設定されている場合、  
mackerel-agent-pluginsのインストールを行います。

```yml
mackerel_agent_install_check_plugins: no
```

### mackerel_agent_install_check_plugins

この変数に`yes`が設定されている場合、  
mackerel-check-pluginsのインストールを行います。

```yml
mackerel_agent_install_check_plugins: no
```

### mackerel_agent_active_and_enabled_on_system_startup

mackerel-agentを起動させるかどうかを指定します。

この変数に`yes`が設定されている場合、
mackerel-agentを有効に設定し起動させます。

この変数に`no`が設定されている場合、
mackerel-agentを無効に設定し停止させます。

```yml
mackerel_agent_active_and_enabled_on_system_startup: yes
```

Example Playbook
----------------

```yml
- hosts: servers
  roles:
    - role: mackerel-agent
```

License
-------

MIT
