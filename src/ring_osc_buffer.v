module ring_osc_buffer (
    input wire rst_n,
    input wire clk,
    input wire ro_activate_1,
    input wire ro_activate_2,
    output wire [31:0] ro1_out,  // Outputs from 32 ROs in RO1
    output wire [31:0] ro2_out   // Outputs from 32 ROs in RO2
);

   // Instantiate 32 ROs for each set (RO1 and RO2), totaling 64 ROs
   genvar i;
   generate
       for (i = 0; i < 32; i = i + 1) begin : ro_gen
           // RO1 instantiation
           ring_osc ro1 (
               .rst_n(rst_n),
               .clk(clk),
               .ro_activate(ro_activate_1),
               .ro_out(ro1_out[i])
           );

           // RO2 instantiation
           ring_osc ro2 (
               .rst_n(rst_n),
               .clk(clk),
               .ro_activate(ro_activate_2),
               .ro_out(ro2_out[i])
           );
       end
   endgenerate

endmodule
