class spi_master_predictor extends uvm_subscriber;
 `uvm_component_utils(spi_master_predictor)
  function new(string name = "spi_master_predictor", uvm_component parent);
     super.new(name,parent);

  endfunction

  uvm_analysis_port #(spi_master_seq_item) expected_port;
  
  function void build_phase (uvm_phase phase);
         super.build_phase(phase);
         expected_port = new("expected_port");
         
  endfunction

   extern task  predict (spi_master_seq_item txn);

  function void write (spi_master_seq_item t);
   spi_master_seq_item expected_tx = spi_master_seq_item::type_id::create("expected_tx",this); 
   if(!$cast(expected_tx,t)) `uvm_fatal("CASTING_ERR","classes not compatable");
       expected_tx.copy(t);
      fork
       predict (expected_tx);
        join


        expected_port.write(expected_tx);
  endfunction

endclass

task automatic spi_master_predictor ::  predict (spi_master_seq_item txn);
logic [1:0] SPIxBUF;
logic [1:0] SPIxSR;
logic [1:0] SPIxTXB;
logic [1:0] SPIxRXB;

integer count = 0;
logic [1:0] state , idle , transmit , complete;

case (state)

idle : begin
           if (txn.write && !(txn.SPIxTBF) ) begin
                     SPIxBUF = txn.users_write_data;
                     txn.SPIxTBF = 1'b1;
                 end else if (txn.read && txn.SPIROV) begin
                          txn.users_read_data = SPIxRXB;
                           txn.SPIROV = 1'b0;
                            txn.SPIxRBF = 1'b0;
                  end


           if (txn.SPIxTBF) begin
                      SPIxSR =  SPIxBUF;
                      state = transmit ;
                      txn.SPIxTBF = 1'b0;

                           end

       end
transmit : begin
            if (count < 16) begin
                      txn.MOSI = SPIxSR[0];      
                       SPIxSR = {txn.users_write_data[14:0],txn.MISO};
                      count = count +1;
             end else   begin
                     txn.SPIxRBF = 1'b1;
                 state = complete;
                 end

            end
complete : begin
             SPIxRXB = SPIxSR;   
             txn.SPIROV = 1'b1;




           end


default : state = idle ;






endcase
endtask