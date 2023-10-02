`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2023 09:16:38 PM
// Design Name: 
// Module Name: seven_seg
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


module seven_seg(
    input clk,
    input [3:0][7:0] display_data,
    output reg [3:0] anodes = 4'b1111,
    output reg [7:0] cathodes
    );

    wire ms_5_tick;
    reg[1:0] count;

    parameter ANODE_DEFVALUE = 4'b1111;

    divide_by_5ms dv_5 (clk,ms_5_tick);

    always_ff @(posedge clk) begin

        if(ms_5_tick) begin

                count <= count + 1;
                anodes <= ANODE_DEFVALUE & ~(1 << count);
                cathodes <= display_data[count];
        end

    end

endmodule
