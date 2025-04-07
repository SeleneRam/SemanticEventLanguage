% -*- octave -*-
% This function analyzes the instructions of DFA (Deterministic Finite Automaton)
% calculating and recording the transitions and associated labels
function lista=  analisisEtiqueta(afdEnd,arrtiempo, numIntrucciones, AFDEtiqueta, AFDnombres, duracion, totalFrames, nombre, url,fps)

  lista = cell(size(afdEnd));
  contador = cell(size(afdEnd));
    for i = 1:numel(afdEnd)
        values = afdEnd{i};
        values(values == 0) = [];
        contador{i}=0;
        if isempty(values)
            grouped{i} = [];
            continue;
        end


        groups = {};
        group = [values(1)];

        for j = 2:length(values)
            if values(j) == values(j-1) + 1
                group = [group, values(j)];
            else
                groups{end+1} = group;
                group = [values(j)];
            end
        end
        groups{end+1} = group;
        max_values = cellfun(@max, groups);
        val=[];
          contador{i}=[0];
        num=length(max_values);
        contador{i}=num2str(num);

        for o = 1:length(max_values)

          x=( num2str(max_values(o)));
          tiempo=   arrtiempo(str2double(x));
          time_of_frame = (tiempo{1}-1) / fps;
         %time_of_frame = time_of_frame/60;
  if o == 1
        lista{i} = num2str(time_of_frame, '%.2f');
    else
        lista{i} = [lista{i}, ',', num2str(time_of_frame, '%.2f')];
    end
      end

    end



VAR = 0;
disp("Activity count:");
itemlist = {};
nombre=nombre{1,1};
va=[url, nombre, '_result.txt'];
archivo = fopen([url, nombre, '_result.txt'], 'w');

if archivo == -1
  error("Could not open the file for writing.");
endif

fprintf(archivo, "Processed information:\n");

for g = 1:length(lista)
    val=contador{g};
    if(val==0)
      texto = [AFDnombres{g} '=0'  "\n "];
      fprintf(archivo, texto);
      item_text = ['      ' AFDnombres{g} ' = 0' ];
      itemlist = [itemlist, item_text];
    else
    texto = [AFDnombres{g} '=' contador{g} "\n " lista{g} "\n\n"];
    fprintf(archivo, texto);
    item_text = ['      ' AFDnombres{g} ' = '  contador{g}];
    itemlist = [itemlist, item_text];
    end
end

fclose(archivo);
disp(['The file "', nombre, '_result.txt" has been created successfully.']);
list_size = [200, max(150, VAR)];
[indx, tf]  = listdlg("ListString", itemlist, "SelectionMode", "single", "ListSize", list_size);



end
