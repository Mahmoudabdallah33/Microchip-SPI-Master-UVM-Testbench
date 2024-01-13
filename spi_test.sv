class spi_test extends uvm_test;
  `uvm_component_utils(spi_test)
  function new(string name = "spi_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  spi_master_seq m_seq;
  spi_master_env m_env;
  spi_master_env_config m_env_cfg;
  
  virtual function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     m_seq = spi_master_seq::type_id::create("m_seq",this);
     m_env = spi_master_env::type_id::create("m_env",this);
     m_env_cfg = new("m_env_cfg");
     m_env_cfg.has_scoreboard = 1'b1;
     m_env_cfg.has_coverage = 1'b1;
     m_env_cfg.m_agt_cfg.active = UVM_ACTIVE;
     if (uvm_config_db#(virtual spi_master_interface)::get(null,"spi_test","vif",m_env_cfg.m_agt_cfg.vif)) `uvm_fatal("NO_IF","didnot get the interface");

     uvm_config_db#(spi_master_env_config)::set(this,"m_env","env_config",m_env_cfg);


  endfunction

  task run_phase(uvm_phase phase);
     super.run_phase(phase);
     phase.raise_objection(this);
     m_seq.start(m_env_cfg.m_agt_cfg.m_sqr);
     phase.drop_objection(this);
     phase.phase_done.set_drain_time(this,100);


  endtask




endclass
