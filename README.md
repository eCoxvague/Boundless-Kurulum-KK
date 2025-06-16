# Boundless Dev & Prover Rolü Otomatik Kurulum Script'i

Bu script, Boundless testnet rolleri için gereken tüm teknik kurulumu otomatik olarak yapar. Sizden sadece RPC URL ve özel anahtarınızı isteyecek, geri kalan her şeyi otomatik halledecektir.

## 🚀 Özellikler

- Gerekli tüm programları otomatik kurulum (Rust, Risc Zero, Bento, Boundless CLI)
- Doğru shell ayarlarını otomatik yapılandırma
- `.env` dosyasını otomatik oluşturma
- Stake ve Deposit işlemlerini otomatik gerçekleştirme

## 💻 Sistem Gereksinimleri

### Windows Kullanıcıları İçin
1. Windows 10 veya Windows 11
2. WSL2 kurulumu:
   - Windows PowerShell'i yönetici olarak açın (Windows tuşu + X, sonra "Windows PowerShell (Yönetici)")
   - `wsl --install` komutunu çalıştırın
   - Bilgisayarınızı yeniden başlatın
   - Ubuntu otomatik açılacak, kullanıcı adı ve şifre belirleyin

### macOS Kullanıcıları İçin
1. macOS 10.15 veya üzeri
2. Terminal uygulaması (macOS ile birlikte gelir)

### Linux Kullanıcıları İçin
1. Ubuntu 20.04 veya üzeri
2. Terminal uygulaması (Ubuntu ile birlikte gelir)

## 📋 Ön Gereksinimler

- 6 aydan eski Discord ve Github hesapları
- Test cüzdanında Sepolia ETH
- Infura'dan alınmış Sepolia RPC URL

## ⚠️ Önemli Güvenlik Uyarısı

Bu script, Metamask Özel Anahtarınızı (Private Key) isteyecektir. Lütfen:
- MUTLAKA test için kullandığınız, içinde gerçek varlık olmayan BOŞ bir cüzdan kullanın
- Özel anahtarınızı güvenli bir şekilde saklayın

## 🛠️ Kurulum

### Windows Kullanıcıları İçin
1. WSL2 ve Ubuntu kurulumunu tamamlayın
2. Ubuntu'yu açın:
   - Windows tuşuna basın
   - "Ubuntu" yazın ve tıklayın
   - VEYA Windows tuşu + R'ye basıp "ubuntu" yazın
3. Script'i indirin:
```bash
git clone https://github.com/eCoxvague/Boundless-Kurulum-KK.git
```
4. Script klasörüne girin:
```bash
cd Boundless-Kurulum-KK
```
5. Script'i çalıştırılabilir yapın:
```bash
chmod +x boundless_kurulum.sh
```
6. Script'i çalıştırın:
```bash
./boundless_kurulum.sh
```

### macOS Kullanıcıları İçin
1. Terminal'i açın
2. Script'i indirin:
```bash
git clone https://github.com/eCoxvague/Boundless-Kurulum-KK.git
```
3. Script klasörüne girin:
```bash
cd Boundless-Kurulum-KK
```
4. Script'i çalıştırılabilir yapın:
```bash
chmod +x boundless_kurulum.sh
```
5. Script'i çalıştırın:
```bash
./boundless_kurulum.sh
```

### Linux Kullanıcıları İçin
1. Terminal'i açın
2. Script'i indirin:
```bash
git clone https://github.com/eCoxvague/Boundless-Kurulum-KK.git
```
3. Script klasörüne girin:
```bash
cd Boundless-Kurulum-KK
```
4. Script'i çalıştırılabilir yapın:
```bash
chmod +x boundless_kurulum.sh
```
5. Script'i çalıştırın:
```bash
./boundless_kurulum.sh
```

## 📝 Script Ne Yapacak?

Script çalıştığında otomatik olarak:
1. Gerekli tüm programları kuracak
2. Sizden RPC URL ve özel anahtarınızı isteyecek
3. USDC talep etmenizi bekleyecek
4. Stake ve deposit işlemlerini yapacak

## 🎯 Son Adımlar

Kurulum tamamlandıktan sonra:
1. [Guild Sayfasına](https://guild.xyz/boundless-xyz) gidin ve cüzdanınızı bağlayın
2. Discord'da '#claim-dev-prover-roles' kanalına giderek rollerinizi alın

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

## 📞 İletişim

Kripto Kurdu - [@kriptokurduu](https://twitter.com/kriptokurduu)

Proje Linki: [https://github.com/eCoxvague/Boundless-Kurulum-KK](https://github.com/eCoxvague/Boundless-Kurulum-KK)