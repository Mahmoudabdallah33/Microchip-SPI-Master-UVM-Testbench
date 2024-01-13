class spi_master_env extends uvm_env;
  `uvm_component_utils(spi_master_env)
  function new(string name = "spi_master_env" , uvm_component parent);
     super.new(name,parent);
  endfunction
     spi_master_agt m_agt;
     spi_master_scb m_scb;
     spi_master_cov m_coverage;
     spi_master_env_config m_env_cfg;
   virtual function void build_phase(uvm_phase phase );
      
       if (!uvm_config_db#(spi_master_env_config)::get(this,"","env_config",m_env_cfg)) `uvm_fatal("NO_ENV_CONFIG","error in getting env config");
      
        m_agt = spi_master_agt::type_id::create("m_agt",this);                      
        
        if (m_env_cfg.has_scoreboard)
        m_scb = spi_master_scb::type_id::create("m_scb",this); 
        
        if (m_env_cfg.has_coverage)
        m_coverage = spi_master_cov::type_id::create("m_coverage",this); 

       uvm_config_db#(spi_master_agt_config)::set(this,"m_agt","agt_config",m_env_cfg.m_agt_cfg);
    endfunction

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
     if (m_env_cfg.has_scoreboard) begin
        m_agt.mon_tx_port.connect(m_scb.dut_in_export);
        m_agt.mon_tx_port.connect(m_scb.dut_out_export);  end
      if (m_env_cfg.has_coverage)
        m_agt.mon_tx_port.connect(m_coverage.analysis_export);        
   endfunction

endclass

