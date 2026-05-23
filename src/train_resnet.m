function [trained_model, test_img] = train_resnet()
klasor_yolu='../spectrograms/';

images=imageDatastore(klasor_yolu,'LabelSource', 'foldernames', 'IncludeSubfolders', true);
images.ReadFcn = @(x) imresize(repmat(imread(x), [1 1 3]), [224 224]);
[train_img, temp] = splitEachLabel(images, 0.8, 'randomized');
[val_img, test_img] = splitEachLabel(temp, 0.5, 'randomized');%matlab de veri bölme

%resnet yükleme
net = resnet18;
layers = layerGraph(net);
new_fc = fullyConnectedLayer(10, 'Name', 'fc10'); %sınıflandırma kısmını değiştiriyoruz, verimize uygulamak için
new_softmax = softmaxLayer('Name', 'softmax');
new_output = classificationLayer('Name', 'output');
layers = replaceLayer(layers, 'fc1000', new_fc);
layers = replaceLayer(layers, 'prob', new_softmax);
layers = replaceLayer(layers, 'ClassificationLayer_predictions', new_output);

options = trainingOptions('adam', ... %optimizer -sgd de olabilir
    'MaxEpochs', 5, ...
    'MiniBatchSize', 64, ...
    'ValidationData', val_img, ...
    'ValidationFrequency', 30, ...
    'Plots', 'training-progress', ...
    'Verbose', true);
trained_model = trainNetwork(train_img, layers, options);
save('../results/resnet_model.mat', 'trained_model');
end