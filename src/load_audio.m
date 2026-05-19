%veri setinde yolu (path) belirtilen ses dosyalarının dalga formunu çizme
%fonksiyon tanıımlayalım
function [sinyal,fs] = load_audio(dosyaYolu) %çıktısı sinyal fs örnekleme frekansı olacak, girdisi path
    %ses dosyasını okuma işlemi:
    [sinyal,fs] = audioread(dosyaYolu); %okuma işlemini audioread fonksiyonu ile yapıyoruz
    %ses doysyası hakkında bilgi alıp ona göre işlem yapıyoruz
    if size(sinyal,2)==2 %Eğer 2 sütun varsa yani ses stereo ise
        sinyal = mean(sinyal,2); %iki kanalın ortalamasını alıyor ve tek bir kanala indiriyor -> mono FFT için tek kanal lazım
    end
    t = (0: length(sinyal)-1) / fs; %her örneğin index'ini fs'e bölünce her index'in kaçıncı saniyeye denk geldiğini buluyoruz
    %sinyal çizimi
    figure;
    plot(t,sinyal); %x eksenine t (zaman), y eksenine sinyal (ses genliğini) koy ve çiz
    xlabel('Zaman (sn)');
    ylabel('Sinyalin Genliği');
    title('Ses Dalgası');
    grid on; %arka plana ızgara çiz
end