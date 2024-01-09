`timescale 1ns / 1ps

module binary_to_gray_tb();
reg [3:0] binary_in;
wire [3:0] gray_out;
binary_to_gray binary_to_gray_write (                        
                                          .binary_in(binary_in),
                                          .gray_out(gray_out) 
                                      );  
 initial
 begin 
 #1 binary_in<=4'd0;
 #10 binary_in<=4'd1;
 #20 binary_in<=4'd2;
 #30 binary_in<=4'd3;
 #40 binary_in<=4'd4;
 #50 binary_in<=4'd5;
 #60 binary_in<=4'd6;
 #70 binary_in<=4'd7;
 #80 binary_in<=4'd8;
 #90 binary_in<=4'd9;
 #100 binary_in<=4'd10;
 #110 binary_in<=4'd11;
 #120 binary_in<=4'd12;
 #130 binary_in<=4'd13;
 #140 binary_in<=4'd14;
 #150 binary_in<=4'd15;
end
                                    
                                      
                                      
                                      
                                      
                                      
                                      
                                      
endmodule
