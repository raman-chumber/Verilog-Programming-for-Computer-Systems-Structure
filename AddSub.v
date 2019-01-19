//AddSub.v, 205 Verilog Programming Assignment #2
//add/subtract, 5 bits
//Ramandeep Chumber
module tester;
   parameter plus_sign = 43; // '+' has ASCII 43
   parameter minus_sign = 45; // '-' has ASCII 43
   parameter STDIN = 32'h8000_0000; // keyboard input

   reg [7:0] str [1:3]; // typing in, 2 chars per entry
   reg [4:0] X, Y;      // 4-bit X, Y
   reg C0;              // set 0/1 to do add/subtract
   wire C4, C5, E;      // like to show these also from big module
   wire [4:0] S;        // 4-bit Sum (or difference)

   ASMod myAddSub(C0, X, Y, S, C4, C5, E);

   initial begin
      $display("Enter X (range 00 ~ 15): ");
      str[1] = $fgetc(STDIN); // X[1]
      str[2] = $fgetc(STDIN); // X[0]
      str[3] = $fgetc(STDIN); // enter key
      X = (str[1] - 48) * 10 + str[2] - 48;

      $display("Enter Y (range 00 ~ 15): ");
      str[1] = $fgetc(STDIN); // Y[1]
      str[2] = $fgetc(STDIN); // Y[0]
      str[3] = $fgetc(STDIN); // enter key
      Y = (str[1] - 48) * 10 + str[2] - 48;

      $display("Enter '+' or '-': ");
      str[1] = $fgetc(STDIN); // which
      str[2] = $fgetc(STDIN); // enter key

      if (str[1] == plus_sign) C0 = 0; else C0 = 1;

      #2; // wait until add/sub done

      $display("X=%b (%d) Y=%b (%d) C0=%b", X, X, Y, Y, C0);
      $display("Result=%b (as unsigned %d)", S, S);
      $display("C4=%b C5=%b E=%b", C4, C5, E);

      if(E == 0) $display("Since E is 0, C5 is not needed.");
      else $display("Since E is 1, correct with C5 in front: %b%b", C5, S);
         end
endmodule

  module ASMod(C0, X, Y, S, C4, C5, E);
   input C0;
   input [4:0] X, Y;
   output [4:0] S;
   output C4, C5, E;

   wire C1, C2, C3;  // addtional carry-out wires
   wire [4:0] xorY;  // xor-ed Y bits

   xor(E, C4, C5);   // put E upfront

   xor( xorY[0], C0, Y[0] ); // xor Y bits
   xor( xorY[1], C0, Y[1] );
   xor( xorY[2], C0, Y[2] );
   xor( xorY[3], C0, Y[3] );
   xor( xorY[4], C0, Y[4] );

   FullAdderMod FA0( X[0], xorY[0], C0, S[0], C1 ); // each full adder
   FullAdderMod FA1( X[1], xorY[1], C1, S[1], C2 );
   FullAdderMod FA2( X[2], xorY[2], C2, S[2], C3 );
   FullAdderMod FA3( X[3], xorY[3], C3, S[3], C4 );
   FullAdderMod FA4( X[4], xorY[4], C4, S[4], C5 );
 endmodule

module FullAdderMod(x, y, z, S, C); // single-bit adder
   input x, y, z;         // x y z (carry-in)
   output S, C;           // sum carry-out

   wire and0, and1, xor0; // additional wires

   and(and0, x, y);
   and(and1, xor0, z);
   or(C, and0, and1);     // carry-out

   xor(xor0, x, y);
   xor(S, z, xor0);       // sum bit
endmodule

