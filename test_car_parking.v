`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/08/2020 05:28:23 PM
// Design Name: 
// Module Name: test_car_parking
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

//testbench for car parking
module test_car_parking();
wire green_led, red_led;                //output green led for car park, red led to stop
reg clock,reset;                        //input
reg entry_sensor,exit_sensor;           //input
reg [0:1] password_1,password_2;        // input password for entry and exit
  car_parking car(
  .clock(clock),
  .reset(reset),
  .entry_sensor(entry_sensor), 
  .exit_sensor(exit_sensor),
  .password_1( password_1),
  .password_2( password_2),
  .green_led(green_led),
  .red_led(red_led)
  );
  
initial
begin
clock=1'b0;
forever #5 clock=~clock;
end
initial
 begin
 //initialising all values to zero
    reset=0;
    entry_sensor=0;
    exit_sensor=0;
    password_1=0;
    password_2=0;
#50   reset=1'b1;       //resetting the values to 1 for 50 time units.
#10   entry_sensor=1;
      password_2=2'b10;
      password_1=2'b01;
#500  entry_sensor=0;
#1000 exit_sensor=1;
end       
initial
    $monitor ($time, "green_led=%b, red_led=%b",green_led,red_led);        
endmodule
