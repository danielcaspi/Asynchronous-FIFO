`timescale 1ns / 1ps

module write_control_unit(
                             input write_clk,
                             input reset_n,
                             input write_req,
                             input [3:0] read_ptr, 
                             output [3:0] write_ptr,   // control of write ptr 
                             output write,             // and write (to mem)+ full mem(out)
                             output full,
                             output of
                             );
    
reg of_reg;
assign of = of_reg;
reg [3:0] write_ptr_reg;    
wire [3:0] inc;
assign write_ptr = write_ptr_reg;
assign inc = write_ptr_reg + 1;   
assign full = (read_ptr == inc)? 1'b1:1'b0;   // full control
assign write = write_req;        

always@(posedge write_clk or negedge reset_n)
    if(!reset_n)
    begin
        of_reg <= 0;
        write_ptr_reg<=4'b0000;
    end
    else if (write && (!full))
    begin
        of_reg <= 0;
        write_ptr_reg<=write_ptr_reg+1;
    end
    else if (write && full)
    begin
        of_reg <= 1;
    end
    
endmodule










