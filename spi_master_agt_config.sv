class spi_master_agt_config extends uvm_object;
  `uvm_object_utils(spi_master_agt_config)
   function new (string name = "spi_master_agt_config");
        super.new(name);
        
  endfunction
  
  uvm_active_passive_enum active = UVM_ACTIVE;
   virtual spi_master_interface vif;
   spi_master_sqr  m_sqr;

   


endclass
