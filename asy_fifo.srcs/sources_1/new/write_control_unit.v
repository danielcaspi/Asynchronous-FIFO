`timescale 1ns / 1ps

module write_control_unit(
                             input write_clk,
                             input reset_n,
                             input write_req,
                             input [4:0] read_ptr, 
                             output [4:0] write_ptr,   // control of write ptr 
                             output write,             // and write (to mem)+ full mem(out)
                             output full,
                             output of
                             );
    
reg of_reg;
assign of = of_reg;
reg [4:0] write_ptr_reg;    
assign write_ptr = write_ptr_reg; 
assign full = ((read_ptr[4]^write_ptr_reg[4]) & (read_ptr[3:0] == write_ptr_reg[3:0]))? 1'b1:1'b0;   // full control
assign write = (write_req & (!full)) ? 1'b1:1'b0;         

always@(posedge write_clk or negedge reset_n)
    if(!reset_n)
    begin
        of_reg <= 0;
        write_ptr_reg<=5'b00000;
    end
    else if (write_req && (!full))
    begin
        of_reg <= 0;
        write_ptr_reg<=write_ptr_reg+1;
    end
    else if (write_req && full)
    begin
        of_reg <= 1;
    end
    
endmodule

