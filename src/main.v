module main(clk, led, btn, sw);
input clk;
output [5:0] led;
input [4:0] btn;
input [5:2] sw;

wire [5:0] led_state;
wire [4:0] btn_state;

reg [32:0] counter = 0;
reg blink_state = 0;

assign btn_state = ~btn;
assign led = ~led_state;

assign led_state = {btn_state[4], sw[5:2] | btn_state[3:0], blink_state};


always @(posedge clk) begin
    counter <= counter + 1;

    if (counter == 27_000_000) begin
        counter <= 0;
        blink_state <= ~blink_state;
    end
end

endmodule