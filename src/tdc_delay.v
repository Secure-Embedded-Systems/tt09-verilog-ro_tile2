module tdc_delay #(parameter N_DELAY = 32) (
    input wire  rst_n,           // Active-low reset
    input wire  clk,             // System clock
    input wire  start,           // Start signal
    input wire  stop,            // Stop signal
    output wire [N_DELAY-1:0] time_count // Time difference (number of transitions)
);


(* keep = "true" *) wire [N_DELAY+1:0] w_dly_sig;
(* keep = "true" *) wire [N_DELAY:0] w_dly_sig_n;

reg [N_DELAY-1:0] r_dly_store;

assign w_dly_sig[0] = start;

genvar i;
generate
    for (i = 0; i <= N_DELAY; i = i + 1) begin : g_dly_chain_even
        (* keep = "true" *) cinv dly_stg1 (.a(w_dly_sig[i]), .q(w_dly_sig_n[i]));
        (* keep = "true" *) cinv dly_stg2 (.a(w_dly_sig_n[i]), .q(w_dly_sig[i+1]));
    end
endgenerate




always @(posedge stop) begin
        r_dly_store <= w_dly_sig[N_DELAY:1];
    
end

   
 assign time_count = r_dly_store;

endmodule // tdc
