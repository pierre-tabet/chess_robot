


I = snapshot(cam); %Takes picture of board 
img = imrotate(I,180,'bilinear');  %Rotates image 180
[rows, columns, numberOfColorChannels] = size(img); %notes dimensions of picture


%% Saves 46 by 46 images used to train the ConvNet
load('C:/Users/Pierre/Documents/MATLAB/Detection/imagePoints.mat');

for a = 1:64
   Z = imcrop(img,[imagePoints(a,1) imagePoints(a,2) 46 46]);
baseFileName = sprintf('%d.jpg',a + b); 
fullFileName = fullfile('C:/Users/Pierre/Documents/MATLAB/Photos', baseFileName);
imwrite(Z, fullFileName);

end  
b = b + 64;



