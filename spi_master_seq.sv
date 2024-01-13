class spi_master_seq extends uvm_sequence #(spi_master_seq_item);
 `uvm_object_utils(spi_master_seq)
  function new (string name = "spi_master_seq" , uvm_component parent);
   super.new(name,parent);
  endfunction
  
  task body();
    repeat (200) begin
      spi_master_seq_item m_seq_item;    
      m_seq_item = spi_master_seq_item :: type_id::create("m_seq_item");
      start_item(m_seq_item);
       if(!m_seq_item.randomize()) `uvm_fatal("NO_RANDOMIZE","cannot randomize");
       finish_item(m_seq_item);
    end
  endtask


endclass
