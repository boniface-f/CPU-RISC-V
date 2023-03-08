`include "../rtl/defines.v"

module if_id(
	input wire clk,
	input wire rst,
	input wire [31:0]  inst_i, 
	input wire [31:0]  inst_addr_i,
	output wire[31:0]  inst_addr_o, 
	output wire[31:0]  inst_o
);

	if_id_dff_set #(32) dff11(clk,rst,`INST_NOP,inst_i,inst_o);
	
	if_id_dff_set #(32) dff21(clk,rst,32'b0,inst_addr_i,inst_addr_o);

endmodule

module if_id_dff_set #(
	parameter DW  = 32
)
(
	input wire clk,
	input wire rst,
	input wire [DW-1:0]  set_data, 
	input wire [DW-1:0]  data_i, 
	output reg [DW-1:0]  data_o	
);
	always @(posedge clk)begin
		if(rst == 1'b0)
			data_o <= set_data;
		else
			data_o <= data_i;
	end	

endmodule
