  % -*- octave -*-
  % This script loads a .sel file and processes a video.
  % It extracts program characteristics, analyzes the video, and displays the results.

  clc;
  clear all;
  close all;
  warning("off", "all");
  pkg load video;
  pkg load image;

  prompt = {'SEL SCRIPT NAME:'};
  dlgtitle = 'S E L';
  fieldsize = [1 15];
  inputdlgdefinput = {''};
  answer = inputdlg(prompt, dlgtitle, fieldsize, inputdlgdefinput);
  duracion = 0;
  fps=0;
  val = answer{1, 1};
  val;
  totalFrames = 0;
  variable = true;
  result = strsplit(val, ".sel");
  url="";
  if length(result) > 1
    nombre = result{1};%The format must be [name].sel');
    url=nombre;
  end


  if length(result) > 1
    nombre = result{1};
  end
  while (variable)
    n = 1;
    i = 0;
    [AFD, AFDnombres, AFDEtiqueta, estados, arrayEdos, videoname,nombrep] = principal(val);
    partes = strsplit(url, '\');
    url = strjoin(partes(1:end-1), '\');
    url=[url,'\'];
    video = VideoReader(videoname);
    matriz = AFD;
    actual = double(rgb2gray(readFrame(video)));
    numIntrucciones = length(matriz);
    afd2 = {};
    actual = double(rgb2gray(readFrame(video)));
    actual = imresize(actual, .30);
    actual = zeros(size(actual));
    f = ones(size(actual));
    ORIGINAL = readFrame(video);
    actual = double(rgb2gray(readFrame(video)));
    actual = imresize(actual, .30);
    disp("   W O R K I N G. . . 0%");
    h = waitbar(0, 'W O R K I N G. . .');
    total = video.NumberOfFrames;
    duracion = video.Duration;
    fps = video.FrameRate;
    POS=n;
    frame = double(rgb2gray(readFrame(video)));
    arrtiempo=[];
    n=0;
    while (hasFrame(video) && n<total)
      [video, temporal, actual, f,n, total] = analisisAFD(video, estados, matriz, arrayEdos, actual, f, i,n, frame, total);
      videoP = video;
      afd2{POS} = temporal;
      arrtiempo{POS}=n;
      POS++;
      if ( mod(n, 10) == 1 || mod(n, 5) == 1 )
        porcentaje = n * 100 / total;
        disp(["   W O R K I N G. . . " int2str(porcentaje) '%']);
        waitbar(n / total, h, sprintf('W O R K I N G. . . %d%%', round((n / total) * 100)));
      end
    end

    waitbar(10/10, h, sprintf('W O R K I N G. . . %d%%',100));
    close(h);

    afdEnd = [];
    afd2 = afd2(2:end);
    for xx = 1:numIntrucciones
      frames = parseAFD(AFD{xx}, afd2);
      frames = [frames 0];
      afdEnd{xx} = frames;
    end
    analisisEtiqueta(afdEnd, arrtiempo,  numIntrucciones, AFDEtiqueta, AFDnombres, duracion, totalFrames,nombrep,url,fps);
    variable = false;
  end

