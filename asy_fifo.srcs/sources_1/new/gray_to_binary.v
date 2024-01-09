`timescale 1ns / 1ps


module gray_to_binary(
                        input [3:0] gray_in,
                        output [3:0] binary_out
                        );

    wire [3:0] temp;
    genvar i;
    
    assign binary_out = temp;
    assign temp[3] = gray_in[3];
    for ( i = 2 ; i > -1; i = i-1) 
    begin
        assign temp[i] = gray_in[i] ^ temp[i+1] ;                   
    end               
                       
endmodule
