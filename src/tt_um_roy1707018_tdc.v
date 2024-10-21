`default_nettype none

module tt_um_roy1707018_tdc (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Map inputs from `ui_in`
    //wire ro_activate = ui_in[0];
    //wire ro_deactivate = ui_in[1];
    //wire [2:0] bit_sel = ui_in[4:2];  // `bit_sel` using ui_in[2:4]
    //wire [2:0] out_sel = ui_in[7:5];  // `out_sel` using ui_in[5:7]


    // Output connection
    wire ro_out;                // Output of the ring oscillator
    reg [31:0] time_count;      // Time difference (count of transitions)


    // Instantiate the TDC module
     tdc_delay tdc_inst (
        .rst_n(rst_n),
        .clk(clk),
        .start(ui_in[0]),          // Start signal
        .stop(ui_in[1]),            // Stop signal
        .ro_out(ro_out),        // Ring oscillator output (for observation or debugging)
        .time_count(time_count) // Count of transitions (time difference)
    );

   // Connect the TDC output to the module's output
    assign uo_out = time_count[7:0];

    // Set uio_out and uio_oe to zero, as they are not used in this design
    assign uio_out = 8'b0;
    assign uio_oe = 8'b0; 
    assign ui_in [2:7]= 6'b0;  
    wire _unused = &{ena, uio_in, 1'b0};

endmodule
