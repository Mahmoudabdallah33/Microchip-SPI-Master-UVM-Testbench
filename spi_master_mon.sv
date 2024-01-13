class spi_master_mon extends uvm_monitor;
  `uvm_component_utils(spi_master_mon)
   function new(string name = "spi_master_mon" , uvm_component parent);
         super.new(name,parent);
   endfunction
   
  uvm_analysis_port #(spi_master_seq_item) mon_tx_port;

  
   virtual spi_master_interface vif;



   extern function void build_phase(uvm_phase phase);

   extern task run_phase(uvm_phase phase);

   extern task monitor_input(spi_master_seq_item txn );

   extern task monitor_output(spi_master_seq_item txn );


endclass



function void spi_master_mon :: build_phase(uvm_phase phase);
if(!uvm_config_db#(virtual spi_master_interface )::get(this,"","vif",vif)) `uvm_fatal("NO_IF","error in getting interface for monitor");

 mon_tx_port = new("mon_tx_port");



endfunction

task spi_master_mon :: run_phase(uvm_phase phase);
spi_master_seq_item tx_n = spi_master_seq_item::type_id::create("tx_n",this);
forever begin

//monitor output
monitor_output(tx_n);
// moitor input


mon_tx_port.write(tx_n);

end


endtask


task   spi_master_mon :: monitor_output ( spi_master_seq_item txn );
forever begin
fork
//-----------------------------
begin
 @(posedge vif.clk)
  txn.write = vif.write;
  txn.read = vif.read;
  txn.users_write_data = vif.users_write_data;
end
//----------------------------
begin
repeat (16) begin
@(posedge vif.clk)
txn.MISO = vif.MISO;
end
end
//----------------------------
join

end
endtask

task   spi_master_mon :: monitor_input ( spi_master_seq_item txn );
forever begin


// monitor MOSI

repeat (16) begin
@(posedge vif.clk)
txn.MOSI = vif.MOSI;
          end

//------------------
if (vif.read) txn.users_read_data = vif.users_read_data;

txn.SPIxRBF = vif.SPIxRBF;
txn.SPIxTBF = vif.SPIxTBF;
txn.SPIROV = vif.SPIROV;



end
endtask
