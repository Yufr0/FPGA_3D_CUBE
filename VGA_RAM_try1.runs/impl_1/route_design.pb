
Q
Command: %s
53*	vivadotcl2 
route_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-349h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
route_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
V

Starting %s Task
103*constraints2
Routing2default:defaultZ18-103h px� 
}
BMultithreading enabled for route_design using a maximum of %s CPUs17*	routeflow2
22default:defaultZ35-254h px� 
p

Phase %s%s
101*constraints2
1 2default:default2#
Build RT Design2default:defaultZ18-101h px� 
B
-Phase 1 Build RT Design | Checksum: 444e9185
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:47 ; elapsed = 00:00:35 . Memory (MB): peak = 2258.402 ; gain = 51.9532default:defaulth px� 
v

Phase %s%s
101*constraints2
2 2default:default2)
Router Initialization2default:defaultZ18-101h px� 
o

Phase %s%s
101*constraints2
2.1 2default:default2 
Create Timer2default:defaultZ18-101h px� 
A
,Phase 2.1 Create Timer | Checksum: 444e9185
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:48 ; elapsed = 00:00:36 . Memory (MB): peak = 2286.773 ; gain = 80.3242default:defaulth px� 
{

Phase %s%s
101*constraints2
2.2 2default:default2,
Fix Topology Constraints2default:defaultZ18-101h px� 
M
8Phase 2.2 Fix Topology Constraints | Checksum: 444e9185
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:49 ; elapsed = 00:00:36 . Memory (MB): peak = 2296.617 ; gain = 90.1682default:defaulth px� 
t

Phase %s%s
101*constraints2
2.3 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px� 
F
1Phase 2.3 Pre Route Cleanup | Checksum: 444e9185
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:49 ; elapsed = 00:00:37 . Memory (MB): peak = 2296.617 ; gain = 90.1682default:defaulth px� 
p

Phase %s%s
101*constraints2
2.4 2default:default2!
Update Timing2default:defaultZ18-101h px� 
B
-Phase 2.4 Update Timing | Checksum: a5933888
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:01:18 ; elapsed = 00:00:56 . Memory (MB): peak = 2365.203 ; gain = 158.7542default:defaulth px� 
�
Intermediate Timing Summary %s164*route2N
:| WNS=-60.496| TNS=-21098.520| WHS=-0.197 | THS=-258.143|
2default:defaultZ35-416h px� 
H
3Phase 2 Router Initialization | Checksum: 828d5f48
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:01:29 ; elapsed = 00:01:03 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
p

Phase %s%s
101*constraints2
3 2default:default2#
Initial Routing2default:defaultZ18-101h px� 
C
.Phase 3 Initial Routing | Checksum: 20f2caf27
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:01:54 ; elapsed = 00:01:16 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
s

Phase %s%s
101*constraints2
4 2default:default2&
Rip-up And Reroute2default:defaultZ18-101h px� 
u

Phase %s%s
101*constraints2
4.1 2default:default2&
Global Iteration 02default:defaultZ18-101h px� 
�
Intermediate Timing Summary %s164*route2M
9| WNS=-65.804| TNS=-26383.264| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
G
2Phase 4.1 Global Iteration 0 | Checksum: e6e597b2
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:07:25 ; elapsed = 00:04:28 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
u

Phase %s%s
101*constraints2
4.2 2default:default2&
Global Iteration 12default:defaultZ18-101h px� 
�
Intermediate Timing Summary %s164*route2M
9| WNS=-65.647| TNS=-26362.104| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
H
3Phase 4.2 Global Iteration 1 | Checksum: 14650579d
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:08:59 ; elapsed = 00:05:35 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
F
1Phase 4 Rip-up And Reroute | Checksum: 14650579d
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:08:59 ; elapsed = 00:05:35 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
|

Phase %s%s
101*constraints2
5 2default:default2/
Delay and Skew Optimization2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
5.1 2default:default2!
Delay CleanUp2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
5.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
E
0Phase 5.1.1 Update Timing | Checksum: 13113140f
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:09:02 ; elapsed = 00:05:37 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
�
Intermediate Timing Summary %s164*route2M
9| WNS=-65.647| TNS=-26346.637| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
B
-Phase 5.1 Delay CleanUp | Checksum: ba699021
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:09:04 ; elapsed = 00:05:39 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
z

Phase %s%s
101*constraints2
5.2 2default:default2+
Clock Skew Optimization2default:defaultZ18-101h px� 
L
7Phase 5.2 Clock Skew Optimization | Checksum: ba699021
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:09:04 ; elapsed = 00:05:39 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
N
9Phase 5 Delay and Skew Optimization | Checksum: ba699021
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:09:04 ; elapsed = 00:05:39 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
n

Phase %s%s
101*constraints2
6 2default:default2!
Post Hold Fix2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
6.1 2default:default2!
Hold Fix Iter2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
6.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
D
/Phase 6.1.1 Update Timing | Checksum: bdd9a423
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:09:08 ; elapsed = 00:05:42 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
�
Intermediate Timing Summary %s164*route2M
9| WNS=-65.279| TNS=-26299.498| WHS=0.016  | THS=0.000  |
2default:defaultZ35-416h px� 
C
.Phase 6.1 Hold Fix Iter | Checksum: 117379528
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:09:09 ; elapsed = 00:05:42 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
A
,Phase 6 Post Hold Fix | Checksum: 117379528
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:09:09 ; elapsed = 00:05:42 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
o

Phase %s%s
101*constraints2
7 2default:default2"
Route finalize2default:defaultZ18-101h px� 
B
-Phase 7 Route finalize | Checksum: 18391e22e
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:09:10 ; elapsed = 00:05:43 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
v

Phase %s%s
101*constraints2
8 2default:default2)
Verifying routed nets2default:defaultZ18-101h px� 
I
4Phase 8 Verifying routed nets | Checksum: 18391e22e
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:09:10 ; elapsed = 00:05:43 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
r

