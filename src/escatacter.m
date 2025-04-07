% -*- octave -*-
%This function checks if the given character is a letter
% It returns true if the character is a digit, otherwise false
function r=escatacter(c)
    r=(c>='a'&&c<='z')||(c>='A'&&c<='Z');
end
