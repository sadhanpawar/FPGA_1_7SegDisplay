`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2023 01:45:42 PM
// Design Name: 
// Module Name: counter_16bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module counter_16bit(
    input clk,
    input reset,
    input inc_dec,
    input [10:0] skip,
    input min_en,
    input max_en,
    input match_en,
    output reg [15:0] count_16bit,
    output reg [9:0] leds
    );

    wire ms_500_tick;
    reg [15:0] inc=0;
    reg [15:0] matchvalue=0;
    reg matched_led = 0;
    reg [15:0] min_val = 0;
    reg [15:0] max_val;
    bit min_set = 0;
    bit max_set = 0;
    reg initialized=0;

    divide_by_500ms dv_500(clk,ms_500_tick);

    initial begin
        inc <= 1'b0;
        count_16bit <= 1'b0;
        min_val <= 1'b0;
        max_val <= 16'hFFFF;
        max_set <=1'b0;
        min_set <= 1'b0;
        matchvalue <= 1'b0;
        matched_led <= 1'b0;
        initialized <= 1'b1;
    end

    always_ff @ (posedge(clk)) begin
        if (reset) begin
            inc <= 1'b0;
            count_16bit <= 1'b0;
            min_val <= 1'b0;
            max_val <= 16'hFFFF;
            max_set <=1'b0;
            min_set <= 1'b0;
            matchvalue <= 1'b0;
            matched_led <= 1'b0;
        end

        if(min_en) begin
            min_val <= inc;
        end

        if (max_en) begin
            max_val <= inc;
        end

        if(match_en) begin 
            matchvalue <= inc;
        end

          
        if (ms_500_tick) begin

            if(skip) begin
                if(inc_dec) begin
                    inc <= inc + skip;
                end
                else begin
                    inc <= inc - skip;
                end
            end 
            else begin
                if(inc_dec) begin
                    inc <= inc + 1'b1;
                end
                else begin
                    inc <= inc - 1'b1;
                end
            end

            if (matchvalue == inc) begin
                 matched_led = 1'b1;
            end
            else begin
                matched_led = 1'b0;
            end

            if(inc > max_val) begin
                inc <= min_val;
                count_16bit <= min_val;
            end
            else if (inc < min_val) begin
                inc <= max_val;
                count_16bit <= max_val;
            end
            else begin
                count_16bit <= inc;
            end

            //count_16bit <= inc;
        end
    end

    assign leds = {9'd0,matched_led};
endmodule
