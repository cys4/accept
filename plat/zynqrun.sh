#!/bin/sh
set -e
here=`dirname $0`

# A shim for executing binaries on the Zynq hardware.
# Two arguments: the bitstream and the ELF binary.
bit=$1
elf=$2
shift 2

# Destination for the log file.
logdest=zynqlog.txt

source /sampa/share/Xilinx/14.6/14.6/ISE_DS/settings64.sh
LOG_FILE=/sampa/share/thierry/minicom.out
RUN_TCL=$here/zynqtcl/run_benchmark.tcl
PS7_INIT=$here/zynqtcl/ps7_init_111.tcl
SWITCH=zynq

# Power-cycle the board.
echo powering off board
wemo switch $SWITCH off
sleep 3s
echo powering on board
wemo switch $SWITCH on

# Execute the benchmark and collect its log.
truncate $LOG_FILE --size 0
echo invoking board
xmd -tcl $RUN_TCL $bit $PS7_INIT $elf
echo invocation finished
sleep 10s
echo done, collecting log
cp $LOG_FILE $logdest
chmod a-x $logdest
