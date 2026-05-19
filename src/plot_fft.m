function plot_fft(sinyal,fs) %dışarıya bir şey döndürmüyor sadece grafik çiziyor bu nedenle çıktısı yok
    %frekans ekseni oluşturuken N sayısına ihtiyacımız var.
    N=length(sinyal); %sinyaldeki toplam örnek sayısı. fs = 44100 x 2.5 saniye, yani N yaklaşık 110000 civarında bir sayı olacak.
    
    %fft işlemi için fft() fonksiyonunu çağırmak gerek
    %fft_result da N tane sayı var — ama bunlar karmaşık sayılar
    fft_sonuc=fft(sinyal,N);%sinyal vektörünü frekans domenine taşıyor.
    %karmaşık sayıları gerçek sayılara çeviriyoruz
    
    buyukluk = abs(fft_sonuc); %vektöründe her frekans için "ne kadar güçlü" bilgisi var, artık karmaşık sayı yok.
    %FFT gerçek sayılardan oluşan bir sinyale uygulandığında matematiksel olarak simetrik bir sonuç üretiyor. 
    %Yani 0-22050 Hz arası ile 22050-44100 Hz arası birebir aynı bilgiyi taşıyor.
    %FFT matematiksel olarak negatif frekansları da hesaplıyor ve onları ikinci yarıya koyuyor.
    buyukluk = buyukluk(1:floor(N/2));%FFT sonucu N tane değer üretiyor ama bunun ikinci yarısı birinci yarının aynası
    
    %frekans eksenini oluşturalım
    frekans=linspace(0,fs/2,N/2); %N/2 ADET EŞİT ARALIKLI NOKTA OLACAK
    
    %GÖRSELLEŞTİRELİM
    figure;
    plot(frekans,buyukluk);
    xlabel('Frekans (Hz)');
    ylabel('Büyüklük');
    title('FFT ile Frekans Domenini')
    grid on;
end

%plot_fft(sinyal,fs); ile çağırıyoruz