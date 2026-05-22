% STFT şunu yapıyor: sinyali küçük zaman pencerelerine böl, her pencereye ayrı ayrı FFT uygula,
%sonuçları yan yana diz. Böylece hem frekans hem zaman bilgisi korunuyor.
% Sonuç 2D bir matris — x ekseni zaman, y ekseni frekans, renk ise o anda o frekanstaki güç. 
%Buna spektrogram deniyor. Görsel olarak bir görüntü gibi duruyor.
%Üç parametre var:
%Pencere boyutu: Her pencerede kaç örnek olacak. 
% Büyük pencere → frekans çözünürlüğü iyi ama zaman çözünürlüğü kötü. 
% Küçük pencere → tersi.
%Overlap: Pencereler ne kadar üst üste binecek. Genellikle %50-75 arası seçilir.
%FFT boyutu: Her pencereye uygulanacak FFT'nin boyutu.

%Bu fonksiyon; sinyal ve fs alacak, sinyali küçük pencerelere bölecek, her pencereye FFT uygulayacak,
%sonuçları yan yana dizerek 2D spektrogram oluşturacak, ve bunu görüntü olarak kaydedecek.
function spektrogram_matris = compute_spectrogram(sinyal,fs, class_name) %saniyede fs = 44100 örnek
    pencere_boyutu=0.025; %25 milisaniye 0.025 saniye
    ornek_sayisi = fs*pencere_boyutu; %0.025 saniyede bu kadar örnek
    %örnek sayısı tam sayı olmalı yuvarlanacak
    ornek_sayisi = round(ornek_sayisi);
    adim=ornek_sayisi/2;
    nfft = 2^nextpow2(ornek_sayisi);%bir sayının üstündeki en yakın 2'nin kuvvetini bulmak için fnk. kullanılır.
    num_pencere = floor((length(sinyal) - ornek_sayisi) / adim) + 1;
    spektrogram_matris = zeros(nfft/2, num_pencere); % Frekans ve zaman matrisi
    for i=1:num_pencere
        bas = 1 + (i-1)*adim;
        bitis = bas + ornek_sayisi - 1;
        pencere = sinyal(bas:bitis);
        % FFT uygula ve sonuçları spektrogram matrisine ekle
        fft_sonuc = fft(pencere, nfft);
        spektrogram_matris(:, i) = abs(fft_sonuc(1:nfft/2));
    end
    figure;
    imagesc(spektrogram_matris);
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    title(strcat('Spectrogram -',class_name));
    colorbar;
    
    saveas(gcf, ['results/spectrogram_' class_name '.png']);
end