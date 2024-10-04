# aligned-layer-phase3


### 1. Adım Rust kurulum

# 1. Dosyayı indiri
wget https://raw.githubusercontent.com/Hitasyurekk/aligned-layer-phase3/main/rust

# 2. Dosyayı çalıştırılabilir hale getirin
chmod +x rust

# 3. Scripti çalıştırın
./rust

# 4. Kurulumun doğruluğunu kontrol edin
rustc --version
cargo --version


### 2. Adım Foundry kurulumu


# 1. Sistem güncellemeleri
sudo apt update
sudo apt upgrade -y

# 2. Foundry kurulumu
curl -L https://foundry.paradigm.xyz | bash

# 3. Ortam değişkenlerini ayarlama
echo 'export PATH="$HOME/.foundry/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# 4. Kurulumu doğrulama
foundryup






