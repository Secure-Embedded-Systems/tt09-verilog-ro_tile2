module ring_osc (
    input wire rst_n,
    input wire clk,                // System clock for synchronous sampling
    input wire ro_activate,
    output wire ro_out,
    output reg [18:0] buffer       // Synchronized buffer output holding values of q0 to q18
);

    reg en;                        // Enable signal for the ring oscillator
    (* keep = "true" *) wire q;
    (* keep = "true" *) wire q0;
    (* keep = "true" *) wire q1;
    (* keep = "true" *) wire q2;
    (* keep = "true" *) wire q3;
    (* keep = "true" *) wire q4;
    (* keep = "true" *) wire q5;
    (* keep = "true" *) wire q6;
    (* keep = "true" *) wire q7;
    (* keep = "true" *) wire q8;
    (* keep = "true" *) wire q9;
    (* keep = "true" *) wire q10;
    (* keep = "true" *) wire q11;
    (* keep = "true" *) wire q12;
    (* keep = "true" *) wire q13;
    (* keep = "true" *) wire q14;
    (* keep = "true" *) wire q15;
    (* keep = "true" *) wire q16;
    (* keep = "true" *) wire q17;
    (* keep = "true" *) wire q18;

    // Output of the ring oscillator, controlled by the enable signal
    assign ro_out = en ? q : 1'b0;

    // Enable logic
    always @(posedge clk or posedge rst_n) begin
        if (rst_n)
            en <= 1'b0;
        else if (ro_activate)
            en <= 1'b1;
        else
            en <= 1'b0;
    end

    // Synchronous buffer: captures the state of each inverter stage on the system clock
    always @(posedge clk or posedge rst_n) begin
        if (rst_n)
            buffer <= 19'b0;
        else
            buffer <= {q18, q17, q16, q15, q14, q13, q12, q11, q10,
                       q9, q8, q7, q6, q5, q4, q3, q2, q1, q0};
    end

    // Instantiate the inverters for the ring oscillator
    (* keep = "true" *) cinv cinv0 (.a(en & q18), .q(q0));
    (* keep = "true" *) cinv cinv1 (.a(q0), .q(q1));
    (* keep = "true" *) cinv cinv2 (.a(q1), .q(q2));
    (* keep = "true" *) cinv cinv3 (.a(q2), .q(q3));
    (* keep = "true" *) cinv cinv4 (.a(q3), .q(q4));
    (* keep = "true" *) cinv cinv5 (.a(q4), .q(q5));
    (* keep = "true" *) cinv cinv6 (.a(q5), .q(q6));
    (* keep = "true" *) cinv cinv7 (.a(q6), .q(q7));
    (* keep = "true" *) cinv cinv8 (.a(q7), .q(q8));
    (* keep = "true" *) cinv cinv9 (.a(q8), .q(q9));
    (* keep = "true" *) cinv cinv10 (.a(q9), .q(q10));
    (* keep = "true" *) cinv cinv11 (.a(q10), .q(q11));
    (* keep = "true" *) cinv cinv12 (.a(q11), .q(q12));
    (* keep = "true" *) cinv cinv13 (.a(q12), .q(q13));
    (* keep = "true" *) cinv cinv14 (.a(q13), .q(q14));
    (* keep = "true" *) cinv cinv15 (.a(q14), .q(q15));
    (* keep = "true" *) cinv cinv16 (.a(q15), .q(q16));
    (* keep = "true" *) cinv cinv17 (.a(q16), .q(q17));
    (* keep = "true" *) cinv cinv18 (.a(q17), .q(q18));

    assign q = q18; // Connect the last stage back to the start for oscillation

endmodule

