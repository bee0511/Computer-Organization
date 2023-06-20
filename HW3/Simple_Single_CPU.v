module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles
wire RegDst, RegWrite, ALUSrc;
wire [4-1:0] ALU_operation;
wire [3-1:0] ALUOp;
wire [2-1:0] FURslt; 
wire [5-1:0] instr_wr; 
 

wire [32-1:0] Data_write, Data1_read, Data2_read;
wire [32-1:0] instr, instr_sign_extend, instr_zero, alu_mux;
wire [32-1:0] ALU_result, shifter_result;
wire [32-1:0] PC_Address, PC_instr;

//modules
Program_Counter PC(
        .clk_i(clk_i),      
	.rst_n(rst_n),     
	.pc_in_i(PC_Address),   
	.pc_out_o(PC_instr) 
	);
	
Adder Adder1(
        .src1_i(PC_instr),     
	.src2_i(32'd4),
	.sum_o(PC_Address)    
	);
            	
            	
Instr_Memory IM(
        .pc_addr_i(PC_instr),  
	.instr_o(instr)    
	);

Mux2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr[20:16]),
        .data1_i(instr[15:11]),
        .select_i(RegDst),
        .data_o(instr_wr)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	.rst_n(rst_n),     
        .RSaddr_i(instr[25:21]),  
        .RTaddr_i(instr[20:16]),  
        .RDaddr_i(instr_wr),  
        .RDdata_i(Data_write), 
        .RegWrite_i(RegWrite),
        .RSdata_o(Data1_read),  
        .RTdata_o(Data2_read)   
        );
	
Decoder Decoder(
                .instr_op_i(instr[31:26]), 
	        .RegWrite_o(RegWrite), 
	        .ALUOp_o(ALUOp),   
	        .ALUSrc_o(ALUSrc),   
	        .RegDst_o(RegDst)   
		);

ALU_Ctrl AC(
        .funct_i(instr[5:0]),   
        .ALUOp_i(ALUOp),   
        .ALU_operation_o(ALU_operation),
	.FURslt_o(FURslt)
        );
	
Sign_Extend SE(
        .data_i(instr[15:0]),
        .data_o(instr_sign_extend)
        );

Zero_Filled ZF(
        .data_i(instr[15:0]),
        .data_o(instr_zero)
        );
		
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(Data2_read),
        .data1_i(instr_sign_extend),
        .select_i(ALUSrc),
        .data_o(alu_mux)
        );	
		
ALU ALU(
	.aluSrc1(Data1_read),
	.aluSrc2(alu_mux),
	.ALU_operation_i(ALU_operation),
	.result(ALU_result),
	.zero(),
	.overflow()
        );

Shifter shifter( 
                .result(shifter_result), 
                .leftRight(ALU_operation[0]),
                .shamt(instr[10:6]),
                .sftSrc(alu_mux) 
                );
                
Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(ALU_result),
        .data1_i(shifter_result),
	.data2_i(instr_zero),
        .select_i(FURslt),
        .data_o(Data_write)
        );			

endmodule



