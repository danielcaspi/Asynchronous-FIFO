`timescale 1ns / 1ps

module binary_to_gray( 
                        input [3:0] binary_in,
                        output [3:0] gray_out
                         );
wire [3:0] temp;
assign temp = {1'b0 , binary_in[3:1]};     // save msb 
assign gray_out = temp ^ binary_in;        // then xor the next bit               
                         
                        
endmodule
