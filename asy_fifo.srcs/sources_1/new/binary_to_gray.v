`timescale 1ns / 1ps

module binary_to_gray( 
                        input [4:0] binary_in,
                        output [4:0] gray_out
                         );
wire [4:0] temp;
assign temp = {1'b0 , binary_in[4:1]};     // save msb 
assign gray_out = temp ^ binary_in;        // then xor the next bit               
                         
                        
endmodule
