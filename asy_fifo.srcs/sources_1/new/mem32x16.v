`timescale 1ns / 1ps


module mem32x16(

    input [31:0]    data_in,
    input [3:0]     read_address,     // from control module rd
    input [3:0]     write_address,    // from control module wr
    input           read,             // from control module rd
    input           write,            // from control module wr
    input           read_clk,         
    input           write_clk,
    output [31:0]   data_out 
    ); 
reg [31:0] mem [15:0];    // fifo mem 32*16
reg [31:0] data_out_reg;
assign data_out = data_out_reg;   
    
always@(posedge write_clk)
    if (write)
        mem[write_address] <= data_in;  
    
always@(posedge read_clk)
    if (read)
        data_out_reg <= mem[read_address];    
    else
        data_out_reg <= data_out_reg;
   
endmodule