Phase %s%s
101*constraints2
9 2default:default2%
Depositing Routes2default:defaultZ18-101h px� 
E
0Phase 9 Depositing Routes | Checksum: 1e17757db
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:09:18 ; elapsed = 00:05:52 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
t

Phase %s%s
101*constraints2
10 2default:default2&
Post Router Timing2default:defaultZ18-101h px� 
�
Estimated Timing Summary %s
57*route2M
9| WNS=-65.279| TNS=-26299.498| WHS=0.016  | THS=0.000  |
2default:defaultZ35-57h px� 
B
!Router estimated timing not met.
128*routeZ35-328h px� 
G
2Phase 10 Post Router Timing | Checksum: 1e17757db
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:09:18 ; elapsed = 00:05:53 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
@
Router Completed Successfully
2*	routeflowZ35-16h px� 
�

%s
*constraints2q
]Time (s): cpu = 00:09:18 ; elapsed = 00:05:53 . Memory (MB): peak = 2377.234 ; gain = 170.7852default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
822default:default2
22default:default2
12default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
route_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
route_design: 2default:default2
00:09:262default:default2
00:05:572default:default2
2377.2342default:default2
222.5082default:defaultZ17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0552default:default2
2377.2342default:default2
0.0002default:defaultZ17-268h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0662default:default2
2377.2342default:default2
0.0002default:defaultZ17-268h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:262default:default2
00:00:082default:default2
2377.2342default:default2
0.0002default:defaultZ17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2^
JD:/codehub/VIVADO/VGA_RAM_try1/VGA_RAM_try1.runs/impl_1/VGA_RAM_routed.dcp2default:defaultZ17-1381h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2&
write_checkpoint: 2default:default2
00:00:392default:default2
00:00:182default:default2
2377.2342default:default2
0.0002default:defaultZ17-268h px� 
�
%s4*runtcl2~
jExecuting : report_drc -file VGA_RAM_drc_routed.rpt -pb VGA_RAM_drc_routed.pb -rpx VGA_RAM_drc_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2q
]report_drc -file VGA_RAM_drc_routed.rpt -pb VGA_RAM_drc_routed.pb -rpx VGA_RAM_drc_routed.rpx2default:defaultZ4-113h px� 
>
IP Catalog is up to date.1232*coregenZ19-1839h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
�
#The results of DRC are in file %s.
168*coretcl2�
ND:/codehub/VIVADO/VGA_RAM_try1/VGA_RAM_try1.runs/impl_1/VGA_RAM_drc_routed.rptND:/codehub/VIVADO/VGA_RAM_try1/VGA_RAM_try1.runs/impl_1/VGA_RAM_drc_routed.rpt2default:default8Z2-168h px� 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
report_drc: 2default:default2
00:00:182default:default2
00:00:092default:default2
2401.9342default:default2
24.6992default:defaultZ17-268h px� 
�
%s4*runtcl2�
�Executing : report_methodology -file VGA_RAM_methodology_drc_routed.rpt -pb VGA_RAM_methodology_drc_routed.pb -rpx VGA_RAM_methodology_drc_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
�report_methodology -file VGA_RAM_methodology_drc_routed.rpt -pb VGA_RAM_methodology_drc_routed.pb -rpx VGA_RAM_methodology_drc_routed.rpx2default:defaultZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
Y
$Running Methodology with %s threads
74*drc2
22default:defaultZ23-133h px� 
�
2The results of Report Methodology are in file %s.
450*coretcl2�
ZD:/codehub/VIVADO/VGA_RAM_try1/VGA_RAM_try1.runs/impl_1/VGA_RAM_methodology_drc_routed.rptZD:/codehub/VIVADO/VGA_RAM_try1/VGA_RAM_try1.runs/impl_1/VGA_RAM_methodology_drc_routed.rpt2default:default8Z2-1520h px� 
d
%s completed successfully
29*	vivadotcl2&
report_methodology2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2(
report_methodology: 2default:default2
00:00:362default:default2
00:00:212default:default2
2401.9342default:default2
0.0002default:defaultZ17-268h px� 
�
%s4*runtcl2�
zExecuting : report_power -file VGA_RAM_power_routed.rpt -pb VGA_RAM_power_summary_routed.pb -rpx VGA_RAM_power_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
mreport_power -file VGA_RAM_power_routed.rpt -pb VGA_RAM_power_summary_routed.pb -rpx VGA_RAM_power_routed.rpx2default:defaultZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px� 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
942default:default2
22default:default2
12default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
report_power2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
report_power: 2default:default2
00:00:342default:default2
00:00:202default:default2
2471.2972default:default2
69.3632default:defaultZ17-268h px� 
�
%s4*runtcl2o
[Executing : report_route_status -file VGA_RAM_route_status.rpt -pb VGA_RAM_route_status.pb
2default:defaulth px� 
�
%s4*runtcl2�
�Executing : report_timing_summary -max_paths 10 -file VGA_RAM_timing_summary_routed.rpt -pb VGA_RAM_timing_summary_routed.pb -rpx VGA_RAM_timing_summary_routed.rpx -warn_on_violation 
2default:defaulth px� 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px� 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px� 
�
rThe design failed to meet the timing requirements. Please see the %s report for details on the timing violations.
188*timing2"
timing summary2default:defaultZ38-282h px� 
�
%s4*runtcl2d
PExecuting : report_incremental_reuse -file VGA_RAM_incremental_reuse_routed.rpt
2default:defaulth px� 
g
BIncremental flow is disabled. No incremental reuse Info to report.423*	vivadotclZ4-1062h px� 
�
%s4*runtcl2d
PExecuting : report_clock_utilization -file VGA_RAM_clock_utilization_routed.rpt
2default:defaulth px� 
�
%s4*runtcl2�
�Executing : report_bus_skew -warn_on_violation -file VGA_RAM_bus_skew_routed.rpt -pb VGA_RAM_bus_skew_routed.pb -rpx VGA_RAM_bus_skew_routed.rpx
2default:defaulth px� 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px� 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px� 


End Record