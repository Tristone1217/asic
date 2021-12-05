module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output logic fr3,
    output logic fr2,
    output logic fr1,
    output logic dfr
); 

logic [2:0] cs_state;
logic [2:0] nx_state;

assign nx_state = s; 

always@(posedge clk)
	if(reset)
		cs_state <= 3'b0;
	else 
		cs_state <= nx_state;

wire fr1_tmp = (nx_state==3'd0)||(nx_state==3'd1)||(nx_state==3'd2) || (nx_state==3'd3);
wire fr2_tmp = (nx_state==3'd0)||(nx_state==3'd1)                  ;
wire fr3_tmp = (nx_state==3'd0)					                   ;

wire dfr_tmp = nx_state < cs_state;

always@(posedge clk)
	if(reset) begin
		fr1 <= 1'b1;
		fr2 <= 1'b1;
		fr3 <= 1'b1;
	end
	else begin
		fr1 <= fr1_tmp;
		fr2 <= fr2_tmp;
		fr3 <= fr3_tmp;
	end

always@(posedge clk)
	if(reset)
		dfr <= 1'b1;
	else if(nx_state==3'd0)
		dfr <= 1'b1;
	else if(nx_state < cs_state)
		dfr <= 1'b1;
	else if(nx_state > cs_state)
		dfr <= 1'b0;


endmodule
