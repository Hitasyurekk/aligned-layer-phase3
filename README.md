# aligned-layer-phase3


## 1. Adım Rust kurulum


wget https://raw.githubusercontent.com/Hitasyurekk/aligned-layer-phase3/main/rust.sh && chmod +x rust.sh && ./rust.sh

## 2. Adım Foundry kurulumu

curl -L -o foundry.sh https://raw.githubusercontent.com/Hitasyurekk/aligned-layer-phase3/main/foundry.sh && chmod +x foundry.sh && ./foundry.sh


## 3. Adım Config kurulum

sudo apt update && sudo apt install pkg-config libssl-dev


## 4. Adım private key girme 

[ -d ~/.aligned_keystore ] && rm -rf ~/.aligned_keystore && echo "Deleted existing directory ~/.aligned_keystore." ; mkdir -p ~/.aligned_keystore && cast wallet import ~/.aligned_keystore/keystore0 --interactive

## 5. Adım Aligned dosyalarını indirme 

[ -d aligned_layer ] && rm -rf aligned_layer && echo "Deleted existing aligned_layer directory." ; git clone https://github.com/yetanotherco/aligned_layer.git && cd aligned_layer/examples/zkquiz


make answer_quiz KEYSTORE_PATH=~/.aligned_keystore/keystore0

## 6. Adım quiz cevapları 

y , c , c , a , y



