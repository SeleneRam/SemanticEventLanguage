  % -*- octave -*-
  % This function reads the content of a file with a specific extension (".sel")
  % and returns the content as a string along with the remaining script to be analyzed
  % and the script name.

  function [programa,nombrep]=leerprograma(name)
  global nombre;
  valor=strsplit(name,'\');
  n=length(valor);
  s=valor{n};
  nombre=strsplit(valor{n},'.');
  nombrep=nombre(1,1);
  name = strrep(name, '"', '''');
  ext=strrep(nombre(2), '"', '''');
  if(exist(name)~=0 && strcmpi(ext,"sel") )
      fid=fopen(name,'r');
      programa=fscanf(fid,'%c');
      fclose(fid);

  else
      if(strcmpi(nombre(2),"sel")==0 )
            error('-Error: Wrong extension');
      else
              error('-Error: File not found %s-', name);
      end
      error('-Error: File not found %s-', name);
  end
