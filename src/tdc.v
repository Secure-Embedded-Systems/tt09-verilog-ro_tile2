module tdc (
    input wire rst_n,
    input wire clk,
    input wire ro_activate,
    input wire ro_deactivate,      // New deactivation signal

    input wire [2:0] out_sel,
    output reg [7:0] out
);
 // Define wires for each ring oscillator output
    wire ro_out[7:0];
    wire [18:0] ro_buffer[7:0];
    // Intermediate signals for the activation logic
    wire ro_activation[7:0];
    // Intermediate register to hold selected buffer output
    reg [18:0] buffer_selected;

    // Instantiate 8  ring oscillators
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : ro_instances

	    // Activation logic: only activate when ro_activate is high and ro_deactivate is low
            assign ro_activation[i] = ro_activate && ~ro_deactivate;
	
            ring_osc ro_inst (
                .rst_n(rst_n),
                .clk(clk),
                .ro_activate(ro_activation[i]), // Use the same activate signal or make it unique as needed
                .ro_out(ro_out[i]),
                .buffer(ro_buffer[i])
            );
        end
    endgenerate

// Always block for selecting the 19-bit buffer based on out_sel
    always @(posedge ro_activate  or posedge ro_deactivate) begin
        if (ro_deactivate) begin
            buffer_selected <= 19'h0;  // Reset buffer
           // out <= 8'h00;              // Reset output
        end 
        else begin
            // Select the 19-bit value from ro_buffer based on out_sel
            case (out_sel)
                3'b111: buffer_selected <= ro_buffer[7];
                3'b110: buffer_selected <= ro_buffer[6];
                3'b101: buffer_selected <= ro_buffer[5];
                3'b100: buffer_selected <= ro_buffer[4];
                3'b011: buffer_selected <= ro_buffer[3];
                3'b010: buffer_selected <= ro_buffer[2];
                3'b001: buffer_selected <= ro_buffer[1];
                3'b000: buffer_selected <= ro_buffer[0];
                default: buffer_selected <= 19'h0;
            endcase
            
        end
    end

endmodule
