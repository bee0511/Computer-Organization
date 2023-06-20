module ALU_1bit( result, carryOut, a, b, invertA, invertB, operation, carryIn, less ); 

  output wire result;
  output wire carryOut;

  input wire a;
  input wire b;
  input wire invertA;
  input wire invertB;
  input wire[1:0] operation;
  input wire carryIn;
  input wire less;

  /*your code here*/ 

  wire mux_a, mux_b, wire_or, wire_and, sum;
  xor U1(mux_a, a, invertA);
  xor U2(mux_b, b, invertB);
  or  U3(wire_or, mux_a, mux_b);
  and U4(wire_and, mux_a, mux_b);
  Full_adder FA(.sum(sum),.carryOut(carryOut),.carryIn(carryIn),.input1(mux_a),.input2(mux_b));

  wire select0, select1, mux_1, mux_2, mux_3, mux_4;
  not U5(select0, operation[0]);
  not U6(select1, operation[1]);
  and mux1(mux_1, wire_or, select1, select0);
  and mux2(mux_2, wire_and, select1, operation[0]);
  and mux3(mux_3, sum, operation[1], select0);
  and mux4(mux_4, less, operation[1], operation[0]);
  or  out(result, mux_1 ,mux_2 , mux_3, mux_4);
endmodule