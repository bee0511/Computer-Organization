module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o );
     
//I/O ports
input	[6-1:0] instr_op_i;

output			RegWrite_o;
output	[3-1:0] ALUOp_o;
output			ALUSrc_o;
output			RegDst_o;
 
//Internal Signals
wire	[3-1:0] ALUOp_o;
wire			ALUSrc_o;
wire			RegWrite_o;
wire			RegDst_o;

//Main function
/*your code here*/
assign RegWrite_o = 1;

assign RegDst_o =   (instr_op_i == 6'b000000) ? 1 : 0;	//R = 1, I = 0

assign ALUOp_o =    (instr_op_i == 6'b000000) ? 3'b010 :			//R = 010
			        (instr_op_i == 6'b001000) ? 3'b011 : 3'b000;	//I = 011, idk = 000

assign ALUSrc_o =   (instr_op_i == 6'b000000) ? 0 : 1;	//R = 0, I = 1


endmodule
   