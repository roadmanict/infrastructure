# Raspberry PI

First run bootstrap playbook

```
ansible-playbook --ask-pass -i ./environments/berry/inventory site.yml
```

# Openstack

Create env_vars.sh file with:
```
#!/bin/bash
export OS_USERNAME=
export OS_PASSWORD=
export OS_TENANT_NAME=
export OS_AUTH_URL=
```

# Reset database backup

```bash
dropdb TABLE
createdb TABLE
pg_restore -d TABLE BACKUP_FILE
```