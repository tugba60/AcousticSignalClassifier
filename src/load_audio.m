%veri setinde yolu (path) belirtilen ses dosyalarının dalga formunu çizmek
%için gerekli bilgileri üretme
%fonksiyon tanımlayalım
function [sinyal,fs,t] = load_audio(dosyaYolu) %çıktısı sinyal, fs örnekleme frekansı ve t olacak, girdisi path
    %ses dosyasını okuma işlemi
    [sinyal,fs] = audioread(dosyaYolu); % matlab de okuma işlemini audioread fonksiyonu ile yapıyoruz
    %ses doysyası hakkında bilgi alıp ona göre işlem yapıyoruz
    if size(sinyal,2)==2 %Eğer 2 sütun varsa yani ses stereo ise ki sinyal verisi 2 sütunlu
        sinyal = mean(sinyal,2); %iki kanalın ortalamasını alıyor ve tek bir kanala indiriyor -> mono, FFT için tek kanal lazım
                          %2 parametresi her satırın ortalamasını al demek
    end
    t = (0: length(sinyal)-1) / fs; %her örneğin index'ini fs'e bölünce her index'in kaçıncı saniyeye denk geldiğini buluyoruz
    
end

%fs = 44100 çıktı veriyorsa — bu dosya saniyede 44100 örnek içeriyor demek

%addpath('src') %src den de çağırmam gerekenler olabilir dahil et
%[signal, fs, t] = load_audio('../data/fold1/7061-6-0-0.wav') ile çağırıyoruz