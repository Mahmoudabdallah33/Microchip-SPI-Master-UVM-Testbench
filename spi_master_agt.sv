class spi_master_agt extends uvm_agent;
 `uvm_component_utils(spi_master_agt)
  function new(string name = "spi_master_agt", uvm_component parent);
       super.new(name,parent);
  endfunction
  
 spi_master_drv m_drv;
 spi_master_mon m_mon;
 spi_master_sqr  m_sqr;
 spi_master_agt_config m_agt_cfg;
 uvm_analysis_port #(spi_master_seq_item) mon_tx_port;
 //uvm_analysis_port #(spi_master_seq_item) dut_out_port;
 
 
 extern function void build_phase(uvm_phase phase);

 extern function void connect_phase (uvm_phase phase);
 

endclass

function void spi_master_agt :: build_phase(uvm_phase phase);


if (!uvm_config_db#(spi_master_agt_config)::get(this,"","agt_config",m_agt_cfg)) `uvm_fatal("NO_AGT_CONFIG",{"agent config object should set for:",get_type_name(),".cfg_obj"});

    uvm_config_db#(virtual spi_master_interface)::set(this,"m_drv","vif",m_agt_cfg.vif);
if (m_agt_cfg.active == UVM_ACTIVE) begin
     m_drv = spi_master_drv::type_id::create("m_drv",this);
     m_sqr = new("m_sqr",this);
   end
     m_mon = spi_master_mon::type_id::create("m_mon",this);

    mon_tx_port  = new("mon_tx_port",this);
    //dut_out_port  = new("dut_out_port");
endfunction

function void spi_master_agt:: connect_phase(uvm_phase phase);
    if (m_agt_cfg.active == UVM_ACTIVE) begin
             m_drv.seq_item_port.connect(m_sqr.seq_item_export);
        end
   m_mon.mon_tx_port.connect(this.mon_tx_port);
  // m_mon.dut_out_port.connect(this.dut_out_port);

endfunction


