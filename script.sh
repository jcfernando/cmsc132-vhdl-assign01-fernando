#!/bin/bash
ghdl -a alarm_behav.vhdl
ghdl -a tb_alarm.vhdl
ghdl -e tb_alarm
ghdl -r tb_alarm --vcd=priority.vcd && gtkwave priority.vcd
