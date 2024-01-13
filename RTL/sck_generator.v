module sck_generator (input clk , rst , input  [1:0] secondary_prescalar , output reg sck);

reg prescalar_2_1 = 2'b00;
reg prescalar_4_1 = 2'b01;
reg prescalar_6_1 = 2'b10;
reg prescalar_8_1 = 2'b11;
reg sck_temp = 1'b0;
reg [2:0] counter = 3'b000;
always @(posedge clk) begin
 if (rst) begin 
                      sck_temp <= 0 ;
		  end
						 
 else begin
case (secondary_prescalar)
prescalar_2_1 : begin
                 sck_temp <= ~sck_temp;
                      end
prescalar_4_1 : begin
				     if (counter == 3'd2) begin
					                sck_temp <= ~sck_temp;
                                    counter <= 1'b0;
									end
									else begin
									    counter <= counter + 1'b1;
									end
                 end
prescalar_6_1 : begin
				     if (counter == 3'd3) begin
					                sck_temp <= ~sck_temp;
                                    counter <= 1'b0;
									end
									else begin
									    counter <= counter + 1'b1;
									end
                      end
prescalar_8_1 : begin
				     if (counter == 3'd4) begin
					                sck_temp <= ~sck_temp;
                                    counter <= 1'b0;
									end
									else begin
									    counter <= counter + 1'b1;
									end
                      end
endcase
end


end
assign sck = sck_temp;
endmodule