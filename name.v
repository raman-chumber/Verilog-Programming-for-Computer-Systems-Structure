// name.v
// // shift registers and encode, to count (ripple counter)
// Ramandeep Chumber

module TestMod;
   reg clk;
   wire [0:17] Q;
   wire [6:0] name;

   initial begin
      #1;
      forever begin // this is clock wave
         clk = 0;  // 0 for half cycle (#1)
         #1;
         clk = 1;  // 1 for half cycle (#1)
         #1;
      end
   end

 RippleMod rMod(clk, Q);
 EncoderMod eMod(Q, name);

  initial #34

  $finish;

   initial begin
     $display("Time CLK    Q       Name");
      $monitor("%4d   %b    %b   %c", $time, clk, Q, name);
   end
endmodule

module EncoderMod(Q, name); // reverse 2x4 decoder
   input [0:17]Q;   // input unary bits
   output [6:0]name;   // coded binary bits

//                 6 5 4 3 2 1 0
//       //Q[0] R= 1 0 1 0 0 1 0;
//       //Q[1] a= 1 1 0 0 0 0 1;
//       //Q[2] m= 1 1 0 1 1 0 1;
//       //Q[3] a= 1 1 0 0 0 0 1;       
//       //Q[4] n= 1 1 0 1 1 1 0;
//       //Q[5] d= 1 1 0 0 1 0 0;
//       //Q[6] e= 1 1 0 0 1 0 1;       
//       //Q[7] e= 1 1 0 0 1 0 1;
//       //Q[8] p= 1 1 1 0 0 0 0;
//       //Q[9]  = 0 1 0 0 0 0 0;                        
//       //Q[10]C= 1 0 0 0 0 1 1;
//       //Q[11]h= 1 1 0 1 0 0 0;
//       //Q[12]u= 1 1 1 0 1 0 1;
//       //Q[13]m= 1 1 0 1 1 0 1;                
//       //Q[14]b= 1 1 0 0 0 1 0;
//       //Q[15]e= 1 1 0 0 1 0 1;
//       //Q[16]r= 1 1 1 0 0 1 0;
//       //Q[17]=  0 1 0 0 0 0 0;
   or(name[6], Q[0], Q[1], Q[2], Q[3], Q[4], Q[5], Q[6], Q[7], Q[8], Q[10], Q[11], Q[12], Q[13], Q[14], Q[15], Q[16]);
   or(name[5], Q[1], Q[2], Q[3], Q[4], Q[5], Q[6], Q[7], Q[8], Q[9], Q[11], Q[12], Q[13], Q[14], Q[15], Q[16], Q[17]);
   or(name[4], Q[0], Q[8], Q[12], Q[16]);
   or(name[3], Q[2], Q[4], Q[11], Q[13]);
   or(name[2], Q[2], Q[4], Q[5], Q[6], Q[7], Q[12], Q[13], Q[15]);
   or(name[1], Q[0], Q[4], Q[10], Q[14], Q[16]);
   or(name[0], Q[1], Q[2], Q[3], Q[6], Q[7], Q[10], Q[12], Q[13], Q[15]);
endmodule

module RippleMod (CLK, Q);
   input CLK;
   output [0:17]Q;

   reg [0:17]Q;
   always @(CLK) begin // same as: always @(posedge CLK or negedge) begin
     Q[0] <= Q[17];   // as clk changes (edge changes either up or down)
      Q[1] <= Q[0];   // <= is concurrent transfer
      Q[2] <= Q[1];   // right side of <= is current
      Q[3] <= Q[2];   // left side of <= is future
      Q[4] <= Q[3];
      Q[5] <= Q[4];
      Q[6] <= Q[5];
      Q[7] <= Q[6];
      Q[8] <= Q[7];
      Q[9] <= Q[8];
      Q[10] <= Q[9];
      Q[11] <= Q[10];
      Q[12] <= Q[11];
      Q[13] <= Q[12];
      Q[14] <= Q[13];
      Q[15] <= Q[14];
      Q[16] <= Q[15];
      Q[17] <= Q[16];
end
        initial Q = 18'b10_0000_0000_0000_0000;    //Sequence begins
endmodule