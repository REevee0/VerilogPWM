# VerilogPWM

![Language](https://img.shields.io/badge/language-Verilog-c084fc?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-c084fc?style=flat-square)

Tiny, parameterized PWM generator module in Verilog. One instance gives you a
configurable-frequency PWM with **runtime duty-cycle control via an 8-bit
input** interpreted as a percentage (0–100).

## Module

```verilog
module pwm #(
    parameter c_clkfreq = 100_000_000,  // input clock frequency, Hz
    parameter c_pwmfreq = 10_000        // PWM output frequency, Hz
)(
    input            clk,    // system clock
    input      [7:0] SW,     // duty cycle in percent (0..100)
    output reg       pwm_o   // PWM output
);
```

## Quick instantiate

```verilog
// 100 MHz clock, 1 kHz PWM, duty driven from 8 onboard switches
pwm #(.c_clkfreq(100_000_000), .c_pwmfreq(1_000)) u_pwm (
    .clk   (clk),
    .SW    (sw[7:0]),   // 0..100 from external source
    .pwm_o (led_pwm)
);
```

## How it works

A free-running counter wraps at `c_clkfreq / c_pwmfreq` ticks (one PWM period).
The high-time threshold is recalculated combinationally as
`(period / 100) * SW`, so the duty cycle tracks `SW` immediately — no latch,
no register update required.

## Notes

- `SW` is treated as a 0–100 percentage, **not** a raw count. Values above 100
  yield 100 % duty (output stays high).
- No deadband / no complementary output — for half-bridge drivers, wrap two
  instances or extend the module.
- Synthesizes cleanly on Xilinx 7-series and Gowin GW1N parts.

## License

MIT.
