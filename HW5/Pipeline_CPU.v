module Pipeline_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles
wire [32-1:0] instr, PC_i, PC_o, ReadData1, ReadData2, WriteData;
wire [32-1:0] signextend, zerofilled, ALUinput2, ALUResult, ShifterResult;
wire [5-1:0] WriteReg_addr, Shifter_shamt;
wire [4-1:0] ALU_operation;
wire [3-1:0] ALUOP;
wire [2-1:0] FURslt;
wire [2-1:0] RegDst, MemtoReg;
wire RegWrite, ALUSrc, zero, overflow;
wire Jump, Branch, BranchType, MemWrite, MemRead;
wire [32-1:0] PC_add1, PC_add2, PC_no_jump, PC_t, DM_ReadData;
wire Jr;
wire PCSrc;
wire [5-1:0] Mux_Write_o;
wire [64-1:0] IFID_o;
wire [192-1:0] IDEX_o;
wire [107-1:0] EXMEM_o;
wire [71-1:0] MEMWB_o;
assign Jr = ((instr[31:26] == 6'b000000) && (instr[20:0] == 21'd8)) ? 1 : 0;

//modules
Program_Counter PC(
        .clk_i(clk_i),
        .rst_n(rst_n),
        .pc_in_i(PC_i),
        .pc_out_o(PC_o)
        );

Adder Adder1(
        .src1_i(PC_o), 
	.src2_i(32'd4),
	.sum_o(PC_add1)
	);

		
Adder Adder2(
        .src1_i(IDEX_o[148:117]),
	.src2_i({IDEX_o[50:21], 2'b00}),
	.sum_o(PC_add2)
	);

and And(PCSrc, EXMEM_o[104], EXMEM_o[69]);

Mux2to1 #(.size(32)) Mux_branch(
        .data0_i(PC_add1),
        .data1_i(EXMEM_o[101:70]),
        .select_i(PCSrc),
        .data_o(PC_i)
        );

Instr_Memory IM(
        .pc_addr_i(PC_o),
        .instr_o(instr)
        );

Pipeline_Reg #(.size(64)) IFID( 
        .clk_i(clk_i),
	.rst_n(rst_n),
        .data_i({PC_add1, instr}),
        .data_o(IFID_o)
        );

Reg_File RF(
        .clk_i(clk_i),
	.rst_n(rst_n),
        .RSaddr_i(IFID_o[25:21]),
        .RTaddr_i(IFID_o[20:16]),
        .Wrtaddr_i(MEMWB_o[4:0]),
        .Wrtdata_i(WriteData),
        .RegWrite_i(MEMWB_o[70]),
        .RSdata_o(ReadData1),
        .RTdata_o(ReadData2)
        );

Decoder Decoder(
        .instr_op_i(IFID_o[31:26]),
        .RegWrite_o(RegWrite),
        .ALUOp_o(ALUOP),
        .ALUSrc_o(ALUSrc),
        .RegDst_o(RegDst),
        .Jump_o(Jump),
        .Branch_o(Branch),
        .BranchType_o(BranchType),
        .MemWrite_o(MemWrite),
        .MemRead_o(MemRead),
        .MemtoReg_o(MemtoReg)
        );

ALU_Ctrl AC(
        .funct_i(IDEX_o[5:0]),
        .ALUOp_i(IDEX_o[152:150]), 
        .ALU_operation_o(ALU_operation),
	.FURslt_o(FURslt)
        );

	
Sign_Extend SE(
        .data_i(IFID_o[15:0]),
        .data_o(signextend)
        );

		
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(IDEX_o[84:53]),
        .data1_i(IDEX_o[52:21]),
        .select_i(IDEX_o[149]),
        .data_o(ALUinput2)
        );	


Pipeline_Reg #(.size(160)) IDEX( 
        .clk_i(clk_i),
	.rst_n(rst_n),
        .data_i({RegWrite, MemtoReg[0], Branch, MemRead, MemWrite, 
                 RegDst[0], BranchType, ALUOP[2:0], ALUSrc,
                 IFID_o[64-1:32], ReadData1, ReadData2, 
                 signextend, IFID_o[20:0]}),
        .data_o(IDEX_o)
        );

ALU ALU(
        .aluSrc1(IDEX_o[116:85]),
        .aluSrc2(ALUinput2),
        .ALU_operation_i(ALU_operation),
        .result(ALUResult),
        .zero(zero),
        .overflow(overflow)
        );



Mux2to1 #(.size(5)) Mux_write(
        .data0_i(IDEX_o[20:16]),
        .data1_i(IDEX_o[15:11]),
        .select_i(IDEX_o[154]),
        .data_o(Mux_Write_o)
        );			

Pipeline_Reg #(.size(107)) EXMEM(
        .clk_i(clk_i),
	.rst_n(rst_n),
        .data_i({IDEX_o[159:155], PC_add2, zero,
                 ALUResult, IDEX_o[84:53], Mux_Write_o}),
        .data_o(EXMEM_o)
        );

Data_Memory DM(
        .clk_i(clk_i),
        .addr_i(EXMEM_o[68:37]),
        .data_i(EXMEM_o[36:5]),
        .MemRead_i(EXMEM_o[103]),
        .MemWrite_i(EXMEM_o[102]),
        .data_o(DM_ReadData)
        );

Pipeline_Reg #(.size(71)) MEMWB( 
        .clk_i(clk_i),
	.rst_n(rst_n),
        .data_i({EXMEM_o[106:105], DM_ReadData, EXMEM_o[68:37], EXMEM_o[4:0]}),
        .data_o(MEMWB_o)
        );


Mux2to1 #(.size(32)) Mux_Write( 
        .data1_i(MEMWB_o[68:37]),
        .data0_i(MEMWB_o[36:5]),
        .select_i(MEMWB_o[69]),
        .data_o(WriteData)
        );

endmodule



