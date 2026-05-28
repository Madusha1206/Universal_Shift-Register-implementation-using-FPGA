`timescale 1ns / 1ps

module clock_divider (
    input  logic clk,      // Ensure this is exactly 'clk'
    input  logic reset,
    output logic clk_1hz
);

    logic [25:0] counter = 0;
    logic internal_clk = 0;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            internal_clk <= 0;
        end else begin
            if (counter >= 49_999_999) begin
                counter <= 0;
                internal_clk <= ~internal_clk;
            end else begin
                counter <= counter + 1;
            end
        end
    end

    assign clk_1hz = internal_clk;
endmodule