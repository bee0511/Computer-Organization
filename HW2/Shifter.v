module Shifter( result, leftRight, shamt, sftSrc  );
    
  output wire[31:0] result;

  input wire leftRight;
  input wire[4:0] shamt;
  input wire[31:0] sftSrc;
  
  /*your code here*/ 
  
  wire shiftRight;
  wire[29:0] left;
  wire[29:0] right;

  not N1(shiftRight, leftRight);

  and L1(left[0], sftSrc[0], leftRight);
  and L2(left[1], sftSrc[1], leftRight);
  and L3(left[2], sftSrc[2], leftRight);
  and L4(left[3], sftSrc[3], leftRight);
  and L5(left[4], sftSrc[4], leftRight);
  and L6(left[5], sftSrc[5], leftRight);
  and L7(left[6], sftSrc[6], leftRight);
  and L8(left[7], sftSrc[7], leftRight);
  and L9(left[8], sftSrc[8], leftRight);
  and L10(left[9], sftSrc[9], leftRight);
  and L11(left[10], sftSrc[10], leftRight);
  and L12(left[11], sftSrc[11], leftRight);
  and L13(left[12], sftSrc[12], leftRight);
  and L14(left[13], sftSrc[13], leftRight);
  and L15(left[14], sftSrc[14], leftRight);
  and L16(left[15], sftSrc[15], leftRight);
  and L17(left[16], sftSrc[16], leftRight);
  and L18(left[17], sftSrc[17], leftRight);
  and L19(left[18], sftSrc[18], leftRight);
  and L20(left[19], sftSrc[19], leftRight);
  and L21(left[20], sftSrc[20], leftRight);
  and L22(left[21], sftSrc[21], leftRight);
  and L23(left[22], sftSrc[22], leftRight);
  and L24(left[23], sftSrc[23], leftRight);
  and L25(left[24], sftSrc[24], leftRight);
  and L26(left[25], sftSrc[25], leftRight);
  and L27(left[26], sftSrc[26], leftRight);
  and L28(left[27], sftSrc[27], leftRight);
  and L29(left[28], sftSrc[28], leftRight);
  and L30(left[29], sftSrc[29], leftRight);
  and L31(result[31], sftSrc[30], leftRight);

  and R0(result[0], sftSrc[1], shiftRight);
  and R1(right[0], sftSrc[2], shiftRight);
  and R2(right[1], sftSrc[3], shiftRight);
  and R3(right[2], sftSrc[4], shiftRight);
  and R4(right[3], sftSrc[5], shiftRight);
  and R5(right[4], sftSrc[6], shiftRight);
  and R6(right[5], sftSrc[7], shiftRight);
  and R7(right[6], sftSrc[8], shiftRight);
  and R8(right[7], sftSrc[9], shiftRight);
  and R9(right[8], sftSrc[10], shiftRight);
  and R10(right[9], sftSrc[11], shiftRight);
  and R11(right[10], sftSrc[12], shiftRight);
  and R12(right[11], sftSrc[13], shiftRight);
  and R13(right[12], sftSrc[14], shiftRight);
  and R14(right[13], sftSrc[15], shiftRight);
  and R15(right[14], sftSrc[16], shiftRight);
  and R16(right[15], sftSrc[17], shiftRight);
  and R17(right[16], sftSrc[18], shiftRight);
  and R18(right[17], sftSrc[19], shiftRight);
  and R19(right[18], sftSrc[20], shiftRight);
  and R20(right[19], sftSrc[21], shiftRight);
  and R21(right[20], sftSrc[22], shiftRight);
  and R22(right[21], sftSrc[23], shiftRight);
  and R23(right[22], sftSrc[24], shiftRight);
  and R24(right[23], sftSrc[25], shiftRight);
  and R25(right[24], sftSrc[26], shiftRight);
  and R26(right[25], sftSrc[27], shiftRight);
  and R27(right[26], sftSrc[28], shiftRight);
  and R28(right[27], sftSrc[29], shiftRight);
  and R29(right[28], sftSrc[30], shiftRight);
  and R30(right[29], sftSrc[31], shiftRight);

  or  U1(result[1], left[0], right[0]);
  or  U2(result[2], left[1], right[1]);
  or  U3(result[3], left[2], right[2]);
  or  U4(result[4], left[3], right[3]);
  or  U5(result[5], left[4], right[4]);
  or  U6(result[6], left[5], right[5]);
  or  U7(result[7], left[6], right[6]);
  or  U8(result[8], left[7], right[7]);
  or  U9(result[9], left[8], right[8]);
  or  U10(result[10], left[9], right[9]);
  or  U11(result[11], left[10], right[10]);
  or  U12(result[12], left[11], right[11]);
  or  U13(result[13], left[12], right[12]);
  or  U14(result[14], left[13], right[13]);
  or  U15(result[15], left[14], right[14]);
  or  U16(result[16], left[15], right[15]);
  or  U17(result[17], left[16], right[16]);
  or  U18(result[18], left[17], right[17]);
  or  U19(result[19], left[18], right[18]);
  or  U20(result[20], left[19], right[19]);
  or  U21(result[21], left[20], right[20]);
  or  U22(result[22], left[21], right[21]);
  or  U23(result[23], left[22], right[22]);
  or  U24(result[24], left[23], right[23]);
  or  U25(result[25], left[24], right[24]);
  or  U26(result[26], left[25], right[25]);
  or  U27(result[27], left[26], right[26]);
  or  U28(result[28], left[27], right[27]);
  or  U29(result[29], left[28], right[28]);
  or  U30(result[30], left[29], right[29]);
endmodule