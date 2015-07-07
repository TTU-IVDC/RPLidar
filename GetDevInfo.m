

function [outval] = GetDevInfo (serport)
%Checks Device info.
%Returns ..

try
StartFlag = 0xA5;
Command = 0x50;

Request_Packet = uint8([StartFlag , Command]);


srl_flush(serport, 1);    %Flush Serial Buffers
srl_fwrite(serport, Request_Packet , 'uint8');




 DataIn = srl_fread(serport, 27, 'uint8');
% HexDataIn = dec2hex(DataIn);
 
 %Make sure we got valid data
if DataIn(1:7) ~= [0xA5 0x5A 0x14 0x00 0x00 0x00 0x04]
  disp('Response Descriptor Wrong - Health Status')
end

%Only return the response data without the descriptor.
 outval = DataIn(8:27);
 catch
disp('WARNING:  GetInfo function did not terminate correctly.  Output may be unreliable.')
end
endfunction
