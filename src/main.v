module main(clk, led, btn, sw, ws2812_data);
    input clk;
    output [5:0] led;
    input [4:0] btn;
    input [5:2] sw;
    output ws2812_data;

    wire [5:0] led_state;
    wire [4:0] btn_state;

    assign btn_state = ~btn;
    assign led = ~led_state;

    wire clk100;

    rPLL #(
        .FCLKIN("27"),
        .DYN_IDIV_SEL("false"),
        .IDIV_SEL(6),
        .DYN_FBDIV_SEL("false"),
        .FBDIV_SEL(25),
        .DYN_ODIV_SEL("false"),
        .ODIV_SEL(8),
        .PSDA_SEL("0000"),
        .DYN_DA_EN("true"),
        .DUTYDA_SEL("1000"),
        .CLKOUT_FT_DIR(1'b1),
        .CLKOUTP_FT_DIR(1'b1),
        .CLKOUT_DLY_STEP(0),
        .CLKOUTP_DLY_STEP(0),
        .CLKFB_SEL("internal"),
        .CLKOUT_BYPASS("false"),
        .CLKOUTP_BYPASS("false"),
        .CLKOUTD_BYPASS("false"),
        .DYN_SDIV_SEL(2),
        .CLKOUTD_SRC("CLKOUT"),
        .CLKOUTD3_SRC("CLKOUT"),
        .DEVICE("GW2A-18C")
    ) pll (
        .CLKOUT(clk100),
        .RESET(1'b0),
        .RESET_P(1'b0),
        .CLKIN(clk),
        .CLKFB(1'b0),
        .FBDSEL({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .IDSEL({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ODSEL({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PSDA({1'b0,1'b0,1'b0,1'b0}),
        .DUTYDA({1'b0,1'b0,1'b0,1'b0}),
        .FDLY({1'b0,1'b0,1'b0,1'b0})
    );

    clk_div #(.WIDTH(32)) clkdiv_inst (
        .clkin(clk100),
        .div(32'd10_000_000),
        .clkout(led_state[0])
    );

    ws2812 rgb (
        .clk(clk100),
        .rst(~btn_state[4]),
        .rgb_color(
            {sw[5] ? 8'hFF : 8'h00, sw[4] ? 8'hFF : 8'h00, sw[3] ? 8'hFF : 8'h00}
        ),
        .out(ws2812_data)
    );

    assign led_state[5:1] = {btn_state[4], sw[5:2] | btn_state[3:0]};
endmodule