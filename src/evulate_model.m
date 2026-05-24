function evulate_model(model,test_img,model_Name) %önceden eğitilen model, ayrılan test verisi, görselleştirme için model adı
predicted = classify(model, test_img); %test verisi ile tahminleme yap
true_labels= test_img.Labels;
accuracy = sum(predicted == true_labels) / length(true_labels) * 100; %manuel başarı hesabı
fprintf('Test Accuracy: %.2f%%\n', accuracy);
figure;
confusionchart(true_labels, predicted); %confusion matris çiz
title(['Confusion Matrix' model_Name]);
saveas(gcf, ['../results/confusion_matrix' model_Name '.png']);
end