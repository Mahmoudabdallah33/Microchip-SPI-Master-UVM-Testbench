class spi_master_evaluator extends uvm_component;
  `uvm_component_utils(spi_master_evaluator)
  function new(string name = "spi_master_evaluator", uvm_component parent);
     super.new(name,parent);
  endfunction

  uvm_analysis_export #(spi_master_seq_item) expected_export;
  uvm_analysis_export #(spi_master_seq_item) actual_export;

  uvm_tlm_analysis_fifo #(spi_master_seq_item) expected_fifo;
  uvm_tlm_analysis_fifo #(spi_master_seq_item) actual_fifo;

  int match, mismatch;

  function void build_phase(uvm_phase phase);
      expected_fifo = new("expected_fifo");
      actual_fifo = new("actual_fifo");
      expected_export = new("expected_export");
      actual_export = new("actual_export");
  endfunction

  function void connect_phase(uvm_phase phase);
   expected_export.connect(expected_fifo.analysis_export);
   actual_export.connect(actual_fifo.analysis_export);
  endfunction

  task run_phase(uvm_phase phase);
    spi_master_seq_item expected_tx;
    spi_master_seq_item actual_tx;
     forever begin
         expected_fifo.get(expected_tx);
         actual_fifo.get(actual_tx);
         if(expected_tx.do_compare(actual_tx, null )) begin
                            match++;
                                    end
          else begin 
               mismatch++;
                `uvm_error("mismatch happened ","actual didnot match the expected tx ");

              end

     end
  endtask



endclass
  