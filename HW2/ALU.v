`timescale 1ns / 1ps
module ALU( result, zero, overflow, aluSrc1, aluSrc2, invertA, invertB, operation );
   
  output wire[31:0] result;
  output wire zero;
  output wire overflow;

  input wire[31:0] aluSrc1;
  input wire[31:0] aluSrc2;
  input wire invertA;
  input wire invertB;
  input wire[1:0] operation;
  
  /*your code here*/

  wire[31:0] carryOut;
  wire set;
  wire carryOutTemp;
  wire overflowTemp;
  nor Zero(zero, result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15], result[16], result[17], result[18], result[19], result[20], result[2], result[21], result[22], result[23], result[24], result[25], result[26], result[27], result[28], result[29], result[30], result[31]);
  xor OverflowTemp(overflowTemp, carryOut[30], carryOut[31]);
  and Overflow(overflow, overflowTemp, operation[1]);
  xor Mux1(mux_a, aluSrc1[31], invertA);
  xor Mux2(mux_b, aluSrc2[31], invertB);
  Full_adder FA(set, carryOutTemp, carryOut[30], mux_a, mux_b);

  ALU_1bit ALU0( .result(result[0]), .carryOut(carryOut[0]), .a(aluSrc1[0]), .b(aluSrc2[0]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(invertB), .less(set));
  ALU_1bit ALU1( .result(result[1]), .carryOut(carryOut[1]), .a(aluSrc1[1]), .b(aluSrc2[1]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[0]), .less(1'b0));
  ALU_1bit ALU2( .result(result[2]), .carryOut(carryOut[2]), .a(aluSrc1[2]), .b(aluSrc2[2]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[1]), .less(1'b0));
  ALU_1bit ALU3( .result(result[3]), .carryOut(carryOut[3]), .a(aluSrc1[3]), .b(aluSrc2[3]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[2]), .less(1'b0));
  ALU_1bit ALU4( .result(result[4]), .carryOut(carryOut[4]), .a(aluSrc1[4]), .b(aluSrc2[4]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[3]), .less(1'b0));
  ALU_1bit ALU5( .result(result[5]), .carryOut(carryOut[5]), .a(aluSrc1[5]), .b(aluSrc2[5]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[4]), .less(1'b0));
  ALU_1bit ALU6( .result(result[6]), .carryOut(carryOut[6]), .a(aluSrc1[6]), .b(aluSrc2[6]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[5]), .less(1'b0));
  ALU_1bit ALU7( .result(result[7]), .carryOut(carryOut[7]), .a(aluSrc1[7]), .b(aluSrc2[7]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[6]), .less(1'b0));
  ALU_1bit ALU8( .result(result[8]), .carryOut(carryOut[8]), .a(aluSrc1[8]), .b(aluSrc2[8]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[7]), .less(1'b0));
  ALU_1bit ALU9( .result(result[9]), .carryOut(carryOut[9]), .a(aluSrc1[9]), .b(aluSrc2[9]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[8]), .less(1'b0));
  ALU_1bit ALU10( .result(result[10]), .carryOut(carryOut[10]), .a(aluSrc1[10]), .b(aluSrc2[10]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[9]), .less(1'b0));
  ALU_1bit ALU11( .result(result[11]), .carryOut(carryOut[11]), .a(aluSrc1[11]), .b(aluSrc2[11]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[10]), .less(1'b0));
  ALU_1bit ALU12( .result(result[12]), .carryOut(carryOut[12]), .a(aluSrc1[12]), .b(aluSrc2[12]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[11]), .less(1'b0));
  ALU_1bit ALU13( .result(result[13]), .carryOut(carryOut[13]), .a(aluSrc1[13]), .b(aluSrc2[13]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[12]), .less(1'b0));
  ALU_1bit ALU14( .result(result[14]), .carryOut(carryOut[14]), .a(aluSrc1[14]), .b(aluSrc2[14]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[13]), .less(1'b0));
  ALU_1bit ALU15( .result(result[15]), .carryOut(carryOut[15]), .a(aluSrc1[15]), .b(aluSrc2[15]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[14]), .less(1'b0));
  ALU_1bit ALU16( .result(result[16]), .carryOut(carryOut[16]), .a(aluSrc1[16]), .b(aluSrc2[16]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[15]), .less(1'b0));
  ALU_1bit ALU17( .result(result[17]), .carryOut(carryOut[17]), .a(aluSrc1[17]), .b(aluSrc2[17]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[16]), .less(1'b0));
  ALU_1bit ALU18( .result(result[18]), .carryOut(carryOut[18]), .a(aluSrc1[18]), .b(aluSrc2[18]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[17]), .less(1'b0));
  ALU_1bit ALU19( .result(result[19]), .carryOut(carryOut[19]), .a(aluSrc1[19]), .b(aluSrc2[19]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[18]), .less(1'b0));
  ALU_1bit ALU20( .result(result[20]), .carryOut(carryOut[20]), .a(aluSrc1[20]), .b(aluSrc2[20]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[19]), .less(1'b0));
  ALU_1bit ALU21( .result(result[21]), .carryOut(carryOut[21]), .a(aluSrc1[21]), .b(aluSrc2[21]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[20]), .less(1'b0));
  ALU_1bit ALU22( .result(result[22]), .carryOut(carryOut[22]), .a(aluSrc1[22]), .b(aluSrc2[22]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[21]), .less(1'b0));
  ALU_1bit ALU23( .result(result[23]), .carryOut(carryOut[23]), .a(aluSrc1[23]), .b(aluSrc2[23]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[22]), .less(1'b0));
  ALU_1bit ALU24( .result(result[24]), .carryOut(carryOut[24]), .a(aluSrc1[24]), .b(aluSrc2[24]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[23]), .less(1'b0));
  ALU_1bit ALU25( .result(result[25]), .carryOut(carryOut[25]), .a(aluSrc1[25]), .b(aluSrc2[25]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[24]), .less(1'b0));
  ALU_1bit ALU26( .result(result[26]), .carryOut(carryOut[26]), .a(aluSrc1[26]), .b(aluSrc2[26]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[25]), .less(1'b0));
  ALU_1bit ALU27( .result(result[27]), .carryOut(carryOut[27]), .a(aluSrc1[27]), .b(aluSrc2[27]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[26]), .less(1'b0));
  ALU_1bit ALU28( .result(result[28]), .carryOut(carryOut[28]), .a(aluSrc1[28]), .b(aluSrc2[28]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[27]), .less(1'b0));
  ALU_1bit ALU29( .result(result[29]), .carryOut(carryOut[29]), .a(aluSrc1[29]), .b(aluSrc2[29]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[28]), .less(1'b0));
  ALU_1bit ALU30( .result(result[30]), .carryOut(carryOut[30]), .a(aluSrc1[30]), .b(aluSrc2[30]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[29]), .less(1'b0));
  ALU_1bit ALU31( .result(result[31]), .carryOut(carryOut[31]), .a(aluSrc1[31]), .b(aluSrc2[31]), .invertA(invertA), .invertB(invertB), .operation(operation), .carryIn(carryOut[30]), .less(1'b0));
  
endmodule