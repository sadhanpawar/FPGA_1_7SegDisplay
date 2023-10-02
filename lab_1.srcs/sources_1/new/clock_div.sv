`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2023 01:13:03 PM
// Design Name: 
// Module Name: clock_div
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

module clock_div(
    input clk,
    input [26:0] divisor,
    output reg out);
    
    reg [26:0] count;
    
    always_ff @ (posedge(clk))
    begin
        if (count < divisor)
        begin
           count <= count + 1;
           out <= 0;
        end
        else
        begin
            count <= 0;
            out <= 1;
        end
    end    
endmodule

module divide_by_500ms(
    input clk,
    output reg out);
    
    reg [26:0] count;
    
    always_ff @ (posedge(clk))
    begin
        if (count < 27'd50000000)    
        begin
           count <= count + 1;
           out <= 0;
        end
        else
        begin
            count <= 0;
            out <= 1;
        end
    end    
endmodule

module divide_by_5ms(
    input clk,
    output reg out);
    
    reg [26:0] count;
    
    always_ff @ (posedge(clk))
    begin
        if (count < 27'd500000)  //5ms
        begin
           count <= count + 1;
           out <= 0;
        end
        else
        begin
            count <= 0;
            out <= 1;
        end
    end    
endmodule
