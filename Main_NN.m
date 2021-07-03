
setDir  = fullfile('C:/Users/Pierre/Documents/MATLAB/Chess_images');
imds = imageDatastore(setDir,'IncludeSubfolders',true,'LabelSource',...
    'foldernames');

trainingSet = splitEachLabel(imds,2);


numTrainFiles = 200;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');




layers = [
    imageInputLayer([47 47 3])
    convolution2dLayer(5,2,'Padding','same')
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(3)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm', ...
    'MaxEpochs',30, ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

net = trainNetwork(imdsTrain,layers,options);

%{
YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;
accuracy = mean(YPred == YValidation)

lgraph = layerGraph(layers);
lgraph = connectLayers(lgraph,'relu_1','add/in2');

figure
plot(lgraph);
%}

% I = imread("g2.jpg");
% label = classify(net,I);
% figure
% imshow(I)
% title(string(label))