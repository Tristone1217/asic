module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah ); 

localparam LEFT = 2'b00;
localparam RIGHT= 2'b10;
localparam GND  = 2'b11;

reg [1:0] state;
reg [1:0] nx_state;

wire ground_rise = (~ground_d) && ( ground);
wire ground_fall = ( ground_d) && (~ground);

reg ground_d;
always@(posedge clk or posedge areset)
    if(areset)
        ground_d <= 1'b0;
    else 
        ground_d <= ground;

reg [1:0] latch_state;
always@(posedge clk or posedge areset)
    if(areset)
        latch_state <= LEFT;
    //else if(ground_rise|ground_fall)
    else if(ground_fall)
        latch_state <= state;


always@(posedge clk or posedge areset)
    if(areset)
        state <= LEFT;
    else 
        state <= nx_state;

always@(*) begin 
    nx_state = LEFT;
    case(state)
        LEFT: if(ground_fall) 
                nx_state = GND;
              else if(bump_left)
                nx_state = RIGHT;
              else 
                nx_state = LEFT;
        RIGHT:if(ground_fall)
                nx_state = GND;
              else if(bump_right)
                nx_state = LEFT;
              else  
                nx_state = RIGHT;

        GND: if(ground_rise&&(latch_state==RIGHT))
                nx_state = RIGHT;
             else if(ground_rise&&(latch_state==LEFT))
                nx_state = LEFT;
             else 
                nx_state  = GND;

        default:nx_state = LEFT;
    endcase
end

assign walk_left  = (state==LEFT );
assign walk_right = (state==RIGHT);
assign aaah       = (state==GND  );
////always@(posedge clk or posedge areset)
//    if(areset)
//        aaah <= 1'b0;
////    else if(((walk_left&&bump_left)||(walk_right&&bump_right))&&(~ground))
//    else if(~ground)
//        aaah <= 1'b1; 
//    else if(ground)
//        aaah <= 1'b0;


endmodule

