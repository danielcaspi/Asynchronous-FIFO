`timescale 1ns / 1ps


module gray_to_binary(
                        input [4:0] gray_in,
                        output [4:0] binary_out
                        );

    wire [4:0] temp;
    genvar i;
    
    assign binary_out = temp;
    assign temp[4] = gray_in[4];
    for ( i = 3 ; i > -1; i = i-1) 
    begin
        assign temp[i] = gray_in[i] ^ temp[i+1] ;                   
    end               
                       
endmodule
