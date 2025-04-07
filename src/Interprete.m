  % -*- octave -*-
  % This script receives the script URL and validates that it is correctly written
  % in the sections into which the script is divided.

  function [programa, videoname,nombrep]=Interprete(script)
      [programa,nombrep]=leerprograma(script);
      [programa, videoname]=fnCabecera(programa);
      programa=fnVariables(programa);
      programa=fnSentencias(programa);
  end
