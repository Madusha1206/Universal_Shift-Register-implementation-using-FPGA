`timescale 1ns / 1ps

module top_usr (
    input  logic clk_100mhz,
    input  logic reset,
    input  logic [1:0] s,
    input  logic [3:0] d,
    input  logic serial_in,
    output logic [3:0] q
);

    logic clk_1hz_signal; // Internal wire

    // Connect clk_100mhz (from FPGA) to the 'clk' port of the divider
    clock_divider clk_div_inst (
        .clk(clk_100mhz),   // .clk refers to the name inside clock_divider.sv
        .reset(reset),
        .clk_1hz(clk_1hz_signal)
    );

    // Connect the 1Hz signal to the 'clk' port of the USR
    usr_4bit usr_inst (
        .clk(clk_1hz_signal),
        .reset(reset),
        .s(s),
        .d(d),
        .serial_in(serial_in),
        .q(q)
    );

endmodule