module ALU_Ctrl( funct_i, ALUOp_i, ALU_operation_o, FURslt_o );

//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALU_operation_o;  
output     [2-1:0] FURslt_o;
     
//Internal Signals
wire		[4-1:0] ALU_operation_o;
wire		[2-1:0] FURslt_o;

//Main function
/*your code here*/
assign ALU_operation_o = 
                ({ALUOp_i,funct_i} == 9'b010_010010) ? 4'b0010 : 	//add
				({ALUOp_i,funct_i} == 9'b010_010000) ? 4'b0110 : 	//sub
				({ALUOp_i,funct_i} == 9'b010_010100) ? 4'b0001 : 	//and
				({ALUOp_i,funct_i} == 9'b010_010110) ? 4'b0000 : 	//or
				({ALUOp_i,funct_i} == 9'b010_010101) ? 4'b1101 : 	//nor
				({ALUOp_i,funct_i} == 9'b010_100000) ? 4'b0111 : 	//slt
				({ALUOp_i,funct_i} == 9'b010_000000) ? 4'b0001 : 	//sll
				({ALUOp_i,funct_i} == 9'b010_000010) ? 4'b0000 :	//srl
                (ALUOp_i == 3'b011) ? 4'b0010 :    //addi	
                (ALUOp_i == 3'b000) ? 4'b0010 :    //lw sw  (add)
                (ALUOp_i == 3'b001) ? 4'b0110 :    //beq (sub)
                (ALUOp_i == 3'b110) ? 4'b0110 : 	//bne (sub)
				(ALUOp_i == 3'b101) ? 4'b0010 : 1'b0; //lui

assign FURslt_o = 
                ({ALUOp_i,funct_i} == 9'b010_000000) ? 1'b1 :      	//sll
			    ({ALUOp_i,funct_i} == 9'b010_000010) ? 1'b1 : 1'b0;	    //srl 
endmodule     
