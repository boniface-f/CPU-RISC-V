`include "../rtl/defines.v" 

module if_id(
	input wire clk,
	input wire rst,
	input wire hold_flag_i,
	input wire [31:0]  inst_i, 
	input wire [31:0]  inst_addr_i,
	output wire[31:0]  inst_addr_o, 
	output wire[31:0]  inst_o
);

	if_id_dff_set #(32) dff1(clk,rst,hold_flag_i,`INST_NOP,inst_i,inst_o);
	
	if_id_dff_set #(32) dff2(clk,rst,hold_flag_i,32'b0,inst_addr_i,inst_addr_o);



endmodule


module if_id_dff_set #(
	parameter DW  = 32
)
(
	input wire clk,
	input wire rst,
	input wire hold_flag_i,
	input wire [DW-1:0]  set_data, 
	input wire [DW-1:0]  data_i, 
	output reg [DW-1:0]  data_o	
);
	always @(posedge clk)begin
		if(rst == 1'b0 || hold_flag_i == 1'b1)
			data_o <= set_data;
		else
			data_o <= data_i;
	end	

endmodule
