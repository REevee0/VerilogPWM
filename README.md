# VerilogPWM
PWM module writed in verilog

Code Example Usage:
```verilog
pwm #(.c_clkfreq(25_000_000)) u1(
    .clk(clk),
    .SW(SW),
    .pwm_o(pwm_o)
);
```
The variable c_clkfreq is used for the source clock frequency.
The variable c_pwmfreq is used to determine the frequency of the PWM signal.
The .clk port is the source clock frequency port.
The .SW port is the 7-bit PWM duty cycle port.
The .pwm_o port is the output port for the PWM signal.

Please feel free to let me know if you have any further questions or suggestions.
