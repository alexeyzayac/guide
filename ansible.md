

```bash
ansible all -m ping
```

```bash
ansible all -m command -a uptime
ansible all -a uptime
ansible all -a "tail /var/log/dmesg"
```

```bash
ansible all -b -a "tail /var/log/syslog"
```

```bash
ansible all -b -m package -a name=tree
ansible all -b -m package -a "name=nginx update_cache=yes"
```

```bash
ansible all -b -m service -a "name=nginx state=restarted"
```