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

%Request Packet format on pg 7 of interface manual and shown below
%Required
StartFlag = 0xA5;
Command = 0x21;


Request_Packet = uint8([StartFlag , Command]);


srl_flush(serialport, 1);    %Flush Serial Buffers
pause
srl_fwrite(serialport, Request_Packet , 'uint8');


%tic
%while 1-toc >0
%
%  DataIn = srl_fread(serialport, 1, 'uint8');
%  HexDataIn = dec2hex(DataIn)
%end

%Look for A5 , 5A
flag = 1;
while flag 
  DataIn = srl_fread(serialport, 1, 'uint8');
  HexDataIn = dec2hex(DataIn);
  if DataIn == 0xA5
    disp('Found A5');
    HexDataIn = dec2hex(DataIn)
    
    DataIn = srl_fread(serialport, 1, 'uint8');
    if DataIn == 0x5A
    disp('Found 5A');
    HexDataIn = dec2hex(DataIn)
    flag = 0;
    end
  end

end

%while 1
DataIn = srl_fread(serialport, 27, 'uint8')
  HexDataIn = dec2hex(DataIn)
%end

 
  
  

  disp('Run Functions');
  
  test = LidarStop(serialport);
  pause(1)

%Functions you can use. Some still need testing
Health = GetHealth(serialport)
%Info = GetDevInfo(serialport)
%LidarReset(serialport);
%LidarStop(serialport);


test = LidarStop(serialport);

%fclose(serialport)


