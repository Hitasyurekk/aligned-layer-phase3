#!/bin/bash

# Rust kurulumunun yerini tanımlayın
RUSTUP_HOME="$HOME/.rustup"
CARGO_HOME="$HOME/.cargo"
LOG_FILE="$HOME/rust_install.log"

# Çıktıyı dosyaya ve konsola kaydedin
exec > >(tee -a "$LOG_FILE") 2>&1

# Rust ortam değişkenlerini yükle
load_rust() {
    export RUSTUP_HOME="$HOME/.rustup"
    export CARGO_HOME="$HOME/.cargo"
    export PATH="$CARGO_HOME/bin:$PATH"
    if [ -f "$HOME/.cargo/env" ]; then
        source "$HOME/.cargo/env"
    fi
}

# Rust için gerekli sistem bağımlılıklarını yükle
install_dependencies() {
    echo "Rust için gerekli sistem bağımlılıkları yükleniyor..."
    if command -v apt &> /dev/null; then
        sudo apt update && sudo apt install -y build-essential libssl-dev curl
    elif command -v yum &> /dev/null; then
        sudo yum groupinstall 'Development Tools' && sudo yum install -y openssl-devel curl
    elif command -v dnf &> /dev/null; then
        sudo dnf groupinstall 'Development Tools' && sudo dnf install -y openssl-devel curl
    elif command -v pacman &> /dev/null; then
        sudo pacman -Syu base-devel openssl curl
    elif command -v brew &> /dev/null; then
        echo "MacOS tespit edildi, bağımlılıkları Homebrew ile yüklüyor..."
        brew install openssl curl
    else
        echo "Desteklenmeyen paket yöneticisi, lütfen bağımlılıkları manuel olarak yükleyin."
        exit 1
    fi
}

# Rust'ı kontrol etmeden önce sistem bağımlılıklarını yükle
install_dependencies

# Rust'ın yüklü olup olmadığını kontrol et
if command -v rustup &> /dev/null; then
    echo "Rust yüklü."
    read -p "Rust'ı yeniden yüklemek veya güncellemek istiyor musunuz? (y/n): " choice
    if [[ "$choice" == "y" ]]; then
        echo "Uyarı: Rust'ı yeniden yüklemek mevcut ayarlarınızı silecektir."
        read -p "Devam etmek istediğinize emin misiniz? (y/n): " confirm
        if [[ "$confirm" == "y" ]]; then
            echo "Rust yeniden yükleniyor..."
            rustup self uninstall -y
            if ! curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y; then
                echo "Hata: Rust yüklemesi başarısız oldu. Çıkılıyor."
                exit 1
            fi
        else
            echo "Yeniden yükleme iptal edildi."
            exit 0
        fi
    fi
else
    echo "Rust yüklü değil. Rust yükleniyor..."
    if ! curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y; then
        echo "Hata: Rust yüklemesi başarısız oldu. Çıkılıyor."
        exit 1
    fi
fi

# Yükleme sonrası Rust ortamını yükle
load_rust 

# Rust dizinlerinin izinlerini düzelt
echo "Rust dizinlerinin izinlerinin doğru olduğundan emin olunuyor..."
chmod -R 755 "$RUSTUP_HOME"
chmod -R 755 "$CARGO_HOME"

# Cargo'nun bulunabilmesi için ortamı yeniden yüklemeyi dene
retry_cargo() {
    local max_retries=3
    local retry_count=0
    local cargo_found=false

    while [ $retry_count -lt $max_retries ]; do
        if command -v cargo &> /dev/null; then
            cargo_found=true
            break
        else
            echo "Mevcut oturumda Cargo bulunamadı. Ortamı yeniden yüklemeye çalışıyor (deneme $((retry_count + 1))/$max_retries)..."
            source "$HOME/.cargo/env"
            retry_count=$((retry_count + 1))
            sleep 1  # Yeniden deneme arasında gecikme ekle
        fi
    done

    if [ "$cargo_found" = false ]; then
        echo "Hata: $max_retries deneme sonrasında Cargo hâlâ tanınmıyor."
        echo "Lütfen ortamı manuel olarak yükleyin: source \$HOME/.cargo/env çalıştırın."
        return 1
    fi

    echo "Mevcut oturumda Cargo kullanılabilir."
    return 0
}

# Mevcut shell'in yapılandırma dosyasını al
get_profile() {
    if [[ $SHELL == *"zsh"* ]]; then
        echo "$HOME/.zshrc"
    else
        echo "$HOME/.bashrc"
    fi
}

PROFILE=$(get_profile)

# Rust ortam değişkenlerini ilgili shell yapılandırma dosyasına ekle
if ! grep -q "CARGO_HOME" "$PROFILE"; then
    echo "$PROFILE dosyasına Rust ortam değişkenleri ekleniyor..."
    {
        echo 'export RUSTUP_HOME="$HOME/.rustup"'
        echo 'export CARGO_HOME="$HOME/.cargo"'
        echo 'export PATH="$CARGO_HOME/bin:$PATH"'
        echo 'source "$HOME/.cargo/env"'
    } >> "$PROFILE"
else
    echo "Rust ortam değişkenleri $PROFILE dosyasında zaten mevcut."
fi

# Mevcut oturumda yapılandırma dosyasını otomatik olarak yeniden yükle
source "$PROFILE"

# Cargo ortamını yeniden yüklemeyi zorla
source "$HOME/.cargo/env"

# Cargo'nun kullanılabilir olup olmadığını yeniden kontrol et
retry_cargo
if [ $? -ne 0 ]; then
    exit 1
fi

# Rust ve Cargo sürümlerini doğrula
rust_version=$(rustc --version)
cargo_version=$(cargo --version)

echo "Rust sürümü: $rust_version"
echo "Cargo sürümü: $cargo_version"

echo "Rust kurulumu ve ayarları tamamlandı!"

echo -e "\n###############################"
echo "# The guide was prepared by Hitasyurek."
echo "###############################\n"

echo "Tw / X : https://x.com/hitasyurek"
echo "TG : https://t.me/ROVEtm\n"
