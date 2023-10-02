`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2023 09:13:41 PM
// Design Name: 
// Module Name: hex_to_ss
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

module hex_to_ss(
    input [3:0] hex_num,
    output reg [7:0] bits_num,
    input reg[9:0] leds
    );


    //reg [15:0][7:0] cathode_vals = {8'b11000000, // 0
    //                                8'b11111001, // 1
    //                                8'b10100100, // 2
    //                                8'b10110000, // 3
    //                                8'b10011001, // 4
    //                                8'b10010010, // 5
    //                                8'b10000011, // 6
    //                                8'b11111000, // 7
    //                                8'b10000000, // 8
    //                                8'b10011000, // 9
    //                                8'b10001000, // A
    //                                8'b10000011, // B
    //                                8'b11000110, // C
    //                                8'b10100001, // D
    //                                8'b10000110, // E
    //                                8'b10001110  // F
    //};
    

    always @ (*) begin

        case(hex_num)
        4'd0: bits_num  = 8'b11000000; // 0
        4'd1: bits_num  = 8'b11111001; // 1
        4'd2: bits_num  = 8'b10100100; // 2
        4'd3: bits_num  = 8'b10110000; // 3
        4'd4: bits_num  = 8'b10011001; // 4
        4'd5: bits_num  = 8'b10010010; // 5
        4'd6: bits_num  = 8'b10000011; // 6
        4'd7: bits_num  = 8'b11111000; // 7
        4'd8: bits_num  = 8'b10000000; // 8
        4'd9: bits_num  = 8'b10011000; // 9
        4'd10: bits_num = 8'b10001000; // A
        4'd11: bits_num = 8'b10000011; // B
        4'd12: bits_num = 8'b11000110; // C
        4'd13: bits_num = 8'b10100001; // D
        4'd14: bits_num = 8'b10000110; // E
        4'd15: bits_num = 8'b10001110; // F
        endcase
    end

    //assign leds = {6'b0, hex_num};

endmodule