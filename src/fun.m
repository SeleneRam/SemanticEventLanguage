     % -*- octave -*-
    % This script receives a character and returns the type of character to be used in7
    % the automaton's matrix.

 function r=fun(c)
      if(espuntos(c))
        r=4;
    elseif(esdigito(c))
        r=2;
    elseif(escatacter(c))
        r=1;
    elseif(espunto(c))
        r=6;
    elseif((c=='_'))
        r=3;
    elseif((c==')'))
        r=9;
    elseif((c=='('))
        r=9;
    elseif(esdelimitador(c))
        r=7;
    else
       r=-10;
    end
  end
