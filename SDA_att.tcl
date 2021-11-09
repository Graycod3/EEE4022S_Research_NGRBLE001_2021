# This script is created by NSG2 beta1
# <http://wushoupong.googlepages.com/nsg>

#===================================
#     Simulation parameters setup
#===================================
set val(chan)   Channel/WirelessChannel    ;# channel type
set val(prop)   Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)  Phy/WirelessPhy            ;# network interface type
set val(mac)    Mac/802_11                 ;# MAC type
set val(ifq)    Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)     LL                         ;# link layer type
set val(ant)    Antenna/OmniAntenna        ;# antenna model
set val(ifqlen) 50                         ;# max packet in ifq
set val(nn)     17                         ;# number of mobilenodes
set val(rp)     AODV                       ;# routing protocol
set val(x)      1725                      ;# X dimension of topography
set val(y)      611                      ;# Y dimension of topography
set val(stop)   45.0                         ;# time of simulation end

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Setup topography object
set topo       [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)

#Open the NS trace file
set tracefile [open blackhole.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open blackhole.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)
set chan [new $val(chan)];#Create wireless channel

#===================================
#     Mobile node parameter setup
#===================================
$ns node-config -adhocRouting  $val(rp) \
                -llType        $val(ll) \
                -macType       $val(mac) \
                -ifqType       $val(ifq) \
                -ifqLen        $val(ifqlen) \
                -antType       $val(ant) \
                -propType      $val(prop) \
                -phyType       $val(netif) \
                -channel       $chan \
                -topoInstance  $topo \
                -agentTrace    ON \
                -routerTrace   ON \
                -macTrace      ON \
                -movementTrace ON

#===================================
#        Nodes Definition        
#===================================
#Create 17 nodes
set n0 [$ns node]
$n0 set X_ 301
$n0 set Y_ 502
$n0 set Z_ 0.0
$ns initial_node_pos $n0 20
set n1 [$ns node]
$n1 set X_ 705
$n1 set Y_ 498
$n1 set Z_ 0.0
$ns initial_node_pos $n1 20
set n2 [$ns node]
$n2 set X_ 1098
$n2 set Y_ 501
$n2 set Z_ 0.0
$ns initial_node_pos $n2 20
set n3 [$ns node]
$n3 set X_ 1501
$n3 set Y_ 498
$n3 set Z_ 0.0
$ns initial_node_pos $n3 20
set n4 [$ns node]
$n4 set X_ 195
$n4 set Y_ 300
$n4 set Z_ 0.0
$ns initial_node_pos $n4 20
set n5 [$ns node]
$n5 set X_ 302
$n5 set Y_ 298
$n5 set Z_ 0.0
$ns initial_node_pos $n5 20
set n6 [$ns node]
$n6 set X_ 401
$n6 set Y_ 299
$n6 set Z_ 0.0
$ns initial_node_pos $n6 20
set n7 [$ns node]
$n7 set X_ 598
$n7 set Y_ 304
$n7 set Z_ 0.0
$ns initial_node_pos $n7 20
set n8 [$ns node]
$n8 set X_ 698
$n8 set Y_ 304
$n8 set Z_ 0.0
$ns initial_node_pos $n8 20
set n9 [$ns node]
$n9 set X_ 794
$n9 set Y_ 302
$n9 set Z_ 0.0
$ns initial_node_pos $n9 20
set n10 [$ns node]
$n10 set X_ 998
$n10 set Y_ 300
$n10 set Z_ 0.0
$ns initial_node_pos $n10 20
set n11 [$ns node]
$n11 set X_ 1092
$n11 set Y_ 300
$n11 set Z_ 0.0
$ns initial_node_pos $n11 20
set n12 [$ns node]
$n12 set X_ 1196
$n12 set Y_ 299
$n12 set Z_ 0.0
$ns initial_node_pos $n12 20
set n13 [$ns node]
$n13 set X_ 1387
$n13 set Y_ 300
$n13 set Z_ 0.0
$ns initial_node_pos $n13 20
set n14 [$ns node]
$n14 set X_ 1497
$n14 set Y_ 301
$n14 set Z_ 0.0
$ns initial_node_pos $n14 20
set n15 [$ns node]
$n15 set X_ 1593
$n15 set Y_ 299
$n15 set Z_ 0.0
$ns initial_node_pos $n15 20
set n16 [$ns node]
$n16 set X_ 900
$n16 set Y_ 701
$n16 set Z_ 0.0
$ns initial_node_pos $n16 20

