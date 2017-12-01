 #!/bin/bash
date_time=`date+%Y%m%d`
etcdctl backup--data-dir /usr/local/etcd-v2.2.1-linux-amd64/node1.etcd --backup-dir/backup_etcd/${date_time}
find /backup_etcd/-ctime +5 -exec rm -r {} \;
