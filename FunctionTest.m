pkg load instrument-control
%PAGER("more");
%page_output_immediately (1);
more off

close all
clear all
clc

%Test if serial is working
if (exist("serial") == 3)
    disp("Serial: Supported")
else
    disp("Serial: Unsupported")
endif
serialport = serial("COM5", 115200)

Health = GetHealth(serialport)




srl_flush(serialport);    %Flush Serial Buffers


  
%Functions you can use. Some still need testing
Health = GetHealth(serialport)
Info = GetDevInfo(serialport)
LidarReset(serialport);
%LidarStop(serialport);


test = LidarStop(serialport);

fclose(serialport)


