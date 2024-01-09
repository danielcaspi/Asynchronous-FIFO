`timescale 1ns / 1ps


module asy_fifo_TB();

reg reset_i;           
reg clk_write_i;       
reg clk_read_i;        
reg write_req_i;       
reg read_req_i;        
reg [31:0] data_in_i;  
wire [31:0] data_out_o;
wire empty_o;          
wire full_o;
wire uf_i;
wire of_i;            

asy_fifo asy_fifo_test(
                       .reset_i(reset_i),           
                       .clk_write_i(clk_write_i),       
                       .clk_read_i(clk_read_i),        
                       .write_req_i(write_req_i),       
                       .read_req_i(read_req_i),        
                       .data_in_i(data_in_i),  
                       .data_out_o(data_out_o),
                       .empty_o(empty_o),          
                       .full_o(full_o),
                       .uf_i(uf_i),
                       .of_i(of_i)  
                       );          

initial
begin
    #1 reset_i <= 1'b1;
    #3 reset_i <= 1'b0;
    #20 reset_i <= 1'b1;

end

initial         //clk write
begin
    clk_write_i <= 0;
    forever #7.5
    clk_write_i <= !clk_write_i;
end

initial         // clk read
begin
    clk_read_i <= 0;
    forever #10
    clk_read_i <= !clk_read_i;
end   

// running time
parameter write_time = 2000;
parameter read_time = 4000;
parameter end_time = 6000;

always @ (posedge clk_write_i or posedge clk_read_i or negedge reset_i)
begin
    if (!reset_i)
        begin
        data_in_i <= 0;
        write_req_i <= 0;
        read_req_i <= 0;
        end
    else
           begin
           if ($time < write_time)
                begin
                data_in_i <= $random();
                write_req_i <= $random();
                read_req_i <= 0;
                end
           else if ((write_time < $time) && ($time < read_time))
                begin
                data_in_i <= $random();
                write_req_i <= $random();
                read_req_i <= $random();
                end
           else  
                begin
                data_in_i <= $random();
                write_req_i <= 0;
                read_req_i <= $random();
                end
           end     
 end           
    
 // checkers
 reg of_checker=0;
 reg uf_checker=0;
 
 always@(posedge of_i)
    if (!of_checker)
    begin  
        of_checker<= 1;
        $display($time,"ns first OF check"); 
     end   
 always@(posedge uf_i)
    if (!uf_checker)
    begin  
        uf_checker<= 1;
        $display($time,"ns first UF check"); 
     end     
  
// write into text file     
integer data_in_file_open;
integer data_out_file_open;

initial
begin
    data_in_file_open = $fopen("data_in_file.txt");   
    data_out_file_open = $fopen("data_out_file.txt"); 
end    
integer number = 0; // integer of semple
    
always@(posedge clk_write_i )
    if( write_req_i && (!full_o))
    begin
        $fdisplay(data_in_file_open,"%h", data_in_i);
        number = number+1;
    end   
        
always@(posedge clk_read_i )
    if( read_req_i && (!empty_o))
    begin
        $fdisplay(data_out_file_open,"%h",data_out_o);
    end

initial
begin
#end_time
    $fclose(data_in_file_open);
    $fclose(data_out_file_open);   
end







endmodule
