# nginx_limiting_upload

docker (iperf3 <- nginx with stream module) <-- iperf3 client from your local machine

# To test from your computer:
```
iperf3 -c 127.0.0.1 -p 12345
```
- 127.0.0.1 = IP of your docker server
- 12345 = port of nginx server


iperf client:
```
[  5] local 127.0.0.1 port 45798 connected to 127.0.0.1 port 12345
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  12.5 MBytes   105 Mbits/sec    0    639 KBytes       
[  5]   1.00-2.00   sec  1.25 MBytes  10.5 Mbits/sec    1    639 KBytes       
[  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    1    639 KBytes       
[  5]   3.00-4.00   sec  1.25 MBytes  10.5 Mbits/sec    2    639 KBytes       
[  5]   4.00-5.00   sec  1.25 MBytes  10.5 Mbits/sec    2    639 KBytes       
[  5]   5.00-6.00   sec  1.25 MBytes  10.5 Mbits/sec    0    639 KBytes       
[  5]   6.00-7.00   sec  1.25 MBytes  10.5 Mbits/sec    0    639 KBytes       
[  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    0    639 KBytes       
[  5]   8.00-9.00   sec  1.25 MBytes  10.5 Mbits/sec    0    639 KBytes       
[  5]   9.00-10.00  sec  1.25 MBytes  10.5 Mbits/sec    0    639 KBytes       
```

iperf server (behind nginx with rate limit 1000k/s):
```
iperf3   | -----------------------------------------------------------
iperf3   | Server listening on 5201
iperf3   | -----------------------------------------------------------
iperf3   | Time: Fri, 07 Jan 2022 15:11:14 GMT
iperf3   | Accepted connection from 100.123.10.2, port 58482
iperf3   |       Cookie: jz33yvipab3ofisjd6lk222etqm3iiyetyas
iperf3   |       TCP MSS: 0 (default)
iperf3   | [  5] local 100.123.10.3 port 5201 connected to 100.123.10.2 port 58488
iperf3   | Starting Test: protocol: TCP, 1 streams, 131072 byte blocks, omitting 0 seconds, 10 second test, tos 0
iperf3   | [ ID] Interval           Transfer     Bitrate
iperf3   | [  5]   0.00-1.00   sec   983 KBytes  8.05 Mbits/sec                  
iperf3   | [  5]   1.00-2.00   sec   992 KBytes  8.13 Mbits/sec                  
iperf3   | [  5]   2.00-3.00   sec   976 KBytes  7.99 Mbits/sec                  
iperf3   | [  5]   3.00-4.00   sec   976 KBytes  7.99 Mbits/sec                  
iperf3   | [  5]   4.00-5.00   sec   976 KBytes  8.00 Mbits/sec                  
iperf3   | [  5]   5.00-6.00   sec   992 KBytes  8.13 Mbits/sec                  
iperf3   | [  5]   6.00-7.00   sec   976 KBytes  7.99 Mbits/sec                  
iperf3   | [  5]   7.00-8.00   sec   992 KBytes  8.13 Mbits/sec                  
iperf3   | [  5]   8.00-9.00   sec   976 KBytes  7.99 Mbits/sec                  
iperf3   | [  5]   9.00-10.00  sec   976 KBytes  8.00 Mbits/sec                  
```


help:
https://stackoverflow.com/questions/65275764/nginx-limit-upload-speed