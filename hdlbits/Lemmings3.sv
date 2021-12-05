module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output logic walk_left,
    output logic walk_right,
    output logic aaah,
    output logic digging ); 

localparam LEFT = 2'b00;
localparam RIGHT= 2'b01;
localparam DIG  = 2'b10;
localparam GND  = 2'b11;

reg  ground_d;
wire ground_fall;
wire ground_rise;
always@(posedge clk or  posedge areset)
    if(areset)
        ground_d <= 1'b0;
    else 
        ground_d <= ground;
assign   ground_fall = (ground_d)&&(~ground);
assign   ground_rise = (~ground_d)&&(ground);
reg [1:0] state, nx_state, latch_state;
always@(posedge clk or posedge areset)
    if(areset)
        latch_state <= LEFT;
    //else if(ground&&((state==LEFT)||(state==RIGHT)))
    //else if(ground&&(state==DIG))
    else if(walk_left)
        latch_state <= LEFT;
    else if(walk_right)
        latch_state <= RIGHT;

always@(posedge clk or posedge areset)
    if(areset)
        state <= LEFT;
    else 
        state <= nx_state;

always@(*) begin
    nx_state = LEFT;
    case(state)
        LEFT: if(!ground) 
                nx_state = GND;
              else if(ground&dig)
                nx_state = DIG;
              else if(bump_left)
                nx_state = RIGHT;
              else 
                nx_state = LEFT;
        RIGHT:if(!ground)
                nx_state = GND;
              else if(ground&dig)
                nx_state = DIG;
              else if(bump_right)
                nx_state = LEFT;
              else 
                nx_state = RIGHT;
        DIG: if(!ground)
                nx_state = GND;
             else 
                nx_state = DIG;

        GND: //if(ground_rise&&(latch_state==LEFT))
              //  nx_state = LEFT;
             //else if(ground_rise&&(latch_state==RIGHT))
             if(ground_rise)
                //nx_state = latch_state;
                nx_state = latch_state;
             else 
                nx_state = GND;
        default: nx_state = LEFT;
    endcase
end


always@(posedge clk  or posedge areset)
    if(areset) begin 
        walk_left  <= 1'b1;
        walk_right <= 1'b0;
        aaah       <= 1'b0;
        digging    <= 1'b0;
    end
    else begin 
        case(nx_state)
            LEFT : begin 
                        walk_left  <= 1'b1;
                        walk_right <= 1'b0;
                        aaah       <= 1'b0;
                        digging    <= 1'b0;
                   end
            RIGHT: begin
                        walk_left  <= 1'b0;
                        walk_right <= 1'b1;
                        aaah       <= 1'b0;
                        digging    <= 1'b0;
                   end
            DIG  : begin
                        walk_left  <= 1'b0;
                        walk_right <= 1'b0;
                        aaah       <= 1'b0;
                        digging    <= 1'b1;
            end
            GND  : begin
                        walk_left  <= 1'b0;
                        walk_right <= 1'b0;
                        aaah       <= 1'b1;
                        digging    <= 1'b0;
            end
            default:begin
                        walk_left  <= 1'b1;
                        walk_right <= 1'b0;
                        aaah       <= 1'b0;
                        digging    <= 1'b0;
            end
        endcase
    end



endmodule
