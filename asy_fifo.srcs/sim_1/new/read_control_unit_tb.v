`timescale 1ns / 1ps


module read_control_unit_tb(  );

 reg read_clk;        
 reg reset_n;        
 reg read_req;        
 reg [3:0] write_ptr; 
 wire [3:0] read_ptr; 
 wire  read;           
 wire empty;           
          

read_control_unit read_control_unit_test(
                                            .read_clk(read_clk),           
                                            .reset_n(reset_n),                
                                            .read_req(read_req),              
                                            .write_ptr(write_ptr),        
                                            .read_ptr(read_ptr),       
                                            .read(read),          
                                            .empty(empty)          
                                           
                                          );
initial
begin
    #1 reset_n <= 1'b1;
    #3 reset_n <= 1'b0;
    #20 reset_n <= 1'b1;
end

initial         //clk write
begin
    read_clk <= 0;
    forever #10
    read_clk <= !read_clk;
end
initial 
begin 
read_req<=0;
forever #15
read_req <= !read_req;       
end
initial
begin
     #1 write_ptr<=4'd0;
     #10 write_ptr<=4'd1;
     #20 write_ptr<=4'd2;
     #30 write_ptr<=4'd3;
     #40 write_ptr<=4'd4;
     #50 write_ptr<=4'd5;
     #60 write_ptr<=4'd6;
     #70 write_ptr<=4'd7;
     #80 write_ptr<=4'd8;
     #90 write_ptr<=4'd9;
     #100 write_ptr<=4'd10;
     #110 write_ptr<=4'd11;
     #120 write_ptr<=4'd12;
     #130 write_ptr<=4'd13;
     #140 write_ptr<=4'd14;
     #150 write_ptr<=4'd15;
end


endmodule
