module assertions (input clk, rst ,write, read , [15:0] users_write_data, [15:0] users_read_data, 
 MISO , MOSI , sck , ss , SPIROV , SPIxRBF , SPIxTBF , [1:0] secondary_prescalar );

property TBF_set;
@(posedge clk) disable iff (rst)
write |-> ##[0:1] SPIxTBF;

endproperty


property TBF_clear;
@(posedge clk) disable iff (rst)
$rose(ss) |-> $past( (!SPIxTBF) , 2 );

endproperty

property RBF_set;
@(posedge clk) disable iff (rst)
$fell (ss) |->  SPIxRBF;
endproperty

property RBF_clear;
@(posedge clk) disable iff (rst)
read |->  (!SPIxRBF);
endproperty


property cannot_write;
@(posedge clk) disable iff (rst)
SPIxTBF |-> !(write);
endproperty

assert property (TBF_set);
assert property (TBF_clear);
assert property (RBF_set);
assert property (RBF_clear);
assert property (cannot_write);


endmodule
