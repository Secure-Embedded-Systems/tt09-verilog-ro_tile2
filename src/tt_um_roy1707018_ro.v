/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_roy1707018_ro (

	      // Include power ports for the Gate Level test:
`ifdef GL_TEST
      .VPWR(vpwr),
      .VGND(vgnd),
`endif
    input  wire [7:0] ui_in,    // Dedicated inputs (we'll use ui_in[1:0] for mux control)
    output wire [7:0] uo_out,   // Dedicated outputs (8-bit output of time count)
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // Don't use (used for power gating)
    input  wire       clk,      // System clock
    input  wire       rst_n     // Active-low reset
);


     // Signals to activate the ring oscillators and store their outputs
    wire [31:0] ro1_out;   // Output from the first 32 ROs
    wire [31:0] ro2_out;   // Output from the second 32 ROs

    // Instantiate the ro_only module
    ring_osc_buffer u_ro_only (
        .rst_n(rst_n),
        .clk(clk),
        .ro_activate_1(ui_in[0]),  // Use ui_in[0] to activate RO1 set
        .ro_activate_2(ui_in[1]),  // Use ui_in[1] to activate RO2 set
        .ro1_out(ro1_out),
        .ro2_out(ro2_out)
    );

    // Output the selected 8 bits to uo_out
   // assign uo_out = selected_count;
    assign uio_out = 0;
    assign uio_oe = 0;


  // List all unused inputs to prevent warnings
  wire _unused = &{ena, uio_in, 1'b0};







endmodule
