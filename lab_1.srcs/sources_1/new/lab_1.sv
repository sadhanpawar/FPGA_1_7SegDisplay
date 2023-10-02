`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2023 09:11:57 PM
// Design Name: 
// Module Name: lab_1
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


module lab_1(
    input CLK100,           // 100 MHz clock input
    output [9:0] LED,       // RGB1, RGB0, LED 9..0 placed from left to right
    output [2:0] RGB0,      
    output [2:0] RGB1,
    output [3:0] SS_ANODE,   // Anodes 3..0 placed from left to right
    output [7:0] SS_CATHODE, // Bit order: DP, G, F, E, D, C, B, A
    input [11:0] SW,         // SWs 11..0 placed from left to right
    input [3:0] PB,          // PBs 3..0 placed from left to right
    inout [23:0] GPIO,       // PMODA-C 1P, 1N, ... 3P, 3N order
    output [3:0] SERVO,      // Servo outputs
    output PDM_SPEAKER,      // PDM signals for mic and speaker
    input PDM_MIC_DATA,      
    output PDM_MIC_CLK,
    output ESP32_UART1_TXD,  // WiFi/Bluetooth serial interface 1
    input ESP32_UART1_RXD,
    output IMU_SCLK,         // IMU spi clk
    output IMU_SDI,          // IMU spi data input
    input IMU_SDO_AG,        // IMU spi data output (accel/gyro)
    input IMU_SDO_M,         // IMU spi data output (mag)
    output IMU_CS_AG,        // IMU cs (accel/gyro) 
    output IMU_CS_M,         // IMU cs (mag)
    input IMU_DRDY_M,        // IMU data ready (mag)
    input IMU_INT1_AG,       // IMU interrupt (accel/gyro)
    input IMU_INT_M,         // IMU interrupt (mag)
    output IMU_DEN_AG        // IMU data enable (accel/gyro)
    );

        // Terminate all of the unused outputs or i/o's
    // assign LED = 10'b0000000000;
    assign RGB0 = 3'b000;
    assign RGB1 = 3'b000;
    // assign SS_ANODE = 4'b0000;
    // assign SS_CATHODE = 8'b11111111;
    // assign GPIO = 24'bzzzzzzzzzzzzzzzzzzzzzzzz;
    assign GPIO[15:0] = 16'bzzzzzzzzzzzzzzzz;
    assign GPIO[23:20] = 4'bzzzzz;
    assign GPIO[18] = 1'bz;
    assign SERVO = 4'b0000;
    assign PDM_SPEAKER = 1'b0;
    assign PDM_MIC_CLK = 1'b0;
    assign ESP32_UART1_TXD = 1'b0;
    assign IMU_SCLK = 1'b0;
    assign IMU_SDI = 1'b0;
    assign IMU_CS_AG = 1'b1;
    assign IMU_CS_M = 1'b1;
    assign IMU_DEN_AG = 1'b0;


    wire clk = CLK100;
    reg [3:0][7:0]cathodes;

    reg [3:0] anode_ops;
    reg [7:0] cathode_ops;

    reg [9:0] pb_leds;

    assign SS_ANODE = anode_ops;
    assign SS_CATHODE = cathode_ops;

    // handle input metastability safely
    reg reset;
    reg pre_reset;
    always_ff @ (posedge(clk))
    begin
        pre_reset <= PB[0];
        reset <= pre_reset;
    end

        // handle input metastability safely
    reg min=0;
    reg pre_min=0;
    always_ff @ (posedge(clk))
    begin
        pre_min <= PB[1];
        min <= pre_min;
    end

    // handle input metastability safely
    reg max=0;
    reg pre_max=0;
    always_ff @ (posedge(clk))
    begin
        pre_max <= PB[2];
        max <= pre_max;
    end

    // handle input metastability safely
    reg match;
    reg pre_match;
    always_ff @ (posedge(clk))
    begin
        pre_match <= PB[3];
        match <= pre_match;
    end


    wire counter_direction = SW[11];

    wire [10:0] skip = SW[10:0];
    reg [15:0] top_counter;

    counter_16bit c16(
                .clk(clk),
                .reset(reset),
                .inc_dec(counter_direction),
                .skip(skip),
                .min_en(min),
                .max_en(max),
                .match_en(match),
                .count_16bit(top_counter),
                .leds(LED)
                
    );

    reg [3:0] nib0 = top_counter[3:0];
    reg [3:0] nib1 = top_counter[7:4];
    reg [3:0] nib2 = top_counter[11:8];
    reg [3:0] nib3 = top_counter[15:12];

    hex_to_ss nibble0(nib0,cathodes[0],LED);
    hex_to_ss nibble1(nib1,cathodes[1],LED);
    hex_to_ss nibble2(nib2,cathodes[2],LED);
    hex_to_ss nibble3(nib3,cathodes[3],LED);

    seven_seg sg(clk, cathodes,anode_ops,cathode_ops);

endmodule

