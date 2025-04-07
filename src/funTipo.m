  % -*- octave -*-
  % This function evaluates a given character and returns a corresponding integer value
  function [r, i,c]=funTipo(i, c,tipo)
      if (length(c)>1)
          r=c(1);
          c=c(2:end);
          i=-1;
      else
          r=c;
      end
  end
