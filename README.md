mackerel-agent
=========

mackerel-agentのインストールとセットアップを行います

Role Variables
--------------

| 変数名                                              | 内容                                                       |
| --------------------------------------------------- | ---------------------------------------------------------- |
| mackerel_agent_api_key                              | mackerel-agentのAPIキーを設定します                        |
| mackerel_agent_cfg                                  | その他のmackerel-agentの設定を定義します                   |
| mackerel_agent_install_agent_plugins                | mackerel-agent-pluginsをインストールするか否かを設定します |
| mackerel_agent_install_check_plugins                | mackerel-check-pluginsをインストールするか否かを設定します |
| mackerel_agent_active_and_enabled_on_system_startup | mackerel-agentをサービスの状態を設定します                 |


### mackerel_agent_api_key

mackerel-agentのAPIキーを設定します

### mackerel_agent_cfg

mackerel-agentの設定を定義します

#### Example

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
      apache2: mackerel-plugin-apache2
    checkes:
      log: "/path/to/check-log --file=/path/to/file --pattern=REGEXP --warning-over=N --critical-over=N"
      procs:
        command: "/path/to/check-procs --pattern=PROCESS_NAME --state=STATE --warning-under=N"
```

### mackerel_agent_install_agent_plugins

この変数に`true`が設定されている場合、
mackerel-agent-pluginsのインストールを行います

#### Example

```yml
mackerel_agent_install_check_plugins: no
```

### mackerel_agent_install_check_plugins

この変数に`true`が設定されている場合、
mackerel-check-pluginsのインストールを行います

#### Example

```yml
mackerel_agent_install_check_plugins: no
```

### mackerel_agent_active_and_enabled_on_system_startup

mackerel-agentを起動させるかどうかを設定します

この変数に`true`が設定されている場合、
mackerel-agentを有効に設定し起動させます。

この変数に`false`が設定されている場合、
mackerel-agentを無効に設定し停止させます。

#### Example

```yml
mackerel_agent_active_and_enabled_on_system_startup: yes
```


Example Playbook
----------------

```yml
- hosts: servers
  roles:
     - { role: mackerel-agent }
```

License
-------

MIT
