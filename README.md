# Boundless Dev & Prover Rolü Otomatik Kurulum Script'i

Bu repository, Boundless testnet rolleri için gereken tüm teknik kurulumu tek bir komutla yapmanızı sağlayan bir otomatik kurulum script'ini içerir.

## 🚀 Özellikler

- Gerekli tüm programları otomatik kurulum (Rust, Risc Zero, Bento, Boundless CLI)
- Doğru shell (bash veya zsh) ayarlarını otomatik yapılandırma
- `.env` dosyasını otomatik oluşturma ve yapılandırma
- Stake ve Deposit işlemlerini otomatik gerçekleştirme
- Renkli ve anlaşılır kurulum adımları

## 💻 Sistem Gereksinimleri

### Windows Kullanıcıları İçin
1. Windows 10 veya Windows 11 işletim sistemi
2. WSL2 (Windows Subsystem for Linux) kurulumu:
   - PowerShell'i yönetici olarak açın
   - Aşağıdaki komutu çalıştırın:
   ```powershell
   wsl --install
   ```
   - Bilgisayarınızı yeniden başlatın
   - Ubuntu'yu Microsoft Store'dan indirin ve kurun
   - Ubuntu'yu ilk kez açtığınızda bir kullanıcı adı ve şifre belirleyin

### macOS Kullanıcıları İçin
1. macOS 10.15 veya üzeri
2. Homebrew paket yöneticisi:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

### Linux Kullanıcıları İçin
1. Ubuntu 20.04 veya üzeri
2. Temel geliştirme araçları:
   ```bash
   sudo apt update && sudo apt install -y build-essential git curl
   ```

## 📋 Ön Gereksinimler

- 6 aydan eski Discord ve Github hesapları
- Test cüzdanında Sepolia ETH
- Infura'dan alınmış Sepolia RPC URL
- Linux veya macOS işletim sistemi (Windows için WSL2)

## ⚠️ Önemli Güvenlik Uyarısı

Bu script, Metamask Özel Anahtarınızı (Private Key) isteyecektir. Lütfen:
- MUTLAKA test için kullandığınız, içinde gerçek varlık olmayan BOŞ bir cüzdan kullanın
- Özel anahtarınızı güvenli bir şekilde saklayın
- Script'i güvenilir kaynaklardan indirdiğinizden emin olun

## 🛠️ Kurulum

### Windows Kullanıcıları İçin
1. WSL2 ve Ubuntu kurulumunu tamamlayın (yukarıdaki Sistem Gereksinimleri bölümüne bakın)
2. Ubuntu'yu açın ve aşağıdaki komutları çalıştırın:
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl build-essential
```

### macOS Kullanıcıları İçin
1. Terminal'i açın ve aşağıdaki komutları çalıştırın:
```bash
brew update
brew install git curl
```

### Tüm İşletim Sistemleri İçin Ortak Adımlar
1. Script'i indirin:
```bash
git clone https://github.com/eCoxvague/Boundless-Kurulum-KK.git
cd Boundless-Kurulum-KK
```

2. Script'i çalıştırılabilir yapın:
```bash
chmod +x boundless_kurulum.sh
```

3. Script'i çalıştırın:
```bash
./boundless_kurulum.sh
```

## 📝 Kurulum Adımları

Script çalıştığında:
1. RPC URL'nizi girmeniz istenecek
2. Test cüzdanınızın özel anahtarını girmeniz istenecek
3. USDC Faucet'ten test tokeni almanız istenecek
4. Otomatik olarak stake ve deposit işlemleri gerçekleştirilecek

## 🎯 Son Adımlar

Kurulum tamamlandıktan sonra:
1. [Guild Sayfasına](https://guild.xyz/boundless-xyz) gidin ve cüzdanınızı bağlayın
2. Discord'da '#claim-dev-prover-roles' kanalına giderek rollerinizi alın

## 🤝 Katkıda Bulunma

1. Bu repository'yi fork edin
2. Feature branch'i oluşturun (`git checkout -b feature/amazing-feature`)
3. Değişikliklerinizi commit edin (`git commit -m 'feat: Add amazing feature'`)
4. Branch'inizi push edin (`git push origin feature/amazing-feature`)
5. Pull Request oluşturun

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

## 📞 İletişim

Kripto Kurdu - [@kriptokurduu](https://twitter.com/kriptokurduu)

Proje Linki: [https://github.com/eCoxvague/Boundless-Kurulum-KK](https://github.com/eCoxvague/Boundless-Kurulum-KK)