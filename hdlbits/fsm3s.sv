module top_module(
	input clk,
    input in,
    input reset,
    output logic out); //

    localparam A=4'b0001; 
    localparam B=4'b0010; 
    localparam C=4'b0100; 
    localparam D=4'b1000; 

	logic [3:0] cs_state;
	logic [3:0] nx_state;
	
    // State transition logic
	always@(posedge clk)
		if(reset)
			cs_state <= A;
		else
			cs_state <= nx_state;

    // State flip-flops with asynchronous reset
	always_comb begin 
		nx_state = A;
		case(cs_state)
			A		: if(in)
						nx_state = B;
					  else
						nx_state = A;
			B		: if(in)
						nx_state = B;
					  else 
						nx_state = C;
			C		: if(in)
						nx_state = D;
					  else 
						nx_state = A;
			D		: if(in)
						nx_state = B;
					  else 
						nx_state = C;
			default	: nx_state = A;
		endcase 
	end
	//

    // Output logic
	always@(posedge clk)
		if(reset)
			out  <= 1'b0;
		else
			out  <= nx_state[3];
	

endmodule
