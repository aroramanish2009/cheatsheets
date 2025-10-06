ss
Utility to investigate sockets

Args
-4/-6 list ipv4/ipv6 sockets
-n numeric addresses instead of hostnames
-l list listing sockets
-u/-t/-x list udp/tcp/unix sockets
-p Show process(es) that using socket

# show all listing tcp sockets including the corresponding process
ss -tlp

# show all sockets connecting to 192.168.2.1 on port 80
ss -t dst 192.168.2.1:80

# show all ssh related connection
ss -t state established '( dport = :ssh or sport = :ssh )'

1. ss | less = used to list all connection on the machine.
2. ss -t = tcp connections only. Use -n to not resolve the name.
3. ss -us = udp connections only. Use -n to not resolve the name.
4. ss -ltn or ss -lun for UDP = List all listening sockets
5. ss -s = prints out the summary information for connections.
6. ss -tn -o = the o option will display the time for the connection as well.
7. ss [ OPTIONS ] [ STATE-FILTER ] [ ADDRESS-FILTER ] 
example:
$ ss -t4 state time-wait
Recv-Q Send-Q         Local Address:Port             Peer Address:Port   
0      0                192.168.1.2:42261           199.59.150.39:https   
0      0                  127.0.0.1:43541               127.0.0.1:2633

the options for state are :
1. established
2. syn-sent
3. syn-recv
4. fin-wait-1
5. fin-wait-2
6. time-wait
7. closed
8. close-wait
9. last-ack
10. closing
11. all - All of the above states
12. connected - All the states except for listen and closed
13. synchronized - All the connected states except for syn-sent
14. bucket - Show states, which are maintained as minisockets, i.e. time-wait and syn-recv.
15. big - Opposite to bucket state.

You can use [ watch -n 1 "ss -t4 state syn-sent" ] for looking at the quick connection state changes.

8. Filter connection by ports. 

$ ss -nt '( dst :443 or dst :80 )'
State      Recv-Q Send-Q      Local Address:Port        Peer Address:Port 
ESTAB      0      0             192.168.1.2:58844      199.59.148.82:443   
ESTAB      0      0             192.168.1.2:55320     165.193.246.23:443   
ESTAB      0      0             192.168.1.2:56198     108.160.162.37:80    
ESTAB      0      0             192.168.1.2:54889    192.241.177.148:443   
ESTAB      0      0             192.168.1.2:39893      173.255.230.5:80    
ESTAB      0      0             192.168.1.2:33440      38.127.167.38:443

9. More examples:
# source address is 127.0.0.1 and source port is greater than 5000
$ ss -nt src 127.0.0.1 sport gt :5000

# local smtp (port 25) sockets
$ sudo ss -ntlp sport eq :smtp

# port numbers greater than 25
$ sudo ss -nt sport gt :1024

# sockets with remote ports less than 100
$ sudo ss -nt dport \< :100

# connections to remote port 80
$ sudo ss -nt state connected dport = :80

10. ss -i = for internal tcp information like rto, window size, mss etc
