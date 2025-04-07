  % -*- octave -*-
  % Function to parse an DFA (Deterministic Finite Automaton) transition matrix
  % and process an input text sequence to extract frame positions.
  function [frames]= parseAFD(matriztransicion, texto)
  tipo='';
  frames=[];
  e=-100;
  final=-5;
  edoanterior=e;
  tipo=0;
  tama=0;
  siz=length(texto);
  i=1;
  nn=1;
  m=matriztransicion;
  estado=1;
  inicio=1;
  es=[];
  fn=0;
  edoz=0;
  estado=matriztransicion(1, 1);
  tipo=estado-1;
  estado=1;
  while(length(texto) >= 1)
      try
          if (inicio==1 && estado~=e)
              if(fn==1)
                  [valor, x, c] = funTipo(i, texto{1}, tipo);
                  edoz = matriztransicion(edoanterior, valor+4);
              end
              if(edoz~=final && edoz~=e && tipo==1)
                  inicio = 3;
                  estado = matriztransicion(estado, 1);
              end
              if(edoz~=final && tipo==2)
                  inicio = 3;
                  estado = matriztransicion(estado, 1);
              end
              if(edoz~=final && tipo==3)
                  inicio = 3;
                  estado = matriztransicion(estado, 1);
              end
          end
          if (edoz == final)
              estado = 1;
              fn = 1;
              inicio = 1;
              frames = [frames i];
              if (x ~= -1)
                  i = i + 1;
                  atras = texto{1};
                  texto = texto(2:end);
              else
                  texto{1} = c;
              end
          else
              edoanterior = estado;
              [valor, x, c] = funTipo(i, texto{1}, tipo);
              estado = matriztransicion(edoanterior, valor+4);
              es = [es i];
              if (x ~= -1)
                  i = i + 1;
                  atras = texto{1};
                  texto = texto(2:end);
              else
                  texto{1} = c;
              end
              if (tipo == 1)
                  an = es(1);
                  if(length(es) > 1)
                      for ss = 2:length(es)
                          if(an == es(ss))
                              estado = e;
                              es = [];
                          else
                              an = es(ss);
                          end
                      end
                  end
              end
              if(tipo == 3)
                  tama = length(find(matriztransicion == final));
              end
              if(estado == final)
                  estado = 1;
                  fn = 1;
                  inicio = 1;
                  frames = [frames es];
              end
              if(estado == e)
                  if (estado == e && x == -1)
                      es = es(1:end-1);
                      estado = edoanterior;
                  else
                      estado = 1;
                      fn = 0;
                      es = [];
                      inicio = 1;
                  end
              end
          end
      catch err
          fprintf('Error detectado: %s\n', err.message);
          break;
      end
  end

  if (tipo == 3)
      for w = 1:length(frames)-1
          if (frames(w) > frames(w+1))
              frames(w+1) = 0;
          end
      end
      aux = [];
      for w = 1:siz
          t = length(find(frames == w));
          if(t >= tama)
              aux = [aux w];
          end
      end
      frames = aux;
  end

  if (tipo == 2)
      aux = [];
      for w = 1:siz
          t = length(find(frames == w));
          if(t >= 1)
              aux = [aux w];
          end
      end
      frames = aux;
  end


