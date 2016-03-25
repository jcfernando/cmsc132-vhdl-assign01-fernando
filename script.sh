#!/bin/bash
ghdl -a t3l-fernando.vhdl
ghdl -a tb_alarm.vhdl
ghdl -e tb_alarm
ghdl -r tb_alarm --vcd=alarm.vcd && gtkwave alarm.vcd
