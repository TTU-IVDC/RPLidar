
## Author: Matthew <Matthew@MATTHEW-PC>
## Created: 2015-04-17

function [ret] = LidarReset (serport)
%Reboots Lidar 
%Wait 2ms before sending new commands after. Use when entered protected stop state.

StartFlag = 0xA5;
Command = 0x40;

Request_Packet = uint8([StartFlag , Command]);


srl_flush(serport, 1);    %Flush Serial Buffers
srl_fwrite(serport, Request_Packet , 'uint8');
ret = 1;
endfunction
