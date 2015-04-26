
## Author: Matthew <Matthew@MATTHEW-PC>
## Created: 2015-04-17

function [outval] = GetHealth (serport)
%Checks Device help.
%Returns status , error code, error code. 0 = Good, 1 = Warning, 2 = Error.

try

StartFlag = 0xA5;
Command = 0x52;

Request_Packet = uint8([StartFlag , Command]);


srl_flush(serport, 1);    %Flush Serial Buffers
srl_fwrite(serport, Request_Packet , 'uint8');


%Look for A5 , 5A
flag = 1;
counter = 0;
while flag 
  DataIn = srl_fread(serport, 1, 'uint8');
  HexDataIn = dec2hex(DataIn);
  if DataIn == 0xA5
%    disp('Found A5');
%    HexDataIn = dec2hex(DataIn)
    
    DataIn = srl_fread(serport, 1, 'uint8');
    if DataIn == 0x5A
%    disp('Found 5A');
%    HexDataIn = dec2hex(DataIn)
    flag = 0;
    end
  end
counter = counter +1;
  if counter >10
  disp('Never received response descriptor - Health Status')
    break
  endif
  
end

%We have read the A5 and 5A which leaves 8 bytes left
 DataIn = srl_fread(serport, 8, 'uint8');
% HexDataIn = dec2hex(DataIn);
 
 %Make sure we got valid data
if DataIn(1:5) ~= [0x3 0x00 0x00 0x00 0x06]
  disp('Response Descriptor Wrong - Health Status')
end

%Only return the response data without the descriptor.
 outval = DataIn(6:8);
 
 catch
disp('WARNING:  GetHealth function did not terminate correctly.  Output may be unreliable.')
end
endfunction
