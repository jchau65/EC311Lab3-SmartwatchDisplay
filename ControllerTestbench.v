`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2026 02:18:53 PM
// Design Name: 
// Module Name: ControllerTestbench
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


module ControllerTestbench();

    reg clk;
    reg rst;
    reg stateSwitcherButton;
    reg boot_en;
    wire [7:0] state;
    
    Controller ctrl(
                    .clk(clk), 
                    .rst(rst), 
                    .stateSwitcherButton(stateSwitcherButton), 
                    .boot_en(boot_en), 
                    .state(state)
                    );
    
    initial
    begin
        clk = 0;
        rst = 1;
        stateSwitcherButton = 0;
        boot_en = 0;
        #5;
        
        rst = 0;
        #5;
    end
    
    always #1 clk = ~clk;
    integer i = 0;
    
    initial
    begin
        #10;
        boot_en = 1;
        #5;
        boot_en = 0;
        #5;
        //1
        stateSwitcherButton = stateSwitcherButton +1;
        #5;
        stateSwitcherButton = stateSwitcherButton +1;
        #5;
        //2
        stateSwitcherButton = stateSwitcherButton +1;
        #5;
        stateSwitcherButton = stateSwitcherButton +1;
        #5;
        boot_en = 1;
        #5;
        //3
        stateSwitcherButton = stateSwitcherButton +1;
        #5;
        stateSwitcherButton = stateSwitcherButton +1;
        #5;
        //4
        stateSwitcherButton = stateSwitcherButton +1;
        #5;
        stateSwitcherButton = stateSwitcherButton +1;
        #5;
        boot_en = 0;
        #5;
        //5
        stateSwitcherButton = stateSwitcherButton +1;
        #5;
        stateSwitcherButton = stateSwitcherButton +1;
        #5;
        //6
        stateSwitcherButton = stateSwitcherButton +1;
        #5;
        stateSwitcherButton = stateSwitcherButton +1;
        #5;
        rst = 1;
        #5;
        $finish;
    end
    
endmodule
