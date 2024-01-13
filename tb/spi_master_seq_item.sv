class spi_master_seq_item extends uvm_sequence_item;

rand bit write;
rand bit read;
rand bit [15:0] users_write_data ;
bit [15:0]  users_read_data;
rand bit MISO;
bit MOSI;
bit sck;
bit ss;
rand bit [1:0] secondary_prescalar;
bit SPIROV;
bit SPIxTBF;
bit SPIxRBF;


constraint read_write { write != read;}



virtual function void do_copy(uvm_object rhs);
   
  spi_master_seq_item tx_rhs;
  if(!$cast(tx_rhs,rhs)) `uvm_fatal("not_compatable","objects not copatable");

  //super.do_copy(rhs);
  write = tx_rhs.write;
  read = tx_rhs.read;
  users_write_data = tx_rhs.users_write_data;
  users_read_data = tx_rhs.users_read_data;
   MISO = tx_rhs.MISO;
   sck = tx_rhs.sck;
   ss = tx_rhs.ss;

endfunction

virtual function bit do_compare(uvm_object rhs,uvm_comparer comparer);
   
  spi_master_seq_item tx_rhs;
  if(!$cast(tx_rhs,rhs)) `uvm_fatal("not_compatable","objects not copatable");

//  super.do_compare(rhs);
  if ( (write === tx_rhs.write) &&
    (read === tx_rhs.read) &&
  ( users_write_data === tx_rhs.users_write_data) &&
   (users_read_data === tx_rhs.users_read_data) &&
    (MISO === tx_rhs.MISO) &&
   (sck === tx_rhs.sck) &&
   (ss === tx_rhs.ss) )  begin return 1'b1; end

   else begin  return 1'b0;  end

endfunction










endclass
