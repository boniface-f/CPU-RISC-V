// `include "open_risc_v_soc.v"
`include "./open_risc_v_soc_netlist.v"
`timescale 1ns / 1ns

module testbench;

	reg clk;
	reg rst;
	
	
	wire x3 = tb.open_risc_v_soc_netlist_inst.open_risc_v_inst.regs_inst.regs[3];
	wire x26 = tb.open_risc_v_soc_netlist_inst.open_risc_v_inst.regs_inst.regs[26];
	wire x27 = tb.open_risc_v_soc_netlist_inst.open_risc_v_inst.regs_inst.regs[27];
	
	
	always #10 clk = ~clk;
	
	initial begin
		clk <= 1'b1;
		rst <= 1'b0;
		#30;
		rst <= 1'b1;	
	end
	
	//rom 初始值
	initial begin
		$readmemh("./inst_txt/rv32ui-p-blt.txt",tb.open_risc_v_soc_netlist_inst.rom_inst.rom_mem);  	//modelsim
	end

	integer r;
	initial begin
		wait(x26 == 32'b1);
		
		#200;
		if(x27 == 32'b1) begin
			$display("############################");
			$display("########  pass  !!!#########");
			$display("############################");
		end
		else begin
			$display("############################");
			$display("########  fail  !!!#########");
			$display("############################");
			$display("fail testnum = %2d", x3);
			for(r = 0;r < 31; r = r + 1)begin
				$display("x%2d register value is %d",r,tb.open_risc_v_soc_netlist_inst.open_risc_v_inst.regs_inst.regs[r]);	
			end	
		end
		$finish();
	end
	

	open_risc_v_soc_netlist open_risc_v_soc_netlist_inst(
		.clk   		(clk),
		.rst 		(rst)
	);
	


	
endmodule