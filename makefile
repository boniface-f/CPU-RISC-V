all:
	vlib work
	vlog rtl/open_risc_v_soc.v
	vlog tb/tb.v
	vsim -novopt tb
	
post:
	vlog open_risc_v_soc_netlist.v
	vlog library/sc9mc_logic0040ll_base_hvt_c50.v
	vlog tb/tb.v
	vsim -novopt tb
	
clean:
	rm -rf *.log *.svf *.ddc *.sdc *.sdf* *.key xcelium.d waves.shm work *.mpf *.wlf *.cr.mti *.v
