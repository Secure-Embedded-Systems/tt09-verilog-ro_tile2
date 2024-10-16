module tdc (
    input wire rst_n,
    input wire clk,
    input wire ro_activate,
    input wire ro_deactivate,      // New deactivation signal
    input wire [2:0] bit_sel,          // 3-bit selection input to choose 8-bit segment
    input wire [2:0] out_sel,      // 3-bit selector for 8 ring oscillators
    output reg [7:0] out           // 8-bit output selection
);
    // Define wires for each ring oscillator output
    wire ro_out[7:0];
    wire [62:0] ro_buffer[7:0];
    // Intermediate signals for the activation logic
    wire ro_activation[7:0];
    // Intermediate register to hold selected buffer output
    reg [62:0] buffer_selected;

    // Instantiate 8 ring oscillators, each with 63 stages
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : ro_instances

            // Activation logic: only activate when ro_activate is high and ro_deactivate is low
            assign ro_activation[i] = ro_activate && ~ro_deactivate;

            ring_osc ro_inst (
                .rst_n(rst_n),
                .clk(clk),
                .ro_activate(ro_activation[i]), // Use the same activate signal for all
                .ro_out(ro_out[i]),
                .buffer(ro_buffer[i])
            );
        end
    endgenerate

    // Always block for selecting the 63-bit buffer based on out_sel
    always @(posedge ro_activate or posedge ro_deactivate) begin
        if (ro_deactivate) begin
            buffer_selected <= 63'b0;  // Reset buffer
        end else begin
            // Select the 63-bit value from ro_buffer based on out_sel
            case (out_sel)
                3'b111: buffer_selected <= ro_buffer[7];
                3'b110: buffer_selected <= ro_buffer[6];
                3'b101: buffer_selected <= ro_buffer[5];
                3'b100: buffer_selected <= ro_buffer[4];
                3'b011: buffer_selected <= ro_buffer[3];
                3'b010: buffer_selected <= ro_buffer[2];
                3'b001: buffer_selected <= ro_buffer[1];
                3'b000: buffer_selected <= ro_buffer[0];
                default: buffer_selected <= 63'b0;  // Default case for safety
            endcase
        end
    end

    // Assign the 8-bit output 'out' to specific bits from the selected buffer
    // Combinational logic to select 8-bit portion from buffer_selected
    always @(*) begin
        case (bit_sel)
            3'b000: out = buffer_selected[7:0];             // Select bits [7:0]
            3'b001: out = buffer_selected[15:8];            // Select bits [15:8]
            3'b010: out = buffer_selected[23:16];           // Select bits [23:16]
            3'b011: out = buffer_selected[31:24];           // Select bits [31:24]
            3'b100: out = buffer_selected[39:32];           // Select bits [39:32]
            3'b101: out = buffer_selected[47:40];           // Select bits [47:40]
            3'b110: out = buffer_selected[55:48];           // Select bits [55:48]
            3'b111: out = {1'b0, buffer_selected[62:56]};   // Select bits [62:56] with MSB as 0
            default: out = 8'b00000000;                     // Default case for safety
        endcase
    end
endmodule
