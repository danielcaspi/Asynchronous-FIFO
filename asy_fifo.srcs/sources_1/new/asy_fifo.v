`timescale 1ns / 1ps


module asy_fifo(
                   input reset_i, 
                   input clk_write_i,
                   input clk_read_i,
                   input write_req_i,
                   input read_req_i,
                   input [31:0] data_in_i,
                   output [31:0] data_out_o,
                   output empty_o,
                   output full_o,
                   output uf_i,
                   output of_i
                   );
 
 wire mem_read;  //from control to mem rd
 wire mem_write; //from control to mem wr
 wire [3:0] mem_ptr_read; // from read control to mem
 wire [3:0] mem_ptr_write; // from write control to mem
 wire [3:0]gray_into_syc_write; // befor syc write
 wire [3:0]gray_out_syc_write;  // after syc write
 wire [3:0]gray_into_syc_read;  // befor syc write
 wire [3:0]gray_out_syc_read;   // after syc write
 wire [3:0]read_ptr_to_wr_control;
 wire [3:0]write_ptr_to_rd_control;
                   
mem32x16 mem32x16_m(
                      .data_in(data_in_i),        
                      .read_address(mem_ptr_read),   
                      .write_address(mem_ptr_write),  
                      .read(mem_read),           
                      .write(mem_write),          
                      .read_clk(clk_read_i),       
                      .write_clk(clk_write_i),      
                      .data_out(data_out_o)
                      );   
                           
read_control_unit read_control_unit_m(
                                        .read_clk(clk_read_i),
                                        .reset_n(reset_i),
                                        .read_req(read_req_i),
                                        .write_ptr(write_ptr_to_rd_control), 
                                        .read_ptr(mem_ptr_read),   
                                        .read(mem_read),             
                                        .empty(empty_o),
                                        .uf(uf_i)
                                      ); 
                               
 write_control_unit write_control_unit_m(
                                            .write_clk(clk_write_i),
                                            .reset_n(reset_i),
                                            .write_req(write_req_i),
                                            .read_ptr(read_ptr_to_wr_control), 
                                            .write_ptr(mem_ptr_write),  
                                            .write(mem_write),            
                                            .full(full_o),
                                            .of(of_i)
                                         );                            
 
 syncronaizer syncronaizer_write(                             
                                    .in_clk(clk_read_i),            
                                    .out_clk(clk_write_i),           
                                    .reset_n(reset_i),           
                                    .data_in(gray_into_syc_write),     
                                    .data_out(gray_out_syc_write)
                                  );    
           
 syncronaizer syncronaizer_read(                             
                                    .in_clk(clk_write_i),            
                                    .out_clk(clk_read_i),           
                                    .reset_n(reset_i),           
                                    .data_in(gray_into_syc_read),     
                                    .data_out(gray_out_syc_read)
                                  );                                                                        

 binary_to_gray binary_to_gray_write (                        
                                          .binary_in(mem_ptr_read),
                                          .gray_out(gray_into_syc_write) 
                                      );                                           
                      
 gray_to_binary gray_to_binary_write(                                                   
                                       .gray_in(gray_out_syc_write),                                                
                                       .binary_out(read_ptr_to_wr_control)                     
                                     );      
                                                                         
 binary_to_gray binary_to_gray_read (                        
                                          .binary_in(mem_ptr_write),
                                          .gray_out(gray_into_syc_read) 
                                      );                                           
                      
 gray_to_binary gray_to_binary_read(                                                   
                                       .gray_in(gray_out_syc_read),                                                
                                       .binary_out(write_ptr_to_rd_control)                     
                                     );                                          
                                      
            
endmodule
