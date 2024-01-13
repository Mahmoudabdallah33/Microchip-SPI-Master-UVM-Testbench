
//`include "spi_master_assertions.sv"
`include "spi_master_pkg.sv"
`include "spi_master_interface.sv"
import uvm_pkg::*;
import spi_master_pkg::*;
module spi_top ;

logic clk ;

// instantiate the interface
spi_master_interface master_if(clk);


//instantiate the design
spi_master spi_1 (.clk(master_if.clk),.rst(master_if.rst),.secondary_prescalar(master_if.secondary_prescalar),.write(master_if.write),.read(master_if.read),.user_write_data(master_if.users_write_data),
.MISO(master_if.MISO),.MOSI(master_if.MOSI),.sck(master_if.sck),.SS(master_if.ss),.user_reads_data(master_if.users_read_data),.SPIxRBF(master_if.SPIxRBF),.SPIxTBF(master_if.SPIxTBF),.SPIROV(master_if.SPIROV));


//bind spi_master spi_master_assertions sva (.*); 


initial begin

uvm_config_db #(virtual spi_master_interface)::set(uvm_root::get(),"spi_test","vif",master_if);
run_test("spi_test");
end


// generate clk
initial begin
clk = 1'b0;
forever #10 clk = ~clk;
end

`include "spi_master_assertions.sv"
endmodule
