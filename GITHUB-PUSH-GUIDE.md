# 🚀 Panduan Push ke GitHub - Lacak-Lokasi

Dokumen ini menjelaskan langkah-langkah detail untuk push repository ke GitHub.

## 📋 Daftar Isi

- [Persiapan](#persiapan)
- [Method 1: SSH (Direkomendasikan)](#method-1-ssh-direkomendasikan)
- [Method 2: HTTPS dengan PAT](#method-2-https-dengan-personal-access-token)
- [Automation Script](#automation-script)
- [Troubleshooting](#troubleshooting)

---

## 🔧 Persiapan

### 1. Install Git

**Linux/WSL2:**

```bash
sudo apt install -y git
```

**Termux:**

```bash
apt install -y git
```

### 2. Verify Git Installation

```bash
git --version
```

### 3. Buat Repository di GitHub

1. Pergi ke https://github.com/new
2. Buat repository dengan nama: `Lacak-Lokasi`
3. Deskripsi: "Real-Time Location Tracking Platform"
4. **JANGAN** initialize repository (leave empty)
5. **JANGAN** add .gitignore atau LICENSE (sudah ada)
6. Klik "Create Repository"

---

## 🔐 Method 1: SSH (Direkomendasikan)

SSH adalah metode paling aman dan convenient untuk push code.

### Step 1: Generate SSH Key

```bash
# Generate SSH key dengan email Anda
ssh-keygen -t ed25519 -C "your_email@example.com"
```

**Output:**

```
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/username/.ssh/id_ed25519):
```

Tekan **Enter** untuk default location.

### Step 2: Masukkan Passphrase (Optional)

```
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
```

Anda bisa kosongkan (tekan Enter 2x) atau buat passphrase untuk security tambahan.

### Step 3: Copy Public Key

```bash
# Linux/WSL2/Termux
cat ~/.ssh/id_ed25519.pub
```

Copy seluruh output yang dimulai dengan `ssh-ed25519`.

### Step 4: Add Key ke GitHub

1. Pergi ke GitHub Settings: https://github.com/settings/keys
   - Atau: GitHub → Settings → SSH and GPG keys
2. Klik "New SSH key"
3. **Title**: Kasih nama (cth: "My Laptop")
4. **Key type**: Authentication Key
5. **Key**: Paste public key yang sudah dicopy
6. Klik "Add SSH key"

### Step 5: Test SSH Connection

```bash
ssh -T git@github.com
```

**Expected output:**

```
Hi Sneijderlino! You've successfully authenticated, but GitHub does not provide shell access.
```

---

## 🌐 Method 2: HTTPS dengan Personal Access Token

Jika SSH tidak bisa setup, gunakan HTTPS dengan Personal Access Token.

### Step 1: Create Personal Access Token

1. Pergi ke GitHub Settings: https://github.com/settings/tokens
   - Atau: GitHub → Settings → Developer Settings → Personal Access Tokens → Tokens (classic)
2. Klik "Generate new token"
3. Pilih "Generate new token (classic)"
4. **Note**: Kasih nama (cth: "Lacak-Lokasi Push")
5. **Expiration**: Set ke yang sesuai (cth: 90 days)
6. **Select scopes** (permissions):
   - ✅ `repo` - Full control of private repositories
   - ✅ `workflow` - Update GitHub Actions
7. Klik "Generate token"
8. **IMPORTANT**: Copy token (Anda hanya bisa lihat 1x!)

### Step 2: Configure Git Credential Helper

```bash
# Setup credential helper
git config --global credential.helper store
```

### Step 3: Test HTTPS Authentication

```bash
# Clone test (atau langsung ke step push)
git clone https://github.com/Sneijderlino/Lacak-Lokasi.git
```

Ketika diminta:

- **Username**: `Sneijderlino`
- **Password**: Paste token yang sudah dicopy

---

## 🤖 Automation Script

Kami provide script otomatis untuk simplify proses push.

### Method A: Gunakan Script

```bash
# Buat script executable
chmod +x push-github.sh

# Run script
bash push-github.sh
```

**Script ini akan:**

1. ✅ Configure git user.name dan user.email
2. ✅ Initialize repository
3. ✅ Add remote origin
4. ✅ Stage semua files
5. ✅ Create initial commit
6. ✅ Push ke GitHub

### Method B: Manual Step-by-Step

#### Step 1: Navigate ke Project Directory

```bash
cd ~/Lacak-Lokasi
# atau
cd /path/to/Lacak-Lokasi
```

#### Step 2: Configure Git (First time only)

```bash
# Set global configuration
git config --global user.name "Sneijderlino"
git config --global user.email "your_email@example.com"

# Verify
git config --global --list | grep user
```

#### Step 3: Initialize Repository

```bash
git init
```

#### Step 4: Add Remote Origin

**Untuk SSH:**

```bash
git remote add origin git@github.com:Sneijderlino/Lacak-Lokasi.git
```

**Untuk HTTPS:**

```bash
git remote add origin https://github.com/Sneijderlino/Lacak-Lokasi.git
```

#### Step 5: Verify Remote

```bash
git remote -v
```

**Output:**

```
origin  git@github.com:Sneijderlino/Lacak-Lokasi.git (fetch)
origin  git@github.com:Sneijderlino/Lacak-Lokasi.git (push)
```

#### Step 6: Stage Files

```bash
git add .

# Verify
git status
```

#### Step 7: Create Commit

```bash
git commit -m "chore: initial repository setup with documentation and scripts"
```

#### Step 8: Push ke GitHub

```bash
# Push dan set upstream
git push -u origin main
# atau jika main belum ada
git branch -M main
git push -u origin main
```

---

## 📊 Verify Push Success

Setelah push, verify bahwa semuanya berhasil:

### 1. Check GitHub Website

Buka https://github.com/Sneijderlino/Lacak-Lokasi

Verify:

- ✅ All files terlihat
- ✅ README.md menampilkan dengan proper formatting
- ✅ Branch list menunjukkan `main`
- ✅ Commit history terlihat

### 2. Check Commits

```bash
# View last 5 commits
git log --oneline -5

# View detailed commit
git show
```

### 3. Check Branch

```bash
# List all branches
git branch -a

# Should show:
# * main
#   remotes/origin/main
```

---

## 🔄 Subsequent Changes

Setelah initial push, untuk update code:

```bash
# Make changes to files
# ...

# Stage changes
git add .

# Commit
git commit -m "feat: deskripsi perubahan"

# Push
git push
```

---

## 🐛 Troubleshooting

### Error: "fatal: not a git repository"

```bash
# Solution: Initialize git first
cd /path/to/Lacak-Lokasi
git init
```

### Error: "fatal: remote origin already exists"

```bash
# Solution: Remove existing remote
git remote remove origin
git remote add origin https://github.com/Sneijderlino/Lacak-Lokasi.git
```

### Error: "Permission denied (publickey)" (SSH)

```bash
# Check SSH key
ssh -T git@github.com

# If fails:
# 1. Verify key exists: ls ~/.ssh/id_ed25519
# 2. Add to SSH agent: ssh-add ~/.ssh/id_ed25519
# 3. Start SSH agent: eval "$(ssh-agent -s)"
# 4. Try again
```

### Error: "Authentication failed" (HTTPS)

```bash
# Make sure token is correct
# Re-enter credentials:
git credential-cache exit

# Try push again - will prompt for credentials
git push
```

### Error: "fatal: branch 'main' does not exist"

```bash
# Rename current branch to main
git branch -M main

# Push
git push -u origin main
```

### Error: "Please tell me who you are"

```bash
# Configure git user
git config --global user.name "Sneijderlino"
git config --global user.email "your_email@example.com"

# Re-commit
git commit -m "initial commit"
```

---

## 🎓 Best Practices

1. **Always pull before push**

   ```bash
   git pull origin main
   git push origin main
   ```

2. **Use meaningful commit messages**
   - ❌ "update" atau "fix"
   - ✅ "feat: add real-time tracking" atau "fix: resolve port binding"

3. **Commit frequently**
   - Smaller, logical commits lebih baik
   - Mudah untuk debug jika ada issue

4. **Review before commit**

   ```bash
   git diff  # Review changes
   git status  # Check staged files
   ```

5. **Protect SSH keys**
   - Jangan commit private keys
   - Jangan share token/keys
   - Rotate keys secara berkala

---

## 📚 Resources

- [GitHub SSH Setup](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [GitHub Personal Access Tokens](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [Git Documentation](https://git-scm.com/doc)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

## 🔒 Security Tips

1. **Keep SSH keys safe**
   - Private key permissions: `chmod 600 ~/.ssh/id_ed25519`
   - Never share private key

2. **Rotate tokens periodically**
   - GitHub recommends rotating every 90 days
   - Delete old tokens from GitHub settings

3. **Use SSH whenever possible**
   - More secure than HTTPS with tokens
   - No risk of token leakage in history

4. **Add to .gitignore**
   - Sensitive files (API keys, credentials)
   - Environment files (.env, .env.local)
   - Build artifacts

---

## ✅ Final Checklist

Sebelum push final:

- [ ] Repository dibuat di GitHub
- [ ] SSH key atau PAT sudah configured
- [ ] Git user.name dan user.email sudah set
- [ ] Remote origin correctly configured
- [ ] Semua files staged dengan `git add .`
- [ ] Commit sudah dibuat dengan meaningful message
- [ ] `git status` menunjukkan "nothing to commit"
- [ ] SSH/HTTPS connection tested

---

## 📞 Need Help?

Jika mengalami masalah:

1. Check error message dengan teliti
2. Search solution di [Stack Overflow](https://stackoverflow.com/questions/tagged/git)
3. Baca [Git Documentation](https://git-scm.com/doc)
4. Buka issue di [GitHub Issues](https://github.com/Sneijderlino/Lacak-Lokasi/issues)

---

**Happy coding! 🚀**
