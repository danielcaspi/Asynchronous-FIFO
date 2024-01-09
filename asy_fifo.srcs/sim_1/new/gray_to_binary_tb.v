`timescale 1ns / 1ps

module gray_to_binary_tb();

                                                   
reg  [3:0] gray_in;                                                
wire [3:0] binary_out; 
gray_to_binary gray_to_binary_test(                                                   
                                       .gray_in(gray_in),                                                
                                       .binary_out(binary_out)                     
                                     );                          
 initial
 begin 
 #1 gray_in<=4'd0;
 #10 gray_in<=4'd1;
 #20 gray_in<=4'd2;
 #30 gray_in<=4'd3;
 #40 gray_in<=4'd4;
 #50 gray_in<=4'd5;
 #60 gray_in<=4'd6;
 #70 gray_in<=4'd7;
 #80 gray_in<=4'd8;
 #90 gray_in<=4'd9;
 #100 gray_in<=4'd10;
 #110 gray_in<=4'd11;
 #120 gray_in<=4'd12;
 #130 gray_in<=4'd13;
 #140 gray_in<=4'd14;
 #150 gray_in<=4'd15;
end                                    



endmodule
