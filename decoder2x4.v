//2x4 Decoder by Ramandeep Chumber

module Decoder(s1, s0, o0, o1, o2, o3);
input s1, s0;
output o0, o1, o2, o3;
wire s1_inv, s0_inv;

not(s1_inv, s1);
not(s0_inv, s0);
and(o0, s1_inv, s0_inv);
and(o1, s1_inv, s0);
and(o2, s1, s0_inv);
and(o3, s1, s0);
endmodule

module TestMod;

reg s1, s0;
wire o0, o1, o2, o3;

Decoder dec(s1, s0, o0, o1, o2, o3);

initial begin
$display("Time \t s1 \t s0 \t o0 \t o1 \t o2 \t o3");
$display("------------------------------------------------");
$monitor("%0d \t %b \t %b \t %b \t %b \t %b \t %b", $time, s1, s0, o0, o1, o2, o3);
end

initial #3 $finish;

initial begin
s1= 0; s0= 0;
#1;
s1= 0; s0= 1;
#1;
s1= 1; s0= 0;
#1;
s1= 1; s0= 1;
end
endmodule