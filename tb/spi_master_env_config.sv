class spi_master_env_config extends uvm_object;

  `uvm_object_utils(spi_master_env_config)
 spi_master_agt_config m_agt_cfg;
   function new (string name = "spi_master_env_config");
        super.new(name);
        m_agt_cfg = new("m_agt_cfg");
  endfunction
  
   bit has_scoreboard = 1'b0;
   bit has_coverage =1'b0;


   


endclass
