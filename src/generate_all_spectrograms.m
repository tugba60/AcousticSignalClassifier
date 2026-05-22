function generate_all_spectrograms()
data_info = readtable('../data/UrbanSound8K.csv');
classes=unique(data_info.class);
for i=1:length(classes)
    mkdir(['../spectrograms/' classes{i}]);
end
for j=1:height(data_info)
    dosya_adi=data_info.slice_file_name{j};
    fold=data_info.fold(j);
    path=['../data/fold' num2str(fold) '/' dosya_adi];
    class_name=data_info.class{j};
    [sinyal,fs,t]=load_audio(path);
    %compute_spectrogram(sinyal,fs, class_name, dosya_kayit, dosya_adi)
    kayit_yolu = ['../spectrograms/' class_name];
    matris = compute_spectrogram(sinyal,fs,class_name, kayit_yolu,dosya_adi);
end
end