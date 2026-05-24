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
function spektrogram_matris = compute_spectrogram(sinyal,fs, class_name, dosya_kayit, dosya_adi) %saniyede fs = 44100 örnek
    pencere_boyutu=0.01; %10 milisaniye = 0.01saniye | 25 milisaniye 0.025 saniye
    ornek_sayisi = fs*pencere_boyutu; %0.01 saniyede bu kadar örnek
    %örnek sayısı tam sayı olmalı yuvarlanacak
    ornek_sayisi = round(ornek_sayisi);
    adim=ornek_sayisi/2;
    nfft = 2^nextpow2(ornek_sayisi);%bir sayının üstündeki en yakın 2'nin kuvvetini bulmak için fnk. kullanılır.
    num_pencere = floor((length(sinyal) - ornek_sayisi) / adim) + 1;
    spektrogram_matris = zeros(floor(nfft/2), num_pencere); % Frekans ve zaman matrisi
    for i=1:num_pencere
        bas = 1 + (i-1)*adim;
        bitis = bas + ornek_sayisi - 1;
        pencere = sinyal(bas:bitis);
        % FFT uygula ve sonuçları spektrogram matrisine ekle
        fft_sonuc = fft(pencere, nfft);
        spektrogram_matris(:, i) = abs(fft_sonuc(1:floor(nfft/2)));
    end
    
    %normalizasyon yapılmalı
    spektrogram_db = 20 * log10(spektrogram_matris + 1e-10); %Desibel (dB) cinsine çeviriyor. 
    min_val = min(spektrogram_db(:));
    max_val = max(spektrogram_db(:));
    norm_matris = (spektrogram_db - min_val) / (max_val - min_val); %değerleri 0-1 arasına indirgeme => normalizasyon
   
    imwrite(norm_matris', [dosya_kayit '/' class_name '_' dosya_adi '.png']); %imwrite verileri 0-1 arası bekler
end