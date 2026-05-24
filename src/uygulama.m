%uygulama
addpath('src')
[signal1, fs1, t1] = load_audio('data/fold1/7061-6-0-0.wav');
compute_spectrogram(signal1, fs1);
[signal2, fs2, t2] = load_audio('data/fold1/7383-3-0-0.wav');
compute_spectrogram(signal2, fs2, 'dog_bark');
[signal3, fs3, t3] = load_audio('data/fold1/17592-5-0-0.wav');
compute_spectrogram(signal3, fs3, 'engine_idling');
generate_all_spectrograms()