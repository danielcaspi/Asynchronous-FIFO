`timescale 1ns / 1ps


module sycronaizer_tb();
 reg in_clk;          
 reg out_clk;         
 reg reset_n;         
 reg [3:0] data_in;   
 wire [3:0] data_out;
   
syncronaizer sycronaizer_test (
                               .in_clk(in_clk),          
                               .out_clk(out_clk),         
                               .reset_n(reset_n),         
                               .data_in(data_in),   
                               .data_out(data_out)  
 );
 
initial
begin
    #1 reset_n <= 1'b1;
    #7 reset_n <= 1'b0;
    #20 reset_n <= 1'b1;
end

initial         
begin
    in_clk <= 0;
    forever #10
    in_clk <= !in_clk;
end 
initial         
begin
    out_clk <= 0;
    forever #5
    out_clk <= !out_clk;
end
initial // data in gray
begin
#0 data_in = 4'b0;
#30 data_in = 4'b1100; // 8 in gray
#40 data_in = 4'b1110; //11
end

endmodule
