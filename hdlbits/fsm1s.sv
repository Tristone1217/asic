module top_module(
    input clk,
    input reset,    // Asynchronous reset to state B
    input in,
    output logic out);//  

    parameter A=0, B=1; 
    reg state, next_state;


    always@(posedge clk)begin
	if(reset)
		state <= B;
	else 
		state <= next_state;
    end
	
    always_comb begin  // This is a combinational always block
	    next_state = B;
    	case(state)
		    A:if(in)
		    	next_state = A;
		      else
		        next_state = B;
		    B:if(in)
		    	next_state = B;
		      else
		        next_state = A;
		    default:next_state = B;
	    endcase
    end

    always@(posedge clk)begin
	if(reset)
		out <= B;
	else begin 
		case(next_state)
			A:out <= 1'b0;
		        B:out <= 1'b1;
			default: out <= 1'b1;
		endcase
	end
    end


endmodule
