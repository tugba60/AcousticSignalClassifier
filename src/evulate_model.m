function evulate_model(model,test_img,model_Name)
predicted = classify(model, test_img);
true_labels= test_img.Labels;
accuracy = sum(predicted == true_labels) / length(true_labels) * 100;
fprintf('Test Accuracy: %.2f%%\n', accuracy);
figure;
confusionchart(true_labels, predicted);
title(['Confusion Matrix' model_Name]);
saveas(gcf, ['../results/confusion_matrix' model_Name '.png']);
end