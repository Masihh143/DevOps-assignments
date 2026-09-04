# Network Fundamentals Assignment

## Command Explanations

- **`ip addr show`**: Displays all active network interfaces, MAC addresses, and assigned IP addresses (IPv4/IPv6).
- **`ip route`**: Shows the system's routing table, including the default gateway used to route external internet traffic.
- **`ping -c 4 <target>`**: Sends ICMP echo requests to test network connectivity, packet loss, and round-trip latency to a host.
- **`nslookup <target>`**: Queries DNS servers to resolve a domain name into its corresponding IP address.
- **`traceroute <target>`**: Traces the hop-by-hop network path and packet latency from the local machine to the destination server.
- **`ss -tulpn`**: Lists all active listening TCP/UDP ports and the associated processes running locally.

---

## Troubleshooting Script (`net_troubleshoot.sh`)

```bash
#!/bin/bash

# ---- Variables ----
report_dir="net_reports"
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# ---- Take user input ----
read -p "Enter hostname or IP to troubleshoot (e.g. google.com): " target

# ---- Create directory and file for the report ----
mkdir -p "$report_dir"
report_file="$report_dir/netcheck_${target}_${timestamp}.txt"
touch "$report_file"

echo "===== NETWORK TROUBLESHOOT REPORT for $target =====" > "$report_file"
echo "Generated on: $(date)" >> "$report_file"
echo "" >> "$report_file"

# ---- 1. Check network interfaces ----
echo "----- Network Interfaces -----" >> "$report_file"
ip addr show >> "$report_file" 2>&1
echo "" >> "$report_file"

# ---- 2. Check default gateway / routing table ----
echo "----- Routing Table -----" >> "$report_file"
ip route >> "$report_file" 2>&1
echo "" >> "$report_file"

# ---- 3. Ping test (connectivity + packet loss) ----
echo "----- Ping Test (4 packets) -----" >> "$report_file"
ping -c 4 "$target" >> "$report_file" 2>&1
ping_status=$?
echo "" >> "$report_file"

# ---- 4. DNS resolution check ----
echo "----- DNS Resolution -----" >> "$report_file"
nslookup "$target" >> "$report_file" 2>&1
echo "" >> "$report_file"

# ---- 5. Traceroute (path to host) ----
echo "----- Traceroute -----" >> "$report_file"
traceroute "$target" >> "$report_file" 2>&1
echo "" >> "$report_file"

# ---- 6. Check open/listening ports locally ----
echo "----- Local Listening Ports -----" >> "$report_file"
ss -tulpn >> "$report_file" 2>&1
echo "" >> "$report_file"

# ---- Summary based on ping result ----
echo "----- Summary -----" >> "$report_file"
if [ $ping_status -eq 0 ]; then
    echo "Result: $target is REACHABLE." | tee -a "$report_file"
else
    echo "Result: $target is UNREACHABLE. Check DNS, firewall, or cable/interface above." | tee -a "$report_file"
fi

echo ""
echo "Full report saved to: $report_file"
```

---

## Execution Output Log (`netcheck_google.com.txt`)

```
===== NETWORK TROUBLESHOOT REPORT for google.com =====
Generated on: Fri Sep  4 07:21:28 PM IST 2026

----- Network Interfaces -----
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
2: wlp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether f8:54:f6:23:b0:02 brd ff:ff:ff:ff:ff:ff
    inet 100.128.162.80/20 brd 100.128.175.255 scope global dynamic noprefixroute wlp1s0

----- Routing Table -----
default via 100.128.160.1 dev wlp1s0 proto dhcp src 100.128.162.80 metric 600 

----- Ping Test (4 packets) -----
PING google.com (142.250.207.174) 56(84) bytes of data.
64 bytes from pnbomb-bl-in-f14.1e100.net (142.250.207.174): icmp_seq=1 ttl=120 time=21.8 ms
64 bytes from pnbomb-bl-in-f14.1e100.net (142.250.207.174): icmp_seq=2 ttl=120 time=14.9 ms
64 bytes from pnbomb-bl-in-f14.1e100.net (142.250.207.174): icmp_seq=3 ttl=120 time=20.7 ms
64 bytes from pnbomb-bl-in-f14.1e100.net (142.250.207.174): icmp_seq=4 ttl=120 time=17.1 ms

--- google.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3004ms
rtt min/avg/max/mdev = 14.861/18.619/21.761/2.767 ms

----- DNS Resolution -----
Server:		127.0.0.53
Address:	127.0.0.53#53

Non-authoritative answer:
Name:	google.com
Address: 142.250.207.174

----- Traceroute -----
traceroute to google.com (142.250.207.174), 64 hops max
  1   100.128.160.1  29.191ms  4.603ms  11.615ms 
  2   114.79.130.29  162.065ms  30.719ms  69.743ms 
  3   72.14.208.165  47.813ms  114.646ms  77.918ms 
  4   192.178.84.175  18.640ms  45.106ms  17.202ms 
  5   142.250.214.111  75.294ms  92.378ms  22.776ms 
  6   142.250.207.174  45.790ms  60.324ms  30.146ms 

----- Summary -----
Result: google.com is REACHABLE.
```
