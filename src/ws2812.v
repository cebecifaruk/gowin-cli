module ws2812 (clk, rst, rgb_color, out);
  // 100 MHz, 10 ns
  input clk;
  input rst;
  input [23:0] rgb_color;
  output out;

  reg [31:0] ns;
  reg out_state;
  reg [23:0] data;
  reg [7:0] sent_bits = 0;

  // Data is transmitted in GRB order with MSB first
  always @(posedge clk) begin
    if (rst) begin
      ns <= 0;
      out_state <= 0;
      data <= { rgb_color[15:8], rgb_color[23:16], rgb_color[7:0]};
      sent_bits <= 0;
    end else if (sent_bits < 24) begin
      ns <= ns + 10;
      out_state <= data[23] ? (ns <= 700) : (ns <= 350);
      if (ns >= 1250) begin
        ns <= 0;
        data <= {data[22:0], 1'b0};
        sent_bits <= sent_bits + 1;
      end
    end
  end

  assign out = out_state;

endmodule