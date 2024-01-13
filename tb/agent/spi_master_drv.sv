class spi_master_drv extends uvm_driver #(spi_master_seq_item);
  `uvm_component_utils(spi_master_drv)
   function new(string name = "spi_master_drv", uvm_component parent);
    super.new(name,parent);
   endfunction
   virtual spi_master_interface vif;
   
   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     if(!uvm_config_db#(virtual spi_master_interface)::get(this,"","vif",vif)) `uvm_fatal("NO_DRV_IF","error in getting interface in driver");


    endfunction
   extern task initialize_dut();
   extern task drive_master ( spi_master_seq_item txn );



    task run_phase (uvm_phase phase);

      initialize_dut();
      forever begin
     spi_master_seq_item txn;
     seq_item_port.get_next_item(txn);
     drive_master(txn);
     seq_item_port.item_done();

       end
    endtask

endclass

task spi_master_drv:: initialize_dut();
  vif.rst = 1'b1; 
  vif.write = 1'b0;
  vif.read = 1'b0;
  vif.users_write_data = 0;
  vif.MISO = 1'b0;
   #3;
   vif.rst = 1'b0; 
endtask

task spi_master_drv:: drive_master ( spi_master_seq_item txn );
// itsecondary_prescalarrator
integer i;

fork 
//************************
//thread 1
begin
@(posedge vif.clk)
vif.write = txn.write;
vif.users_write_data = txn.users_write_data;
vif.read = txn.read;
end
//*************************
// thread 2
begin
for ( i =0;i<16;i++); begin
@(posedge vif.clk)
vif.MISO = txn.users_write_data[i];
         end//for
end
//*************************


join

 endtask


