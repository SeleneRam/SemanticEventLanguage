% -*- octave -*-
% This function checks if the given special characters
% It returns true if the character is a digit, otherwise false
function r=espuntos(c)
r=0;
arreglo=[',' '\ ' '[' ']' ':' '"' '.' '=' '/' '%' '(' ')' '-'];
for i=1:length(arreglo)
    if(c==arreglo(i))
         r=(c==arreglo(i));
    end
end
end
