#!/bin/bash

# Renk Kodları
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# PATH kontrolü ve ayarlama fonksiyonu
setup_path() {
    if [[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]]; then
        echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> "$SHELL_PROFILE"
        export PATH="$HOME/.cargo/bin:$PATH"
        echo -e "${GREEN}PATH güncellendi.${NC}"
    fi
}

# Komut kontrolü fonksiyonu
check_command() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}$1 komutu bulunamadı!${NC}"
        return 1
    fi
    return 0
}

# Kripto Kurdu Banner
echo -e "${GREEN}"
echo "---------------------------------------------------------"
echo "    Kripto Kurdu Sunar: Boundless Otomatik Kurulum       "
echo "---------------------------------------------------------"
echo -e "${NC}"

# ÖNEMLİ UYARI
echo -e "${RED}DİKKAT! Bu script, sizden Metamask Özel Anahtarınızı (Private Key) isteyecektir."
echo -e "${RED}Bu işlem hassastır. MUTLAKA ve MUTLAKA test için kullandığınız, içinde"
echo -e "${RED}gerçek varlık olmayan BOŞ bir cüzdan kullanın!${NC}"
echo ""
echo -e "${YELLOW}Devam etmeden önce şunların hazır olduğundan emin olun:${NC}"
echo "1. 6 aydan eski Discord ve Github hesapları."
echo "2. Test cüzdanınızda bir miktar Sepolia ETH."
echo "3. Infura'dan alınmış Sepolia RPC URL'niz."
echo ""
read -p "Tüm şartları okudum, anladım ve boş bir cüzdanla devam ediyorum (E/h): " user_approval
if [[ "$user_approval" != "E" && "$user_approval" != "e" ]]; then
    echo -e "${RED}İşlem iptal edildi. Güvenliğiniz bizim için önemli!${NC}"
    exit 1
fi

# Adım 1: Kullanıcıdan Gerekli Bilgileri Alma
echo ""
echo -e "${YELLOW}Lütfen Infura'dan aldığınız Sepolia RPC URL'sini yapıştırın:${NC}"
read -p "RPC URL: " ETH_RPC_URL

echo ""
echo -e "${RED}Lütfen BOŞ TEST CÜZDANINIZIN Özel Anahtarını (Private Key) yapıştırın:"
echo -e "${RED}(Güvenlik için yazdıklarınız görünmeyecektir)${NC}"
read -s -p "Özel Anahtar: " PRIVATE_KEY
echo ""

# Adım 2: Bağımlılıkları ve Repoyu Kurma
print_step() {
    echo ""
    echo -e "${GREEN}===== $1 =====${NC}"
    echo ""
}

print_step "Adım 1/6: Boundless Reposu Klonlanıyor"
if [ -d "boundless" ]; then
    echo -e "${YELLOW}Boundless klasörü zaten mevcut, klonlama atlanıyor.${NC}"
    cd boundless
else
    git clone https://github.com/boundless-xyz/boundless.git
    cd boundless
fi
git checkout release-0.10

print_step "Adım 2/6: Rust Kuruluyor"
if ! command -v cargo &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    echo -e "${GREEN}Rust başarıyla kuruldu.${NC}"
else
    echo -e "${YELLOW}Rust zaten kurulu.${NC}"
fi

print_step "Adım 3/6: RISC Zero Kuruluyor"
if ! command -v rzup &> /dev/null; then
    curl -L https://risczero.com/install | bash
    source "$HOME/.zshrc" || source "$HOME/.bashrc"
    rzup install
else
    echo -e "${YELLOW}RISC Zero zaten kurulu. Güncellemeler kontrol ediliyor...${NC}"
    rzup install
fi

