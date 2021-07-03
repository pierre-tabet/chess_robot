clc;    % Clear command window
close all;  % Close all the figures 
clear;  % Erase all existing variables
workspace;
%%
ex2 = imread('example2.png');
th = [0 0.417]; %threshold for canny
s = sqrt(3); %sigma for canny
Ig = rgb2gray(ex2);
B = edge(Ig,'Canny',th,s); 
 %Hough Transformation
 [H, theta, rho] = hough(B, 'RhoResolution',0.9,'ThetaResolution',0.09);
 peaks  = houghpeaks(H,19,'threshold',ceil(0.3*max(H(:)))); %wiki
 %Finding Lines
 lines = houghlines(B, theta, rho, peaks, 'FillGap', 350, 'MinLength', 20);
 figure(2)
 imshow(ex2)
 hold on
 %%
 maxLength = 0;
%Show lines
for i = 1 : length(lines)
    xy = [lines(i).point1; lines(i).point2];
    % LineSHow
    plot( xy(:, 1), xy(:, 2), 'LineWidth', 2, 'Color', 'red' );
    % Length of line
    lengthOfLines(i) = norm(lines(i).point1 - lines(i).point2);
    % Find angle
    angles(i) = lines(i).theta;
    % Check if this is the longest line
    if ( lengthOfLines > maxLength )
        maxLength = lengthOfLines;
        xyLongest = xy;
    end
end
