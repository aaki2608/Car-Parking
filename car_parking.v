`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/08/2020 11:21:46 AM
// Design Name: 
// Module Name: car_parking
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

//A verilog project for car parking
module car_parking(
input clock,reset,
input entry_sensor,exit_sensor,     //sensor will chech whether car is entring or want to exit
input[0:1] password_1,password_2,   //password_1, for entry and, password_2,for exit
output reg green_led,red_led);    // green led for entry,red to stop
parameter idle=4'b0000,ent_password=4'b0001,wrong_password=3'b010,ent_car=4'b0100,stop=4'b1000;
reg [0:2]pre_state,next_state;
always @(posedge clock or negedge reset)
    begin
        if(~reset)
            pre_state=idle;
        else
            pre_state=next_state;
    end
always @(*) begin
//code for the state diagram
    case(pre_state)
        idle: begin
                if (entry_sensor==1)
                next_state<=ent_password;
                else
                next_state<=idle;
              end                
        ent_password : begin
                if ((password_2==2'b10)&&(password_1==2'b01))
                next_state<=ent_car;
                else
                next_state<=wrong_password;
              end        
        wrong_password:  begin
                if ((password_1==2'b01)&&(password_2==2'b10))
                next_state<=ent_car;
                else
                next_state<=wrong_password;
              end
        ent_car:  begin
                if ((exit_sensor==1)&&(entry_sensor==0))
                next_state<=idle;
                else if((exit_sensor==1)&&(entry_sensor==1))
                next_state<=stop;
                else if(exit_sensor==0)
                next_state<=ent_car;    
              end
        stop:  begin
                if ((password_2==2'b10)&&(password_1==2'b01))
                next_state<=ent_car;
                else
                next_state<=stop;
              end
        default : begin
                  next_state<=idle;
                  end
         endcase
         end
always @ (posedge clock) begin
//code for the led 
    case(pre_state)
        idle : begin
                green_led=1'b0;
                red_led=1'b0;
               end 
        ent_password:  begin
                green_led=1'b0;
                red_led=1'b1;
               end           
        wrong_password: begin
                green_led=1'b0;
                red_led=~red_led;
               end   
        ent_car: begin
                green_led=1'b1;
                red_led=1'b0;
               end     
        stop: begin
                green_led=~green_led;
                red_led=1'b1;
               end
        endcase
        end                                                                                                                
endmodule