# Shell profil dosyasını belirle
SHELL_PROFILE=""
if [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_PROFILE="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
    SHELL_PROFILE="$HOME/.bashrc"
else
    echo -e "${YELLOW}Tanımlanamayan shell. PATH ayarını manuel yapmanız gerekebilir: $SHELL ${NC}"
    SHELL_PROFILE="$HOME/.bash_profile" # Fallback
fi

print_step "Adım 4/6: Bento Client ve Boundless CLI Kuruluyor"
echo -e "${YELLOW}Cargo PATH kontrolü yapılıyor...${NC}"
setup_path

echo -e "${YELLOW}Bento Client kuruluyor...${NC}"
cargo install --git https://github.com/risc0/risc0 bento-client --bin bento_cli

echo -e "${YELLOW}Boundless CLI kuruluyor...${NC}"
cargo install --locked boundless-cli

# Kurulum sonrası kontrol
if ! check_command boundless; then
    echo -e "${RED}Boundless CLI kurulumu başarısız oldu!${NC}"
    echo -e "${YELLOW}Lütfen şu komutları manuel olarak çalıştırın:${NC}"
    echo "source ~/.cargo/env"
    echo "cargo install --locked boundless-cli"
    exit 1
fi

echo -e "${GREEN}Bento ve Boundless CLI başarıyla kuruldu.${NC}"

print_step "Adım 5/6: Yapılandırma Dosyası (.env) Oluşturuluyor"
cat > .env.eth-sepolia << EOL
export VERIFIER_ADDRESS=0x925d8331ddc0a1F0d96E68CF073DFE1d92b69187
export BOUNDLESS_MARKET_ADDRESS=0x13337C76fE2d1750246B68781ecEe164643b98Ec
export SET_VERIFIER_ADDRESS=0x7aAB646f23D1392d4522CFaB0b7FB5eaf6821d64
export ORDER_STREAM_URL="https://eth-sepolia.beboundless.xyz/"
export ETH_RPC_URL="${ETH_RPC_URL}"
export PRIVATE_KEY="${PRIVATE_KEY}"
EOL
source .env.eth-sepolia
echo -e "${GREEN}.env.eth-sepolia dosyası başarıyla oluşturuldu ve yüklendi.${NC}"

print_step "Adım 6/6: Zincir Üstü (On-Chain) İşlemler"
# Boundless komutunun varlığını kontrol et
if ! check_command boundless; then
    echo -e "${RED}Boundless CLI bulunamadı! Lütfen kurulumu tekrar deneyin.${NC}"
    exit 1
fi

echo -e "${YELLOW}Şimdi USDC Faucet'ten test tokeni almanız gerekiyor.${NC}"
echo "Lütfen şu adrese gidin: https://faucet.circle.com"
echo "Ağ olarak 'Sepolia' seçin ve cüzdan adresinizi girerek 10 USDC talep edin."
echo ""
read -p "Cüzdanınıza 10 USDC geldiğinde devam etmek için ENTER'a basın..."

echo ""
echo -e "${YELLOW}10 USDC Stake ediliyor... Lütfen bekleyin.${NC}"
boundless \
  --rpc-url "$ETH_RPC_URL" \
  --private-key "$PRIVATE_KEY" \
  --boundless-market-address "$BOUNDLESS_MARKET_ADDRESS" \
  --set-verifier-address "$SET_VERIFIER_ADDRESS" \
  --verifier-router-address "$VERIFIER_ADDRESS" \
  --order-stream-url "$ORDER_STREAM_URL" \
  account deposit-stake 10

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Stake işlemi başarılı!${NC}"
else
    echo -e "${RED}Stake işlemi başarısız oldu. Lütfen bakiyenizi ve RPC bilgilerinizi kontrol edin.${NC}"
    exit 1
fi

echo ""
echo -e "${YELLOW}0.1 ETH değerinde varlık deposit ediliyor... Lütfen bekleyin.${NC}"
boundless \
  --rpc-url "$ETH_RPC_URL" \
  --private-key "$PRIVATE_KEY" \
  --boundless-market-address "$BOUNDLESS_MARKET_ADDRESS" \
  --set-verifier-address "$SET_VERIFIER_ADDRESS" \
  --verifier-router-address "$VERIFIER_ADDRESS" \
  --order-stream-url "$ORDER_STREAM_URL" \
  account deposit 0.1

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Deposit işlemi başarılı!${NC}"
else
    echo -e "${RED}Deposit işlemi başarısız oldu. Lütfen Sepolia ETH bakiyenizi kontrol edin.${NC}"
    exit 1
fi

# Final
echo ""
echo -e "${GREEN}🎉 TEBRİKLER! KURULUM TAMAMLANDI! 🎉${NC}"
echo "Tüm teknik adımlar başarıyla tamamlandı."
echo "Şimdi rolleri almak için son manuel adımları yapmalısınız:"
echo ""
echo -e "1. ${YELLOW}Guild Sayfasına Gidin:${NC} https://guild.xyz/boundless-xyz"
echo "   Cüzdanınızı bağlayın ve sayfayı yenileyin. 'Dev' ve 'Prover' rollerinin aktif olduğunu göreceksiniz."
echo ""
echo -e "2. ${YELLOW}Discord'a Gidin:${NC}"
echo "   Boundless Discord sunucusunda '#claim-dev-prover-roles' kanalına gidin."
echo "   Oradaki 'Claim' butonlarına tıklayarak Discord rollerinizi alın."
echo ""
echo -e "${GREEN}İyi çalışmalar dileriz! - Kripto Kurdu Ekibi${NC}" 