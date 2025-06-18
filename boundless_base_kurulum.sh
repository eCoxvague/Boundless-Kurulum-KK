#!/bin/bash

# Renk Kodları
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Kripto Kurdu Banner
echo -e "${GREEN}"
echo "-----------------------------------------------------------------"
echo "    Kripto Kurdu Sunar: Boundless (Base Mainnet) Kurulumu        "
echo "-----------------------------------------------------------------"
echo -e "${NC}"

# ÖNEMLİ UYARI
echo -e "${RED}ÇOK ÖNEMLİ UYARI! Bu script BASE MAINNET üzerinde çalışacaktır."
echo -e "${RED}Bu, işlem ücretleri (gas) ve USDC alımı için GERÇEK ETH gerektirdiği anlamına gelir."
echo -e "${RED}Lütfen ana cüzdanınızı DEĞİL, düşük bakiyeli bir 'burner' (harici) cüzdan kullanın!${NC}"
echo ""
echo -e "${YELLOW}Devam etmeden önce şunların hazır olduğundan emin olun:${NC}"
echo "1. 6 aydan eski Discord ve Github hesapları."
echo "2. Kullanacağınız cüzdanda, işlem ücretleri ve takas için bir miktar Base Ağı ETH'si."
echo "3. Infura'dan alınmış Base Mainnet RPC URL'niz."
echo ""
read -p "Tüm şartları okudum, anladım ve ana cüzdanım olmayan bir cüzdanla devam ediyorum (E/h): " user_approval
if [[ "$user_approval" != "E" && "$user_approval" != "e" ]]; then
    echo -e "${RED}İşlem iptal edildi. Güvenliğiniz bizim için önemli!${NC}"
    exit 1
fi

# Adım 1: Kullanıcıdan Gerekli Bilgileri Alma
echo ""
echo -e "${YELLOW}Lütfen Infura'dan aldığınız Base Mainnet RPC URL'sini yapıştırın:${NC}"
read -p "RPC URL: " ETH_RPC_URL

echo ""
echo -e "${RED}Lütfen DÜŞÜK BAKİYELİ CÜZDANINIZIN Özel Anahtarını (Private Key) yapıştırın:"
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
    # Shell profilini tespit et ve source et
    if [[ "$SHELL" == *"zsh"* ]]; then source "$HOME/.zshrc"; else source "$HOME/.bashrc"; fi
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
cargo install --git https://github.com/risc0/risc0 bento-client --bin bento_cli
export PATH="$HOME/.cargo/bin:$PATH"
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> $SHELL_PROFILE

cargo install --locked boundless-cli
source $SHELL_PROFILE || echo -e "${YELLOW}Shell profil dosyası kaynaklanamadı. Yeni bir terminal açmanız gerekebilir.${NC}"
echo -e "${GREEN}Bento ve Boundless CLI başarıyla kuruldu.${NC}"

print_step "Adım 5/6: Yapılandırma Dosyası (.env.base) Oluşturuluyor"
# Önceki dosyayı temizle (varsa)
rm -f .env.base
# Yeni dosyayı oluştur
cat > .env.base << EOL
export VERIFIER_ADDRESS=0x0b144e07a0826182b6b59788c34b32bfa86fb711
export BOUNDLESS_MARKET_ADDRESS=0x26759dbB201aFbA361Bec78E097Aa3942B0b4AB8
export SET_VERIFIER_ADDRESS=0x8C5a8b5cC272Fe2b74D18843CF9C3aCBc952a760
export ORDER_STREAM_URL="https://base-mainnet.beboundless.xyz"
export ETH_RPC_URL="${ETH_RPC_URL}"
export PRIVATE_KEY="${PRIVATE_KEY}"
EOL
source .env.base
echo -e "${GREEN}.env.base dosyası başarıyla oluşturuldu ve yüklendi.${NC}"

print_step "Adım 6/6: Zincir Üstü (On-Chain) İşlemler"
echo -e "${YELLOW}Şimdi cüzdanınıza en az 1 USDC almanız gerekiyor.${NC}"
echo "Base Mainnet ağında olduğunuzdan emin olun."
echo "Lütfen şu adrese gidin: https://app.uniswap.org/swap"
echo "Cüzdanınızdaki ETH ile en az 1 adet USDC satın alın."
echo ""
read -p "Cüzdanınıza 1 USDC geldiğinde devam etmek için ENTER'a basın..."

echo ""
echo -e "${YELLOW}1 USDC Stake ediliyor... Lütfen bekleyin.${NC}"
boundless \
  --rpc-url "$ETH_RPC_URL" \
  --private-key "$PRIVATE_KEY" \
  --boundless-market-address "$BOUNDLESS_MARKET_ADDRESS" \
  --set-verifier-address "$SET_VERIFIER_ADDRESS" \
  --verifier-router-address "$VERIFIER_ADDRESS" \
  --order-stream-url "$ORDER_STREAM_URL" \
  account deposit-stake 1

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Stake işlemi başarılı!${NC}"
else
    echo -e "${RED}Stake işlemi başarısız oldu. Lütfen USDC bakiyenizi ve RPC bilgilerinizi kontrol edin.${NC}"
    exit 1
fi

echo ""
echo -e "${YELLOW}Çok küçük bir miktar ETH deposit ediliyor... Lütfen bekleyin.${NC}"
boundless \
  --rpc-url "$ETH_RPC_URL" \
  --private-key "$PRIVATE_KEY" \
  --boundless-market-address "$BOUNDLESS_MARKET_ADDRESS" \
  --set-verifier-address "$SET_VERIFIER_ADDRESS" \
  --verifier-router-address "$VERIFIER_ADDRESS" \
  --order-stream-url "$ORDER_STREAM_URL" \
  account deposit 0.00000000001

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Deposit işlemi başarılı!${NC}"
else
    echo -e "${RED}Deposit işlemi başarısız oldu. Lütfen Base ETH bakiyenizi (gas için) kontrol edin.${NC}"
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