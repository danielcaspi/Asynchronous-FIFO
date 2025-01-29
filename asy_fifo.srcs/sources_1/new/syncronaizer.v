`timescale 1ns / 1ps


module syncronaizer(
                        input in_clk,
                        input out_clk,
                        input reset_n,
                        input [4:0] data_in,
                        output [4:0] data_out
    );
reg [4:0] data_in_reg;    
reg [4:0] data_out_reg;    
reg [4:0] data_tmp_reg;    
assign data_out =  data_out_reg;
  
always@(posedge in_clk or negedge reset_n) // clk_in
    if(!reset_n)   
        data_in_reg<=0;
    else
        data_in_reg <= data_in;


always@(posedge out_clk or negedge reset_n) // clk_out
    if(!reset_n)
    begin
        data_tmp_reg <=5'b0;
        data_out_reg <= 5'b0;
    end
    else
    begin
        data_tmp_reg <=data_in_reg;       
        data_out_reg <= data_tmp_reg; 
     end




    
    
endmodule
