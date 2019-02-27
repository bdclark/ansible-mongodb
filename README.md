# mongodb

Ansible role to install and configure MongoDB.

Also optionally installs the MMS monitoring and/or automation agent(s).

## Role Variables
See [defaults/main.yml](defaults/main.yml) for a list and description of
variables used in this role.

## Configuration (`mongodb_config`)
The `mongodb_config` variable will be rendered as YAML to the MongoDB
configuration file. The default configuration by OS are shown below.
Use `mongodb_config` to override existing or add additional settings.

This role will ensure directories for `storage.dbPath` and `systemLog.path`
exist and have the correct ownership and permissions.

#### Debian/Ubuntu
```yaml
net:
  port: 27017
  bindIp: 127.0.0.1
storage:
  dbPath: /var/lib/mongodb
  journal:
    enabled: true
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log
storage:
  dbPath: /var/lib/mongodb
```

#### RedHat
```yaml
net:
  port: 27017
  bindIp: 127.0.0.1
storage:
  dbPath: /var/lib/mongo
  journal:
    enabled: true
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log
processManagement:
  fork: true
  pidFilePath: /var/run/mongodb/mongod.pid
```

## Example Playbook
```yaml
- hosts: servers
  become: true
  vars:
    mongodb_version: 3.6.10
    mongodb_disable_thp: true
    mongodb_config:
      security:
        keyFile: /etc/mongodb.keyfile
      net:
        bindIp: 0.0.0.0
      storage:
        dbPath: /data/mongodb
    mongodb_keyfile_content: ilikerandomsecrets
    mongodb_install_monitor_agent: true
    mongodb_install_automation_agent: true
    mongodb_monitor_agent_config:
      mmsGroupId: my_monitor_agent_group_id
      mmsApiKey: my_monitor_agent_api_key
    mongodb_automation_agent_config:
      mmsGroupId: my_automation_agent_group_id
      mmsApiKey: my_automation_agent_api_key
  roles:
    - role: mongodb
```
