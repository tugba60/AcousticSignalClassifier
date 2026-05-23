function [trained_model,test_img] = train_cnn()
%veri bölme işlemleri
klasor_yolu = '../spectrograms/';
images = imageDatastore(klasor_yolu, 'LabelSource', 'foldernames', 'IncludeSubfolders', true);
images.ReadFcn = @(x) imresize(repmat(imread(x), [1 1 3]), [224 224]);
[train_img, temp] = splitEachLabel(images, 0.8, 'randomized');
[val_img, test_img] = splitEachLabel(temp, 0.5, 'randomized');

%model inşası
layers = [
    imageInputLayer([224 224 3])
    %block-1
    %conv2d 32 3x3 - max pool2d - batch norm
    convolution2dLayer(3, 32, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)
    %block-2
    %conv2d 64 3x3 - max pool2d - batch norm
    convolution2dLayer(3, 64, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)
    %block-3
    %conv2d 128 3x3 - max pool2d - batch norm
    convolution2dLayer(3, 128, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)
    %block-4
    %conv2d 64 3x3 - max pool2d - batch norm
    convolution2dLayer(3, 64, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)
    %dropout 0.4
    dropoutLayer(0.4)
    %flatten
    flattenLayer
    %dense 10 softmax
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer
    ];
options = trainingOptions('adam', ... %optimizer -sgd de olabilir
    'MaxEpochs', 5, ...
    'MiniBatchSize', 64, ...
    'ValidationData', val_img, ...
    'ValidationFrequency', 30, ...
    'Plots', 'training-progress', ...
    'Verbose', true);
trained_model = trainNetwork(train_img, layers, options);
save('../results/cnn_model.mat', 'trained_model');
end