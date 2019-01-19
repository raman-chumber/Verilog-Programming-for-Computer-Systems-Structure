//Majority Program by Ramandeep Chumber
module MajorityMod(A, B, C, F);
   input A, B, C;
   output F;
   wire InvA, InvB, Out1, Out2, Out3;

   not(InvA, A);
   not(InvB, B);
   and(Out1, InvA,    B,    C);
   and(Out2,    A, InvB,    C);
   and(Out3,    A,    B);
   or(F, Out1, Out2, Out3);
endmodule

module TestMod;
   reg A, B, C;
   wire F;

   MajorityMod my_majority(A, B, C, F);

   initial begin
      $monitor("%0d\t%b\t%b\t%b\t%b",
         $time, A, B, C, F);
      $display("Time\tA\tB\tC\tF");
      $display("---------------------------------");
   end

   initial #8 $finish;

   initial begin
      A = 0; B = 0; C = 0; #1;
      A = 0; B = 0; C = 1; #1;
      A = 0; B = 1; C = 0; #1;
      A = 0; B = 1; C = 1; #1;
      A = 1; B = 0; C = 0; #1;
      A = 1; B = 0; C = 1; #1;
      A = 1; B = 1; C = 0; #1;
      A = 1; B = 1; C = 1; #1;
   end
endmodule
