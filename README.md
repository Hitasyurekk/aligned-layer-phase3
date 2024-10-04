# aligned-layer-phase3


## 1. Adım Rust kurulum

 1. Dosyayı indiri
wget https://raw.githubusercontent.com/Hitasyurekk/aligned-layer-phase3/main/rust

 2. Dosyayı çalıştırılabilir hale getirin
chmod +x rust

 3. Scripti çalıştırın
./rust

 4. Kurulumun doğruluğunu kontrol edin
rustc --version
cargo --version


## 2. Adım Foundry kurulumu


 1. Sistem güncellemeleri
sudo apt update
sudo apt upgrade -y

 2. Foundry kurulumu
curl -L https://foundry.paradigm.xyz | bash

3. Ortam değişkenlerini ayarlama
echo 'export PATH="$HOME/.foundry/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

 4. Kurulumu doğrulama
foundryup

## 3. Adım Config kurulum

sudo apt update && sudo apt install pkg-config libssl-dev


## 4. Adım private key girme 

[ -d ~/.aligned_keystore ] && rm -rf ~/.aligned_keystore && echo "Deleted existing directory ~/.aligned_keystore." ; mkdir -p ~/.aligned_keystore && cast wallet import ~/.aligned_keystore/keystore0 --interactive

## 5. Adım Aligned dosyalarını indirme 

git clone https://github.com/yetanotherco/aligned_layer.git

cd aligned_layer/examples/zkquiz

make answer_quiz KEYSTORE_PATH=~/.aligned_keystore/keystore0

## 6. Adım quiz cevapları 

y , c , c , a , y



