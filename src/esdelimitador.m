% -*- octave -*-
% This function checks if the given character is a delimiter
% It returns true if the character is a digit, otherwise false
function r=esdelimitador(c)
  c=double(c);
  r=(c==' '||c==8 || c==10 || c==13|| c==11 );
end
