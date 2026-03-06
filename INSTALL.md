# 📖 Panduan Instalasi Lengkap - Lacak-Lokasi

Dokumen ini berisi instruksi instalasi detail untuk semua platform yang didukung.

## 📋 Daftar Isi

- [Persyaratan Sistem](#persyaratan-sistem)
- [Instalasi Windows (WSL2)](#instalasi-windows-wsl2)
- [Instalasi Linux](#instalasi-linux)
- [Instalasi Termux (Android)](#instalasi-termux-android)
- [Verifikasi Instalasi](#verifikasi-instalasi)
- [Troubleshooting](#troubleshooting)
- [FAQ](#faq)

---

## 🔍 Persyaratan Sistem

### Umum

- **Python**: 3.8 atau lebih baru
- **pip**: Manajer paket Python
- **Git**: untuk cloning repository
- **RAM**: Minimal 512MB
- **Disk Space**: Minimal 200MB

### Spesifik Platform

| Fitur           | Windows (WSL2)   | Linux               | Termux    |
| --------------- | ---------------- | ------------------- | --------- |
| Python 3.8+     | ✅               | ✅                  | ✅        |
| Required Tools  | bash, curl, wget | bash, curl, wget    | apt, curl |
| Package Manager | apt, pip         | apt/yum/pacman, pip | apt, pip  |

---

## 🪟 Instalasi Windows (WSL2)

### Prasyarat: Setup WSL2

Jika belum memiliki WSL2, setup terlebih dahulu:

1. **Buka PowerShell sebagai Administrator** dan jalankan:

```powershell
wsl --install -d Ubuntu
```

2. **Restart komputer** jika diminta

3. **Setup user dan password** pada Linux pertama kali startup

### Instalasi Aplikasi

1. **Buka WSL2 Terminal**:

```bash
wsl
```

2. **Clone repository**:

```bash
cd ~
git clone https://github.com/Sneijderlino/Lacak-Lokasi.git
cd Lacak-Lokasi
```

3. **Jalankan script instalasi otomatis**:

```bash
bash setup-linux.sh
```

Atau instalasi manual:

```bash
# Update sistem
sudo apt update
sudo apt upgrade -y

# Install Python dan dependencies
sudo apt install -y python3.8 python3-pip python3-venv

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Run aplikasi
python Ghost-Phishing-Lokasi.py
```

4. **Akses aplikasi**:

```
Browser: http://localhost:8000
```

---

## 🐧 Instalasi Linux

### Debian/Ubuntu

```bash
# Clone repository
git clone https://github.com/Sneijderlino/Lacak-Lokasi.git
cd Lacak-Lokasi

# Jalankan script instalasi
bash setup-linux.sh
```

**Manual Installation**:

```bash
sudo apt update
sudo apt install -y python3.8 python3-pip python3-venv

python3 -m venv venv
source venv/bin/activate

pip install -r requirements.txt
python Ghost-Phishing-Lokasi.py
```

### Fedora

```bash
# Clone repository
git clone https://github.com/Sneijderlino/Lacak-Lokasi.git
cd Lacak-Lokasi

# Jalankan script instalasi
bash setup-linux.sh
```

**Manual Installation**:

```bash
sudo dnf install -y python3 python3-pip

python3 -m venv venv
source venv/bin/activate

pip install -r requirements.txt
python Ghost-Phishing-Lokasi.py
```

### Arch Linux

```bash
# Clone repository
git clone https://github.com/Sneijderlino/Lacak-Lokasi.git
cd Lacak-Lokasi

# Jalankan script instalasi
bash setup-linux.sh
```

**Manual Installation**:

```bash
sudo pacman -S python python-pip

python -m venv venv
source venv/bin/activate

pip install -r requirements.txt
python Ghost-Phishing-Lokasi.py
```

---

## 📱 Instalasi Termux (Android)

### Prasyarat

- Termux aplikasi (dari F-Droid atau APK)
- Storage permission untuk akses file

### Langkah Instalasi

```bash
# Update Termux
apt update
apt upgrade -y

# Jalankan script instalasi otomatis
bash setup-termux.sh
```

**Manual Installation**:

```bash
# Install dependencies
apt install -y python git

# Clone repository
cd ~
git clone https://github.com/Sneijderlino/Lacak-Lokasi.git
cd Lacak-Lokasi

# Install Python packages
pip install -r requirements.txt

# Jalankan aplikasi
python Ghost-Phishing-Lokasi.py
```

---

## ✅ Verifikasi Instalasi

Setelah instalasi selesai, verifikasi dengan:

```bash
# Check Python version
python --version

# Check dependencies
pip list | grep -E "flask|requests|geolite2"

# Test aplikasi
python Ghost-Phishing-Lokasi.py
```

Expected output:

```
Python 3.8.x
Flask 2.x.x
Requests 2.x.x
...
 * Running on http://0.0.0.0:8000
```

---

## 🔧 Troubleshooting

### Error: "Python tidak ditemukan"

**Windows (WSL2)**:

```bash
sudo apt install -y python3.8 python3-pip
python3 --version
```

**Linux**:

```bash
# Debian/Ubuntu
sudo apt install -y python3 python3-pip

# Fedora
sudo dnf install -y python3 python3-pip

# Arch
sudo pacman -S python python-pip
```

**Termux**:

```bash
apt install -y python
python --version
```

### Error: "Permission Denied"

```bash
# Beri permission untuk script
chmod +x setup-linux.sh
chmod +x setup-termux.sh
chmod +x quick-start.sh

# Jalankan lagi
bash setup-linux.sh
```

### Error: "Module tidak ditemukan"

```bash
# Aktifkan virtual environment
source venv/bin/activate  # Linux/WSL2
source venv/Scripts/activate  # Windows CMD

# Install dependencies lagi
pip install --upgrade pip
pip install -r requirements.txt
```

### Port 8000 sudah digunakan

```bash
# Gunakan port berbeda
python Ghost-Phishing-Lokasi.py --port 8080

# Atau kill process yang menggunakan port 8000
# Linux/WSL2
sudo lsof -i :8000
sudo kill -9 <PID>

# Termux
netstat -tln | grep 8000
```

### Error: "git not found"

**Linux/WSL2**:

```bash
sudo apt install -y git
```

**Termux**:

```bash
apt install -y git
```

---

## ❓ FAQ

### Q: Bisakah saya install di komputer lama?

**A**: Ya, aplikasi ini dikembangkan untuk kompatibilitas maksimal. Minimal Python 3.8 diperlukan. Testing di:

- Ubuntu 18.04+ ✅
- Debian 10+ ✅
- Windows 10/11 WSL2 ✅
- Termux 2020+ ✅

### Q: Apakah virtual environment diperlukan?

**A**: Rekomendasi: **Ya**. Virtual environment mengisolasi dependencies dan mencegah konflik. Untuk pengguna pemula:

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### Q: Bagaimana jika instalasi gagal?

**A**: Coba langkah-langkah ini:

1. Update semua package sistem:

   ```bash
   sudo apt update && sudo apt upgrade -y  # Debian/Ubuntu
   sudo dnf update -y  # Fedora
   ```

2. Hapus virtual environment dan buat baru:

   ```bash
   rm -rf venv
   python3 -m venv venv
   source venv/bin/activate
   ```

3. Install dependencies bersih:

   ```bash
   pip install --upgrade pip setuptools wheel
   pip install -r requirements.txt
   ```

4. Buka [Issue](https://github.com/Sneijderlino/Lacak-Lokasi/issues) dengan error message lengkap

### Q: Apakah aplikasi memerlukan root/sudo?

**A**: Biasanya **tidak diperlukan**. Hanya gunakan `sudo` jika:

- Instalasi package sistem (`apt install`, `dnf install`)
- Akses port < 1024
- Akses file sistem sensitif

### Q: Bagaimana cara update aplikasi?

**A**:

```bash
# Update dari GitHub
cd ~/Lacak-Lokasi
git pull
pip install --upgrade -r requirements.txt
```

### Q: Apakah ada requirements.txt?

**A**: Pastikan file `requirements.txt` ada di folder proyek. Jika tidak, buat dengan:

```txt
Flask==2.3.0
requests==2.31.0
geoip2==4.7.0
```

---

## 📞 Butuh Bantuan?

- 📖 Baca dokumentasi di [README.md](README.md)
- 🐛 Laporkan bug di [Issues](https://github.com/Sneijderlino/Lacak-Lokasi/issues)
- 💬 Tanya jawab di [Discussions](https://github.com/Sneijderlino/Lacak-Lokasi/discussions)
- 📧 Email: sneijderlino@example.com

---

**Terakhir diupdate**: Maret 2026  
**Versi dokumentasi**: 1.0.0
