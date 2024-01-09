`timescale 1ns / 1ps


module read_control_unit(
    
                             input read_clk,
                             input reset_n,
                             input read_req,
                             input [3:0] write_ptr, 
                             output [3:0] read_ptr,   // control of read ptr 
                             output read,             // and read (to mem)+ empty(out)
                             output empty,
                             output uf
                             );
reg uf_reg;
assign uf = uf_reg;
reg [3:0] read_ptr_reg;    
assign read_ptr = read_ptr_reg; 
assign empty = (read_ptr_reg == write_ptr)? 1'b1:1'b0;   // empty control
assign read = read_req;    

always@(posedge read_clk or negedge reset_n)    // read ptr control
    if (!reset_n)
    begin
        read_ptr_reg <= 4'b0000;
        uf_reg <= 0;
    end
    else if (read_req && (!empty))
    begin
        read_ptr_reg <= read_ptr_reg +1; 
        uf_reg <= 0;
    end
    else if (read_req && empty)
    begin
        uf_reg <= 1;
    end
   
endmodule
