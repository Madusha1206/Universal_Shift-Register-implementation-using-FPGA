`timescale 1ns / 1ps

module usr_4bit (
    input  logic clk,
    input  logic reset,
    input  logic [1:0] s,
    input  logic [3:0] d,
    input  logic serial_in,
    output logic [3:0] q
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;
        end else begin
            case (s)
                2'b00: q <= q;                    // Hold
                2'b01: q <= {q[2:0], serial_in};  // Shift Left
                2'b10: q <= {serial_in, q[3:1]};  // Shift Right
                2'b11: q <= d;                    // Parallel Load
                default: q <= q;
            endcase
        end
    end

endmodule