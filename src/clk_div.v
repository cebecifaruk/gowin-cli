module clk_div #(parameter WIDTH = 8) (clkin, div, clkout);
  input clkin;
  input [WIDTH-1:0] div;
  output clkout;

  reg [WIDTH-1:0] counter = 0;
  reg clk_reg = 0;

  always @(posedge clkin) begin
    counter <= counter + 1;
    if (counter == div) begin
      counter <= 0;
      clk_reg <= ~clk_reg;
    end
  end

  assign clkout = clk_reg;

endmodule