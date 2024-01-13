interface spi_master_interface (input logic clk_in) ;
logic rst;
logic clk = clk_in ;
logic write , read;
logic [15:0] users_write_data;
logic [15:0] users_read_data;
logic MISO,MOSI;
logic sck;
logic ss;
logic SPIROV;
logic SPIxRBF;
logic SPIxTBF;
logic [1:0] secondary_prescalar;




endinterface

