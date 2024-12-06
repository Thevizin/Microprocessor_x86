#include<ArquivoBinario>

module reader_binary(input clk, reset, output reg [3:0] sum, reg [3:0] diff, reg [3:0] result, reg op_done);
  reg[3:0] operation;
  reg[3:0] A, B;
  
  reg[23:0] memory [5:0]
  integer i;
  
  wire [3:0] sum_result;
  wire sum_cout;
  
  wire [3:0] diff_result;
  wire diff_bout;
  
  full_adder adder_inst (
    .c_out(sum_cout),
    .sum(sum_result),
    .a(A),
    .b(B),
    .cin(1'b0)
  );
  
  full_subtractor subtractor_inst (
    .bout(diff_bout),
    .diff(diff_result),
    .a(A),
    .b(B),
    .bin(1'b0) 
  );
  
 initial
   begin
     $readmemb("ArquivoBinario.wb", memory);
     op_done = 0;
     i = 0;
   end
  while(! $feof(memory)) begin
    
  end
endmodule

module add_half(output wire c_out, sum, input wire a, b);
  xor (sum, a, b);
  and (c_out, a, b);
endmodule 

module full_adder(output wire c_out, sum, input wire a, b, cin)/
  wire ha1_sum, ha1_cout, ha2_cout;
  add_half A(.c_out(ha1_cout), .sum(ha1_sum), .a(a), .b(b));
  add_half B(.c_out(ha2_cout), .sum(sum), .a(ha1_sum), .b(cin));
  or (c_out, ha1_cout, ha2_cout);
endmodule

module half_subtractor (output wire diff, bout, input wire a, b);
    xor (diff, a, b);   
    and (bout, ~a, b);   
endmodule

module full_subtractor (output wire diff, bout,  input wire a, b, bin);
    wire hs1_diff, hs1_bout, hs2_bout;
	half_subtractor HS1 (.diff(hs1_diff), .bout(hs1_bout), .a(a), .b(b));
  	half_subtractor HS2 (.diff(diff), .bout(hs2_bout), .a(hs1_diff), .b(bin));
    or (bout, hs1_bout, hs2_bout);
endmodule
