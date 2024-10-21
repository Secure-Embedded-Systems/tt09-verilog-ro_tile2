module tdc_delay (
    input wire  rst_n,           // Active-low reset
    input wire  clk,             // System clock
    input wire  start,           // Start signal
    input wire  stop,            // Stop signal
    output wire ro_out,          // Output of the ring oscillator
    output reg [31:0] time_count // Time difference (number of transitions)
);

wire ro1_out_A;

// Registers for RO output
reg ro_1_reg_A;



reg [7:0] prescaler_count;
reg [31:0] transition_count;  // Count transitions between start and stop
reg counting;




ring_osc ro1_A (
   .rst_n(rst_n),
   .clk(clk),
   .ro_activate(counting),
   .ro_out(ro_out)
);

/*
always @(posedge clk or posedge rst_n) begin
    if (rst_n) begin
        ro_1_reg_A <= 1'b0;
    end else begin
        ro_1_reg_A <= ro1_out_A;
    end
end

*/

// Prescaler to count RO transitions (rising and falling edges)
    always @(posedge clk or posedge rst_n) begin
        if (rst_n) begin
            prescaler_count <= 0;
            transition_count <= 0;
            counting <= 0;
        end else begin
            // Start counting when the start signal is asserted
            if (start && !counting) begin
                counting <= 1;
                transition_count <= 0;  // Reset transition count on start
            end

            // Stop counting when the stop signal is asserted
            if (stop && counting) begin
                counting <= 0;  // Stop counting on stop
            end

            // Count transitions while the ring oscillator is active (counting)
            if (counting) begin
                if (prescaler_count == 255) begin
                    prescaler_count <= 0;
                    transition_count <= transition_count + 1;  // Count rising edge of RO
                end else begin
                    prescaler_count <= prescaler_count + 1;
                end
            end
        end
    end

    // Falling edge detection and count update
    always @(negedge clk or posedge rst_n) begin
        if (rst_n) begin
            transition_count <= 0;
        end else if (counting) begin
            if (prescaler_count == 255) begin
                transition_count <= transition_count + 1;  // Count falling edge of RO
            end
        end
    end

    // Output the time difference (total transitions between start and stop)
    always @(posedge clk or posedge rst_n) begin
        if (rst_n) begin
            time_count <= 0;
        end else if (!counting && stop) begin
            time_count <= transition_count;  // Capture transition count on stop
        end
    end

endmodule

