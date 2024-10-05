#!/bin/bash

# Birinci Adım: Foundry'nin resmi kurulum betiğini kullanarak foundryup'u kurun
curl -L https://foundry.paradigm.xyz | bash

# İkinci Adım: Foundry ikili dosyalarının (forge, cast, anvil) yolunu PATH ortam değişkenine ekleyin
if ! grep -q 'export PATH="$HOME/.foundry/bin:$PATH"' ~/.bashrc; then
  echo 'export PATH="$HOME/.foundry/bin:$PATH"' >> ~/.bashrc
fi

if ! grep -q 'export PATH="$HOME/.foundry/bin:$PATH"' ~/.zshrc 2>/dev/null; then
  echo 'export PATH="$HOME/.foundry/bin:$PATH"' >> ~/.zshrc
fi

# Üçüncü Adım: Değişikliklerin hemen etkili olması için .bashrc veya .zshrc dosyasını güncelleyin
if [ "$SHELL" = "/bin/bash" ]; then
  export PATH="$HOME/.foundry/bin:$PATH"  # Mevcut shell için kullanılabilir hale getirin
  source ~/.bashrc                        # Gelecekteki bash shell'leri için geçerli olacak
elif [ "$SHELL" = "/bin/zsh" ]; then
  export PATH="$HOME/.foundry/bin:$PATH"  # Mevcut shell için kullanılabilir hale getirin
  source ~/.zshrc                         # Gelecekteki zsh shell'leri için geçerli olacak
fi

# Dördüncü Adım: Kurulumu doğrulamak için foundryup'u çalıştırın
foundryup
