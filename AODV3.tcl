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
set val(nn)     16                         ;# number of mobilenodes
set val(rp)     AODV                       ;# routing protocol
set val(x)      1599                      ;# X dimension of topography
set val(y)      602                      ;# Y dimension of topography
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
set tracefile [open aodv4.tr w]
$ns trace-all $tracefile
$ns use-newtrace

#Open the NAM trace file
set namfile [open aodv4.nam w]
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
                -energyModel "EnergyModel"\
		-initialEnergy 50.0 \
                -txPower 0.9 \
		-rxPower 0.7 \
		-idlePower 0.1 \
		-agentTrace    ON \
                -routerTrace   ON \
                -macTrace      ON \
                -movementTrace ON

#===================================
#        Nodes Definition        
#===================================
#Create 16 nodes
set n0 [$ns node]
$n0 set X_ 303
$n0 set Y_ 495
$n0 set Z_ 0.0
$ns initial_node_pos $n0 20
set n1 [$ns node]
$n1 set X_ 207
$n1 set Y_ 299
$n1 set Z_ 0.0
$ns initial_node_pos $n1 20
set n2 [$ns node]
$n2 set X_ 303
$n2 set Y_ 302
$n2 set Z_ 0.0
$ns initial_node_pos $n2 20
set n3 [$ns node]
$n3 set X_ 405
$n3 set Y_ 301
$n3 set Z_ 0.0
$ns initial_node_pos $n3 20
set n4 [$ns node]
$n4 set X_ 497
$n4 set Y_ 297
$n4 set Z_ 0.0
$ns initial_node_pos $n4 20
set n5 [$ns node]
$n5 set X_ 601
$n5 set Y_ 501
$n5 set Z_ 0.0
$ns initial_node_pos $n5 20
set n6 [$ns node]
$n6 set X_ 599
$n6 set Y_ 298
$n6 set Z_ 0.0
$ns initial_node_pos $n6 20
set n7 [$ns node]
$n7 set X_ 1002
$n7 set Y_ 502
$n7 set Z_ 0.0
$ns initial_node_pos $n7 20
set n8 [$ns node]
$n8 set X_ 898
$n8 set Y_ 300
$n8 set Z_ 0.0
$ns initial_node_pos $n8 20
set n9 [$ns node]
$n9 set X_ 707
$n9 set Y_ 299
$n9 set Z_ 0.0
$ns initial_node_pos $n9 20
set n10 [$ns node]
$n10 set X_ 1000
$n10 set Y_ 302
$n10 set Z_ 0.0
$ns initial_node_pos $n10 20
set n12 [$ns node]
$n12 set X_ 1103
$n12 set Y_ 300
$n12 set Z_ 0.0
$ns initial_node_pos $n12 20
set n11 [$ns node]
$n11 set X_ 1304
$n11 set Y_ 300
$n11 set Z_ 0.0
$ns initial_node_pos $n11 20
set n14 [$ns node]
$n14 set X_ 1399
$n14 set Y_ 494
$n14 set Z_ 0.0
$ns initial_node_pos $n14 20
set n15 [$ns node]
$n15 set X_ 1400
$n15 set Y_ 302
$n15 set Z_ 0.0
$ns initial_node_pos $n15 20
set n13 [$ns node]
$n13 set X_ 1499
$n13 set Y_ 299
$n13 set Z_ 0.0
$ns initial_node_pos $n13 20

$ns at 1.0 "[$n8 set ragent_] blackhole"
$ns at 1.0 "[$n9 set ragent_] blackhole"
#===================================
#        Generate movement          
#===================================
$ns at 1.0 " $n1 setdest 200 200 10 " 
$ns at 2.0 " $n6 setdest 600 400 30 " 
$ns at 8.0 " $n6 setdest 599 298 30 " 

#===================================
#        Agents Definition        
#===================================
#Setup a TCP connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n1 $tcp0
set sink4 [new Agent/TCPSink]
$ns attach-agent $n0 $sink4
$ns connect $tcp0 $sink4
$tcp0 set packetSize_ 1500

#Setup a TCP connection
set tcp1 [new Agent/TCP]
$ns attach-agent $n6 $tcp1
set sink5 [new Agent/TCPSink]
$ns attach-agent $n5 $sink5
$ns connect $tcp1 $sink5
$tcp1 set packetSize_ 1500

#Setup a TCP connection
set tcp2 [new Agent/TCP]
$ns attach-agent $n10 $tcp2
set sink6 [new Agent/TCPSink]
$ns attach-agent $n7 $sink6
$ns connect $tcp2 $sink6
$tcp2 set packetSize_ 1500

#Setup a TCP connection
set tcp3 [new Agent/TCP]
$ns attach-agent $n15 $tcp3
set sink7 [new Agent/TCPSink]
$ns attach-agent $n14 $sink7
$ns connect $tcp3 $sink7
$tcp3 set packetSize_ 1500


#===================================
#        Applications Definition        
#===================================
#Setup a FTP Application over TCP connection
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp0
$ns at 1.0 "$ftp1 start"
$ns at 15.0 "$ftp1 stop"

#Setup a FTP Application over TCP connection
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp1
$ns at 2.0 "$ftp2 start"
$ns at 20.0 "$ftp2 stop"

#Setup a FTP Application over TCP connection
set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp2
$ns at 2.0 "$ftp3 start"
$ns at 20.0 "$ftp3 stop"

#Setup a FTP Application over TCP connection
set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp3
$ns at 3.0 "$ftp4 start"
$ns at 25.0 "$ftp4 stop"


#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam aodv4.nam &
    exit 0
}
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n$i reset"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
