
% -*- octave -*-
% This function retrieves the movement and the states where movement occurs.
% This script analyzes the current frame to search for movement, validating if movement is present in that frame.
% If movement is detected, it returns a set of areas where movement was detected, as well as the remaining part of the video to be analyzed.


function [B, video, actual, f, n, total] = mov(matriz, estados, video, anterior, f, i,n, frame, total)
  k = 1;
  movbanterior = f;
  pkg load image

  global im2bwThreshold =.5;
  val=readFrame(video);
  n++;
  try
    actual = double(rgb2gray(val));
    var=1;

    % Reads up to a maximum number of frames to speed up processing
      % and enhance motion detection
    while (hasFrame(video) && var<19)
      n++;
      var++;
      actual = double(rgb2gray(readFrame(video)));

    end
  actual = imresize(actual, 0.30);
  actual = imsmooth(actual, "Gaussian", 1);
  diferencia = abs(actual - anterior);
  umbral2 = mean(diferencia(:)) + std(diferencia(:)) * 1.5;
  umbral = std(diferencia(:));
  movimiento = diferencia > umbral;

  movimiento = bwareaopen(movimiento, 120);
  movimiento = imclose(movimiento, strel('disk', 8,0));
  B = imresize(movimiento, [16 9]);

  if (umbral < 2)
    r = zeros(size(f));  %
    B = imresize(r, [16 9]);
  endif


  % show the motion
 % subplot(1,3,1);
  %imagesc(uint8(actual));
  %title("Actual frame");

  %subplot(1,3,2);
  %imagesc(movimiento);
  %title("Motion Detected");
  catch
            actual=readFrame(video);
               if (size(actual,1)==0)
                  total=n;
               endif
          B = zeros(16, 9);

end



end

