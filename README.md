# Boundless (Base Mainnet) Kurulum Rehberi

> ⚠️ **ÖNEMLİ NOT:** Eğer Ubuntu, WSL2 (Windows için) veya Homebrew (macOS için) kurulumlarınız tamamlandıysa, doğrudan [Ön Gereksinimler](#ön-gereksinimler) bölümüne geçebilirsiniz!

Bu rehber, Boundless'ın Base Mainnet üzerindeki kurulumunu adım adım açıklamaktadır.

## İşletim Sistemine Göre Kurulum

### Windows Kullanıcıları İçin (Sadece windows kullanıcıları için!)

1. **WSL2 Kurulumu:**
   - Windows PowerShell'i yönetici olarak açın (Windows tuşu + X, sonra "Windows PowerShell (Yönetici)")
   - Aşağıdaki komutu çalıştırın:
     ```powershell
     wsl --install
     ```
   - Kurulum tamamlandıktan sonra bilgisayarınızı yeniden başlatın
   - Bilgisayar açıldıktan sonra:
      - Windows tuşuna basın yada arama yerine
      - "Ubuntu" yazın ve tıklayın
      - İlk kez açılıyorsa, kullanıcı adı ve şifre belirlemeniz istenecek
      - Bu bilgileri not alın, daha sonra kullanacaksınız

2. **Ubuntu'yu Açma:**
   - Windows tuşuna basın yada arama yerini açın
   - "Ubuntu" yazın ve tıklayın
   - VEYA Windows tuşu + R'ye basıp "ubuntu" yazın

3. **Gerekli Paketleri Kurma:**
   ```bash
   sudo apt update
   sudo apt install -y git nano
   ```

### macOS Kullanıcıları İçin (Sadece macOS kullanıcı için!)

1. **Homebrew Kurulumu:**
   - Terminal'i açın
   - Aşağıdaki komutu yapıştırın:
     ```bash
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
     ```
   - Kurulum tamamlandıktan sonra:
     ```bash
     echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
     eval "$(/opt/homebrew/bin/brew shellenv)"
     ```

2. **Gerekli Paketleri Kurma:**
   ```bash
   brew install git
   ```

### Linux Kullanıcıları İçin (Sadece linux kullanıcıları için!)

1. **Gerekli Paketleri Kurma:**
   ```bash
   sudo apt update
   sudo apt install -y git nano
   ```

## Ön Gereksinimler

1. 6 aydan eski Discord ve Github hesapları
2. Base Mainnet ağında ETH bakiyesi olan bir cüzdan (ana cüzdanınız değil!)
3. Infura'dan alınmış Base Mainnet RPC URL'si

## Infura'dan Base RPC URL Alma

1. **MetaMask Developer Portal'a Giriş:**
   - [MetaMask Developer Portal](https://developer.metamask.io/register) adresine gidin
   - Kayıt olun veya giriş yapın

2. **Infura RPC'ye Erişim:**
   - Sol menüden "Infura RPC" seçeneğine tıklayın
   - Sağ üst köşedeki "Active Endpoints" butonuna tıklayın
   - Açılan listeden "Base Mainnet"i bulun
   - Base Mainnet'in RPC URL'sini kopyalayın
   - Bu URL'yi güvenli bir yere kaydedin, script çalıştırırken kullanacağız

## Cüzdan Hazırlığı

Kuruluma başlamadan önce, yeni bir cüzdan oluşturup hazırlamanız gerekiyor:

1. **Yeni Cüzdan Oluşturma:**
   - MetaMask'ı açın
   - "Create a new wallet" seçeneğini tıklayın
   - Güvenli bir şifre belirleyin
   - Secret Recovery Phrase'i güvenli bir yere kaydedin
   - Bu cüzdanı sadece Boundless için kullanacağız

2. **Base Mainnet Ağını Ekleme:**
   - https://chainlist.org/?search=base buradan base ağını cüzdana ekleyin!

3. **Cüzdana Fon Gönderme:**
   - Ana cüzdanınızdan yeni oluşturduğunuz cüzdana:
     - En az 1 USDC
     - İşlem ücretleri için 2-3 dolarlık ETH gönderin
   - Base Mainnet ağını seçtiğinizden emin olun
   - Transferlerin tamamlanmasını bekleyin

4. **USDC Alımı:**
   - [Uniswap](https://app.uniswap.org/swap) sitesine gidin
   - Base Mainnet ağını seçin
   - ETH'nizi USDC ile değiştirin (en az 1 USDC)
   - İşlemin tamamlanmasını bekleyin

## Kurulum Adımları (Tüm işletim sistemleri için ORTAK!)

### 1. Ubuntu Terminal'i Açın ve Root Yetkisi Alın

#### Windows Kullanıcıları İçin:
1. Windows tuşuna basın
2. "Ubuntu" yazın
3. Ubuntu uygulamasına tıklayın
4. Terminal açıldığında aşağıdaki komutları sırayla çalıştırın:

```bash
# Root yetkisi alın (şifrenizi girmeniz istenecek)
sudo su

# Ana dizine gidin
cd ~
```

#### macOS Kullanıcıları İçin:
1. Spotlight'ı açın (Command + Space)
2. "Terminal" yazın
3. Terminal uygulamasına tıklayın
4. Terminal açıldığında aşağıdaki komutları sırayla çalıştırın:

```bash
# Root yetkisi alın (şifrenizi girmeniz istenecek)
sudo su

# Ana dizine gidin
cd ~
```

#### Linux Kullanıcıları İçin:
1. Terminal'i açın (Ctrl + Alt + T)
2. Terminal açıldığında aşağıdaki komutları sırayla çalıştırın:

```bash
# Root yetkisi alın (şifrenizi girmeniz istenecek)
sudo su

# Ana dizine gidin
cd ~
```

### 2. Çalışma Dizini Oluşturma

```bash
# Yeni bir klasör oluşturun
mkdir boundless-setup
cd boundless-setup
```

### 3. Script Dosyasını Oluşturma

```bash
# Script dosyasını oluşturun
nano boundless_base_kurulum.sh
```

### 4. Script Kodunu Kopyalama

1. Bu repodaki `boundless_base_kurulum.sh` dosyasını açın
2. Tüm içeriği kopyalayın (CTRL+A, CTRL+C)
3. Terminal'deki nano editörüne yapıştırın (CTRL+SHIFT+V veya sağ tık)

### 5. Dosyayı Kaydetme ve Çalıştırılabilir Yapma

1. Nano editöründe:
   - `CTRL + X` tuşlarına basın
   - `Y` tuşuna basarak değişiklikleri kaydetmeyi onaylayın
   - `ENTER` tuşuna basarak dosya adını onaylayın

2. Dosyayı çalıştırılabilir yapın:
```bash
chmod +x boundless_base_kurulum.sh
```

### 6. Scripti Çalıştırma

```bash
./boundless_base_kurulum.sh
```

## Önemli Notlar

- Script çalışırken sizden RPC URL ve özel anahtar (private key) isteyecektir
- Özel anahtarınızı girerken yazdıklarınız görünmeyecektir (güvenlik için)
- Script, Base Mainnet üzerinde işlem yapacağı için gerçek ETH gerektirir
- Ana cüzdanınızı DEĞİL, düşük bakiyeli bir test cüzdanı kullanmanız önerilir

## Manuel Adımlar

Script tamamlandıktan sonra:

1. [Guild Sayfasına](https://guild.xyz/boundless-xyz) gidin
   - Cüzdanınızı bağlayın
   - 'Dev' ve 'Prover' rollerinin aktif olduğunu kontrol edin

2. Discord'a gidin
   - '#claim-dev-prover-roles' kanalına gidin
   - 'Claim' butonlarına tıklayarak rollerinizi alın

## Sorun Giderme

Eğer kurulum sırasında bir hata alırsanız:

1. RPC URL'nizin doğru olduğundan emin olun
2. Cüzdanınızda yeterli ETH ve USDC olduğunu kontrol edin
3. Base Mainnet ağında olduğunuzdan emin olun

### Yaygın Hatalar ve Çözümleri

#### Windows'ta WSL Hatası
```powershell
wsl --install
```
komutu çalışmazsa:
1. Windows özelliklerinden "Windows Subsystem for Linux"u etkinleştirin
2. PowerShell'i yönetici olarak açıp tekrar deneyin

#### macOS'ta Homebrew Hatası
Homebrew kurulumu başarısız olursa:
1. Xcode Command Line Tools'u kurun:
```bash
xcode-select --install
```
2. Homebrew kurulumunu tekrar deneyin

#### Linux'ta Paket Hatası
Paket kurulumu başarısız olursa:
```bash
sudo apt update && sudo apt upgrade
```
komutunu çalıştırıp tekrar deneyin

## Kripto Kurdu Ekibi