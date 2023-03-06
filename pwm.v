module pwm #(parameter  c_clkfreq = 100_000_000, c_pwmfreq = 10000)(
  input clk,
  input [7:0] SW,
  output reg pwm_o
);

parameter c_timerlim = c_clkfreq/c_pwmfreq;

reg [31:0] timer = 0;
reg [31:0] hightime = c_timerlim/2;

always @(posedge clk) begin
  if (timer == c_timerlim - 1) begin
    timer <= 0;
  end
  else begin
    timer <= timer + 1;
  end
  
  if (timer < hightime) begin
    pwm_o <= 1'b1;
  end
  else begin
    pwm_o <= 1'b0;
  end
end

always @* begin
  hightime = (c_timerlim/100) * SW;
end

endmodule
