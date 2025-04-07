
% -*- octave -*-
% This script requests the information already obtained from the script (video URL, states, modeled activities),
% and analyzes each frame to detect movement. It detects if movement is detected in any state
% and tracks each activity according to the states.

function [video, temporal, actual, f, n, total] = analisissAFD(video, estados, matriz, arrayEdos, actual, f, i,n,frame, total)
    [B, video, actual, f, n , total] = mov(matriz, estados, video, actual, f, i,n,frame,total);
    D = 0;
    temporal = [0];
    for j = 1:length(estados)
        if (sum(sum(arrayEdos{j} .* B)) ~= 0)
            temporal = [temporal, j];
            D = (arrayEdos{j} * j) + D;
        end
    end

end

