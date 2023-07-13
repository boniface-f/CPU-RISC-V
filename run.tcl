if {![file isdirectory work]} {
	file mkdir .tb/work
	puts "mkdir work"
} else {
	puts "work exists"
}


define_design_lib work -path ./tb/work

analyze -library work -format verilog {./tb/open_risc_v_soc.v}

elaborate open_risc_v_soc -architecture verilog -library work -update

set_drive 0.01 rst

set_operating_conditions -library sc9mc_logic0040ll_base_rvt_c40_ss_typical_max_1p08v_125c

create_clock -name CLK -period 15
set_dont_touch_network CLK
set_fix_hold CLK

set_input_delay -clock CLK -max -rise 2 [all_inputs]
set_input_delay -clock CLK -max -fall 2 [all_inputs]
set_output_delay -clock CLK -max -rise 3 [all_outputs]
set_output_delay -clock CLK -max -fall 3 [all_outputs]



current_design rom
uplevel #0 compile -map_effort medium -area_effort medium -boundary_optimization -incremental_mapping -exact_map
set_dont_touch rom

current_design open_risc_v
uplevel #0 compile -map_effort medium -area_effort medium -boundary_optimization -incremental_mapping -exact_map
set_dont_touch open_risc_v

current_design open_risc_v_soc
check_design
uplevel #0 compile -map_effort medium -area_effort medium -boundary_optimization -incremental_mapping -exact_map

# -exact_map: this checks that the new synthesized design is functinally
#             equivalent to the original design.
# -boundary_optimization: this opton allows for logic optimization across
#                         module boundaries. For example, if the signal to
#                         an input port of a sub-design is always logic 0,
#                         this optimization can simplify the logic in the 
#                         sub-design.

write -format ddc -hier -out ./tb/open_risc_v_soc.ddc
set test_stil_netlist_format verilog
change_names -rules verilog -hierarchy
write -hierarchy -format verilog -output ./tb/open_risc_v_soc_netlist.v
write_sdf ./tb/open_risc_v_soc.sdf
write_sdc ./tb/open_risc_v_soc.sdc

report_area
#report_timing -path full -delay max -nworst 1 -max_paths 1 -significant_digits 2 -sort_by group

