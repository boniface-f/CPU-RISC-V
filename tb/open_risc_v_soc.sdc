###################################################################

# Created by write_sdc on Fri Mar 10 10:38:54 2023

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
create_clock -name CLK  -period 15  -waveform {0 7.5}
set_input_delay -clock CLK  -max 2  [get_ports clk]
set_input_delay -clock CLK  -max 2  [get_ports rst]
set_drive 0.01  [get_ports rst]