#
$ns at 1.0 "[$n9 set ragent_] blackhole"
$ns at 1.0 "[$n10 set ragent_] blackhole"
 

#===================================
#        Generate movement          
#===================================
$ns at 1.0 " $n4 setdest 200 300 10 " 
$ns at 10 " $n4 setdest 200 500 20 " 
$ns at 10 " $n7 setdest 650 400 20 " 
$ns at 15 " $n7 setdest 598 304 20 " 
$ns at 15 " $n8 setdest 550 202 30 " 
$ns at 17 " $n8 setdest 698 202 30 " 
$ns at 8 " $n10 setdest 900 200 25 " 
$ns at 10 " $n10 setdest 1000 200 25 " 
$ns at 12 " $n10 setdest 998 300 30 " 

#===================================
#        Agents Definition        
#===================================
#Setup a TCP connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n4 $tcp0
set sink7 [new Agent/TCPSink]
$ns attach-agent $n0 $sink7
$ns connect $tcp0 $sink7
$tcp0 set packetSize_ 1500

#Setup a TCP connection
set tcp1 [new Agent/TCP]
$ns attach-agent $n6 $tcp1
set sink11 [new Agent/TCPSink]
$ns attach-agent $n0 $sink11
$ns connect $tcp1 $sink11
$tcp1 set packetSize_ 1500

#Setup a TCP connection
set tcp2 [new Agent/TCP]
$ns attach-agent $n8 $tcp2
set sink8 [new Agent/TCPSink]
$ns attach-agent $n1 $sink8
$ns connect $tcp2 $sink8
$tcp2 set packetSize_ 1500

#Setup a TCP connection
set tcp3 [new Agent/TCP]
$ns attach-agent $n11 $tcp3
set sink9 [new Agent/TCPSink]
$ns attach-agent $n2 $sink9
$ns connect $tcp3 $sink9
$tcp3 set packetSize_ 1500

#Setup a TCP connection
set tcp4 [new Agent/TCP]
$ns attach-agent $n14 $tcp4
set sink10 [new Agent/TCPSink]
$ns attach-agent $n3 $sink10
$ns connect $tcp4 $sink10
$tcp4 set packetSize_ 1500

#Setup a TCP connection
set tcp5 [new Agent/TCP]
$ns attach-agent $n13 $tcp5
set sink13 [new Agent/TCPSink]
$ns attach-agent $n3 $sink13
$ns connect $tcp5 $sink13
$tcp5 set packetSize_ 1500

#Setup a TCP connection
set tcp6 [new Agent/TCP]
$ns attach-agent $n12 $tcp6
set sink12 [new Agent/TCPSink]
$ns attach-agent $n2 $sink12
$ns connect $tcp6 $sink12
$tcp6 set packetSize_ 1500


#===================================
#        Applications Definition        
#===================================
#Setup a FTP Application over TCP connection
set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp0
$ns at 1.0 "$ftp4 start"
$ns at 10.0 "$ftp4 stop"

#Setup a FTP Application over TCP connection
set ftp5 [new Application/FTP]
$ftp5 attach-agent $tcp1
$ns at 1.0 "$ftp5 start"
$ns at 10.0 "$ftp5 stop"

#Setup a FTP Application over TCP connection
set ftp6 [new Application/FTP]
$ftp6 attach-agent $tcp2
$ns at 2.0 "$ftp6 start"
$ns at 15.0 "$ftp6 stop"

#Setup a FTP Application over TCP connection
set ftp7 [new Application/FTP]
$ftp7 attach-agent $tcp3
$ns at 4.0 "$ftp7 start"
$ns at 16.0 "$ftp7 stop"

#Setup a FTP Application over TCP connection
set ftp8 [new Application/FTP]
$ftp8 attach-agent $tcp6
$ns at 5.0 "$ftp8 start"
$ns at 20.0 "$ftp8 stop"

#Setup a FTP Application over TCP connection
set ftp9 [new Application/FTP]
$ftp9 attach-agent $tcp5
$ns at 5.0 "$ftp9 start"
$ns at 20.0 "$ftp9 stop"

#Setup a FTP Application over TCP connection
set ftp10 [new Application/FTP]
$ftp10 attach-agent $tcp4
$ns at 6.0 "$ftp10 start"
$ns at 25.0 "$ftp10 stop"


#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam blackhole.nam &
    exit 0
}
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n$i reset"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
