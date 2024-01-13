class spi_master_cov extends uvm_subscriber;
  `uvm_component_utils(spi_master_cov)
   function new(string name = "spi_master_cov", uvm_component parent);
            super.new(name,parent);
   endfunction

   spi_master_seq_item tx_n;
   covergroup  secondary_prescalar_1;
    secondary_prescalar_1 :  coverpoint tx_n.secondary_prescalar {
                               bins prescalar_2_1 = {2'b00};
                               bins prescalar_4_1 = {2'b01};
                               bins prescalar_6_1 = {2'b10};
                               bins prescalar_8_1 = {2'b11};
                             }   
   endgroup
  covergroup write_enable ;
   write_enable : coverpoint tx_n.write {
                                       bins hi = {1'b1};
                                       bins lo = {1'b0};
                                         }
   users_write_data : coverpoint tx_n.users_write_data;


  endgroup
   
  covergroup read ;
   read_enable : coverpoint tx_n.read {
                                       bins hi = {1'b1};
                                       bins lo = {1'b0};
                                         }
   users_read_data : coverpoint tx_n.users_read_data;


  endgroup
  covergroup status ;

    SPIROV : coverpoint tx_n.SPIROV {
                                       bins hi = {1'b1};
                                       bins lo = {1'b0};

                                }
    SPIxRBF : coverpoint tx_n.SPIxRBF {
                                       bins hi = {1'b1};
                                       bins lo = {1'b0};

                                }
    SPIxTBF : coverpoint tx_n.SPIxTBF {
                                       bins hi = {1'b1};
                                       bins lo = {1'b0};

                                }


  endgroup

  virtual function void write (spi_master_seq_item t);
   tx_n = spi_master_seq_item::type_id::create("tx_n");

  if(! $cast(tx_n,t)) `uvm_fatal("NO_CAST","the objects not compatable");
   tx_n.copy(t);
   
   secondary_prescalar_1.sample(); 
   write.sample();
   read.sample();
   status.sample();
  endfunction


endclass
