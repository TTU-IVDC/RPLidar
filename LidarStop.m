
## Author: Matthew <Matthew@MATTHEW-PC>
## Created: 2015-04-17

function [ret] = LidarStop (serport)
%Stops scan and disables laser
%Wait 1ms before sending new commands after

StartFlag = 0xA5;
Command = 0x25;

Request_Packet = uint8([StartFlag , Command]);


srl_flush(serport, 1);    %Flush Serial Buffers
srl_fwrite(serport, Request_Packet , 'uint8');

ret = 1;
endfunction
