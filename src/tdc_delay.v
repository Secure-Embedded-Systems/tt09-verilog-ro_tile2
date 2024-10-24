`default_nettype none
module tdc_delay #(parameter N_DELAY = 32) (
    input wire  rst_n,           // Active-low reset
    input wire  clk,             // System clock
    input wire  start,           // Start signal
    output wire [N_DELAY-1:0] time_count // Time difference (number of transitions)
);


(* keep = "true" *) wire [N_DELAY+1:0] w_dly_sig;
(* keep = "true" *) wire [N_DELAY+1:0] w_dly_sig_1;
(* keep = "true" *) wire [N_DELAY+1:0] w_dly_sig_2;
(* keep = "true" *) wire [N_DELAY+1:0] w_dly_sig_3;
(* keep = "true" *) wire [N_DELAY+1:0] w_dly_sig_4;
(* keep = "true" *) wire [N_DELAY+1:0] w_dly_sig_5;
(* keep = "true" *) wire [N_DELAY+1:0] w_dly_sig_6;
(* keep = "true" *) wire [N_DELAY+1:0] w_dly_sig_7;
(* keep = "true" *) wire [N_DELAY+1:0] w_dly_sig_8;
(* keep = "true" *) wire [N_DELAY+1:0] w_dly_sig_9;
(* keep = "true" *) wire [N_DELAY+1:0] w_dly_sig_10;
(* keep = "true" *) wire [N_DELAY:0] w_dly_sig_n;

reg [N_DELAY-1:0] r_dly_store;

assign w_dly_sig[0] = start;

genvar i;
generate
    for (i = 0; i <= N_DELAY; i = i + 1) begin : g_dly_chain_even
        (* keep = "true" *) cinv dly_stg1 (.a(w_dly_sig[i]), .q(w_dly_sig_1[i]));
            (* keep = "true" *) cinv dly_stg2 (.a(w_dly_sig_1[i]), .q(w_dly_sig_2[i]));
            (* keep = "true" *) cinv dly_stg3 (.a(w_dly_sig_2[i]), .q(w_dly_sig_3[i]));
            (* keep = "true" *) cinv dly_stg4 (.a(w_dly_sig_3[i]), .q(w_dly_sig_4[i]));
            (* keep = "true" *) cinv dly_stg5 (.a(w_dly_sig_4[i]), .q(w_dly_sig_5[i]));
            (* keep = "true" *) cinv dly_stg6 (.a(w_dly_sig_5[i]), .q(w_dly_sig_6[i]));
            (* keep = "true" *) cinv dly_stg7 (.a(w_dly_sig_6[i]), .q(w_dly_sig_7[i]));
            (* keep = "true" *) cinv dly_stg8 (.a(w_dly_sig_7[i]), .q(w_dly_sig_8[i]));
            (* keep = "true" *) cinv dly_stg9 (.a(w_dly_sig_8[i]), .q(w_dly_sig_9[i]));
            (* keep = "true" *) cinv dly_stg10 (.a(w_dly_sig_9[i]), .q(w_dly_sig_10[i]));

            // After passing through 10 stages of inverters, proceed with the final inverter stage
            (* keep = "true" *) cinv dly_stg11 (.a(w_dly_sig_10[i]), .q(w_dly_sig_n[i]));

            // The final inverter chain back to w_dly_sig for the next iteration
            (* keep = "true" *) cinv dly_stg12 (.a(w_dly_sig_n[i]), .q(w_dly_sig[i+1]));
    end
endgenerate



always @(posedge clk or  posedge start) begin
    if (start) begin
        r_dly_store <= {N_DELAY{1'b0}};  // On rising edge of 'start', reset r_dly_store to 0
    end else begin
        r_dly_store <= w_dly_sig[N_DELAY:1];  // Otherwise, update with w_dly_sig[N_DELAY:1]
    end
end

   
 assign time_count = r_dly_store;

endmodule // tdc
