

/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_roy1707018_tdc (
    input  wire [7:0] ui_in,    // Dedicated inputs (we'll use ui_in[1:0] for mux control)
    output wire [7:0] uo_out,   // Dedicated outputs (8-bit output of time count)
    input  wire       clk,      // System clock
    input  wire       rst_n     // Active-low reset
);

    // Internal signals
    wire [31:0] time_count;  // 32-bit time count from the TDC delay module
    reg [7:0] selected_count; // 8-bit selected portion of the time_count
    reg [31:0] time_count_reg;   // Register to store time_count


    // Instantiate the tdc_delay module
    tdc_delay #(.N_DELAY(32)) u_tdc_delay (
        .rst_n(rst_n),            // Active-low reset
        .clk(clk),                // System clock
        .start(ui_in[0]),         // Start signal (ui_in[0] as start)
       // .stop(ui_in[1]),          // Stop signal (ui_in[1] as stop)
        .time_count(time_count)   // 32-bit output time count
    );

    // Register time_count and select part of it to show on the output

    
    always @(posedge clk or posedge rst_n) begin
    if (rst_n) begin
        time_count_reg <= 32'b0;  // Reset time count register
    end else begin
        time_count_reg <= time_count;  // Latch the time count from tdc_delay
    end

   end


    // 4-to-1 MUX to select which 8-bit section of time_count to output
    always @(*) begin
        case (ui_in[3:2])  // Use ui_in[3:2] to select which part of the 32-bit time_count
            2'b00: selected_count = time_count[7:0];    // Lower 8 bits
            2'b01: selected_count = time_count[15:8];   // Next 8 bits
            2'b10: selected_count = time_count[23:16];  // Next 8 bits
            2'b11: selected_count = time_count[31:24];  // Upper 8 bits
            default: selected_count = 8'b0;
        endcase
    end

    // Output the selected 8 bits to uo_out
    assign uo_out = selected_count;

endmodule
