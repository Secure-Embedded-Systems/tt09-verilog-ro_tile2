module ring_osc (
    input wire rst_n,
    input wire clk,                // System clock for synchronous sampling
    input wire ro_activate,
    output wire ro_out,
    output reg [62:0] buffer       // Synchronized buffer output holding values of q0 to q62
);

    reg en;                        // Enable signal for the ring oscillator
    (* keep = "true" *) wire q;
    
    // Declare 63 wire stages
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
    (* keep = "true" *) wire q19;
    (* keep = "true" *) wire q20;
    (* keep = "true" *) wire q21;
    (* keep = "true" *) wire q22;
    (* keep = "true" *) wire q23;
    (* keep = "true" *) wire q24;
    (* keep = "true" *) wire q25;
    (* keep = "true" *) wire q26;
    (* keep = "true" *) wire q27;
    (* keep = "true" *) wire q28;
    (* keep = "true" *) wire q29;
    (* keep = "true" *) wire q30;
    (* keep = "true" *) wire q31;
    (* keep = "true" *) wire q32;
    (* keep = "true" *) wire q33;
    (* keep = "true" *) wire q34;
    (* keep = "true" *) wire q35;
    (* keep = "true" *) wire q36;
    (* keep = "true" *) wire q37;
    (* keep = "true" *) wire q38;
    (* keep = "true" *) wire q39;
    (* keep = "true" *) wire q40;
    (* keep = "true" *) wire q41;
    (* keep = "true" *) wire q42;
    (* keep = "true" *) wire q43;
    (* keep = "true" *) wire q44;
    (* keep = "true" *) wire q45;
    (* keep = "true" *) wire q46;
    (* keep = "true" *) wire q47;
    (* keep = "true" *) wire q48;
    (* keep = "true" *) wire q49;
    (* keep = "true" *) wire q50;
    (* keep = "true" *) wire q51;
    (* keep = "true" *) wire q52;
    (* keep = "true" *) wire q53;
    (* keep = "true" *) wire q54;
    (* keep = "true" *) wire q55;
    (* keep = "true" *) wire q56;
    (* keep = "true" *) wire q57;
    (* keep = "true" *) wire q58;
    (* keep = "true" *) wire q59;
    (* keep = "true" *) wire q60;
    (* keep = "true" *) wire q61;
    (* keep = "true" *) wire q62;

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
            buffer <= 63'b0;
        else
            buffer <= {q62, q61, q60, q59, q58, q57, q56, q55, q54, q53,
                       q52, q51, q50, q49, q48, q47, q46, q45, q44, q43,
                       q42, q41, q40, q39, q38, q37, q36, q35, q34, q33,
                       q32, q31, q30, q29, q28, q27, q26, q25, q24, q23,
                       q22, q21, q20, q19, q18, q17, q16, q15, q14, q13,
                       q12, q11, q10, q9, q8, q7, q6, q5, q4, q3, q2, q1, q0};
    end

    // Instantiate the inverters for the ring oscillator
    (* keep = "true" *) cinv cinv0 (.a(en & q62), .q(q0));
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
    (* keep = "true" *) cinv cinv19 (.a(q18), .q(q19));
    (* keep = "true" *) cinv cinv20 (.a(q19), .q(q20));
    (* keep = "true" *) cinv cinv21 (.a(q20), .q(q21));
    (* keep = "true" *) cinv cinv22 (.a(q21), .q(q22));
    (* keep = "true" *) cinv cinv23 (.a(q22), .q(q23));
    (* keep = "true" *) cinv cinv24 (.a(q23), .q(q24));
    (* keep = "true" *) cinv cinv25 (.a(q24), .q(q25));
    (* keep = "true" *) cinv cinv26 (.a(q25), .q(q26));
    (* keep = "true" *) cinv cinv27 (.a(q26), .q(q27));
    (* keep = "true" *) cinv cinv28 (.a(q27), .q(q28));
    (* keep = "true" *) cinv cinv29 (.a(q28), .q(q29));
    (* keep = "true" *) cinv cinv30 (.a(q29), .q(q30));
    (* keep = "true" *) cinv cinv31 (.a(q30), .q(q31));
    (* keep = "true" *) cinv cinv32 (.a(q31), .q(q32));
    (* keep = "true" *) cinv cinv33 (.a(q32), .q(q33));
    (* keep = "true" *) cinv cinv34 (.a(q33), .q(q34));
    (* keep = "true" *) cinv cinv35 (.a(q34), .q(q35));
    (* keep = "true" *) cinv cinv36 (.a(q35), .q(q36));
    (* keep = "true" *) cinv cinv37 (.a(q36), .q(q37));
    (* keep = "true" *) cinv cinv38 (.a(q37), .q(q38));
    (* keep = "true" *) cinv cinv39 (.a(q38), .q(q39));
    (* keep = "true" *) cinv cinv40 (.a(q39), .q(q40));
    (* keep = "true" *) cinv cinv41 (.a(q40), .q(q41));
    (* keep = "true" *) cinv cinv42 (.a(q41), .q(q42));
    (* keep = "true" *) cinv cinv43 (.a(q42), .q(q43));
    (* keep = "true" *) cinv cinv44 (.a(q43), .q(q44));
    (* keep = "true" *) cinv cinv45 (.a(q44), .q(q45));
    (* keep = "true" *) cinv cinv46 (.a(q45), .q(q46));
    (* keep = "true" *) cinv cinv47 (.a(q46), .q(q47));
    (* keep = "true" *) cinv cinv48 (.a(q47), .q(q48));
    (* keep = "true" *) cinv cinv49 (.a(q48), .q(q49));
    (* keep = "true" *) cinv cinv50 (.a(q49), .q(q50));
    (* keep = "true" *) cinv cinv51 (.a(q50), .q(q51));
    (* keep = "true" *) cinv cinv52 (.a(q51), .q(q52));
    (* keep = "true" *) cinv cinv53 (.a(q52), .q(q53));
    (* keep = "true" *) cinv cinv54 (.a(q53), .q(q54));
    (* keep = "true" *) cinv cinv55 (.a(q54), .q(q55));
    (* keep = "true" *) cinv cinv56 (.a(q55), .q(q56));
    (* keep = "true" *) cinv cinv57 (.a(q56), .q(q57));
    (* keep = "true" *) cinv cinv58 (.a(q57), .q(q58));
    (* keep = "true" *) cinv cinv59 (.a(q58), .q(q59));
    (* keep = "true" *) cinv cinv60 (.a(q59), .q(q60));
    (* keep = "true" *) cinv cinv61 (.a(q60), .q(q61));
    (* keep = "true" *) cinv cinv62 (.a(q61), .q(q62));

    // Connect the last stage back to the start for oscillation
    assign q = q62;

endmodule

