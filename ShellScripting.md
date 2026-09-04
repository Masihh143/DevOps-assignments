# Shell Scripting Assignment

## Script (`system_info.sh`)

```bash
#!/bin/bash

current_date=$(date)
host_name=$(hostname)
current_user=$(whoami)
echo "Current date : $current_date"
echo "Hostname : $host_name"
echo "Current user: $current_user"
echo ""
echo "--- Disk Usage ---"
df -h
echo ""
echo "--- Top 10 Running Processes ---"
ps aux | head -n 10

read -p "Enter a name for your report directory: " dir_name
mkdir -p "$dir_name"
touch "$dir_name/testProcess.txt"
ps aux > "$dir_name/testProcess.txt"
echo "Report directory '$dir_name' created and processes logged to '$dir_name/testProcess.txt'."
```

## Execution Output Log

```
Current date : Fri Sep  4 07:21:14 PM IST 2026
Hostname : Vivobook-ASUSLaptop-M1502QA-M1502QA
Current user: mohammed-masihuddin

--- Disk Usage ---
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           1.6G  3.2M  1.5G   1% /run
/dev/nvme0n1p6  147G  113G   27G  82% /
tmpfs           7.6G  379M  7.2G   5% /dev/shm
tmpfs           5.0M   12K  5.0M   1% /run/lock
efivarfs        128K   43K   81K  35% /sys/firmware/efi/efivars
/dev/nvme0n1p1  256M   58M  199M  23% /boot/efi
tmpfs           1.6G  236K  1.6G   1% /run/user/1000

--- Top 10 Running Processes ---
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0  24128 14816 ?        Ss   01:44   0:03 /sbin/init splash
root           2  0.0  0.0      0     0 ?        S    01:44   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        S    01:44   0:00 [pool_workqueue_release]
root           4  0.0  0.0      0     0 ?        I<   01:44   0:00 [kworker/R-rcu_gp]
root           5  0.0  0.0      0     0 ?        I<   01:44   0:00 [kworker/R-sync_wq]
root           6  0.0  0.0      0     0 ?        I<   01:44   0:00 [kworker/R-kvfree_rcu_reclaim]
root           7  0.0  0.0      0     0 ?        I<   01:44   0:00 [kworker/R-slub_flushwq]
root           8  0.0  0.0      0     0 ?        I<   01:44   0:00 [kworker/R-netns]
root          10  0.0  0.0      0     0 ?        I<   01:44   0:00 [kworker/0:0H-kblockd]

Enter a name for your report directory: system_reports
Report directory 'system_reports' created and processes logged to 'system_reports/testProcess.txt'.
```
