function compare_classes(fName1,fName2,fName3) %7061-6-0-0.wav,7383-3-0-0.wav ,17592-5-0-0.wav
%birden fazla ses dosyası yükleyip grafiklerini zaman domeninde çizelim
%zaman domeninde olan sesleri frekans domenine çevirip görselleştirelim
%result klasörüne png formatı ile kayıt edelim
figure;
data_info = readtable('data/UrbanSound8K.csv');
class1=data_info(strcmp(data_info.slice_file_name, fName1), :).class;%böyle bir veri çekilir
fprintf(strcat(class1{1},'Grafikleri'));
subplot(3,2,1);
[signal1, fs1, t1] = load_audio(strcat('data/fold1/',fName1));
%sinyal çizimi
    plot(t1,signal1); %x eksenine t (zaman), y eksenine sinyal (ses genliğini) koy ve çiz
    xlabel('Zaman(sn)');
    ylabel('Sinyalin Genliği');
    title(strcat(class1{1},' Sınıfı Ses Dalgası'));
    grid on; %arka plana ızgara çiz
subplot(3,2,2);
[frekans1, buyukluk1]=plot_fft(signal1,fs1);
%GÖRSELLEŞTİRELİM
    plot(frekans1,buyukluk1);
    xlabel('Frekans (Hz)');
    ylabel('Büyüklük');
    title(strcat('FFT ile Frekans Domenini - ',class1{1}))
    grid on;

class2=data_info(strcmp(data_info.slice_file_name, fName2), :).class;%böyle bir veri çekilir
fprintf(strcat(class2{1},'Grafikleri'));
subplot(3,2,3);
[signal2, fs2, t2] = load_audio(strcat('data/fold1/',fName2));
%sinyal çizimi
    plot(t2,signal2); %x eksenine t (zaman), y eksenine sinyal (ses genliğini) koy ve çiz
    xlabel('Zaman(sn)');
    ylabel('Sinyalin Genliği');
    title(strcat(class2{1},' Sınıfı Ses Dalgası'));
    grid on; %arka plana ızgara çiz
subplot(3,2,4);
[frekans2, buyukluk2]=plot_fft(signal2,fs2);
%GÖRSELLEŞTİRELİM
    plot(frekans2,buyukluk2);
    xlabel('Frekans (Hz)');
    ylabel('Büyüklük');
    title(strcat('FFT ile Frekans Domenini - ',class2{1}))
    grid on;

class3=data_info(strcmp(data_info.slice_file_name, fName3), :).class;%böyle bir veri çekilir
fprintf(strcat(class3{1},'Grafikleri'));
subplot(3,2,5);
[signal3, fs3, t3] = load_audio(strcat('data/fold1/',fName3));
%sinyal çizimi
    plot(t3,signal3); %x eksenine t (zaman), y eksenine sinyal (ses genliğini) koy ve çiz
    xlabel('Zaman(sn)');
    ylabel('Sinyalin Genliği');
    title(strcat(class3{1},' Sınıfı Ses Dalgası'));
    grid on; %arka plana ızgara çiz
subplot(3,2,6);
[frekans3, buyukluk3]=plot_fft(signal3,fs3);
%GÖRSELLEŞTİRELİM
    plot(frekans3,buyukluk3);
    xlabel('Frekans (Hz)');
    ylabel('Büyüklük');
    title(strcat('FFT ile Frekans Domenini - ',class3{1}))
    grid on;

saveas(gcf, 'results/class_comparison.png'); % gcf şu an açık olan veriyi kaydet demek
end