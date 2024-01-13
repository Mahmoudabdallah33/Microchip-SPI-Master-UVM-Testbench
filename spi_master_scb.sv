class spi_master_scb extends uvm_scoreboard;
  `uvm_component_utils(spi_master_scb)
  function new( string name = "spi_master_scb" , uvm_component parent);
   super.new(name,parent);
  endfunction
  
  uvm_analysis_export #(spi_master_seq_item)  dut_in_export;
  uvm_analysis_export #(spi_master_seq_item)  dut_out_export;
  spi_master_predictor predictor;
  spi_master_evaluator evaluator;

  function void build_phase(uvm_phase phase);
   dut_in_export = new("dut_in_export");
   dut_out_export = new("dut_out_export");
   predictor = spi_master_predictor::type_id::create("predictor",this);
   evaluator = spi_master_evaluator::type_id::create("evaluator",this);

  endfunction

  function void connect_phase(uvm_phase phase);
     dut_in_export.connect(predictor.analysis_export);
     dut_out_export.connect(evaluator.actual_export);
       predictor.expected_port.connect(evaluator.expected_export);
  endfunction




endclass
