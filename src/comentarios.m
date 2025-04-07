% -*- octave -*-
% This function checks if a given string contains comments.
function programa=comentarios(programa)
p=programa;
[val, ~, programa]=parse(programa);
while(double(programa(1)~=10))
    programa=programa(2:end);
end
%%disp('comentario');
end
