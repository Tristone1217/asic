module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output reg out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;
    
    always@(posedge clk or posedge areset)
        if(areset)
            state <= OFF;
        else 
            state <= next_state;

    always @(*) begin
        // State transition logic
        next_state = OFF;
        case(state)
            OFF:if(j)
                   next_state = ON;
                else
                   next_state = OFF;
            ON :if(k)
                   next_state = OFF;
                else
                   next_state = ON;
            default:next_state=OFF;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State output 
        if(areset)
            out <= 1'b0;
        else begin
            case(next_state)
                ON:  out <= 1'b1;
                OFF: out <= 1'b0;
                default:out <= 1'b0;
            endcase
        end
    end

    // Output logic
    // assign out = (state == ...);

endmodule
