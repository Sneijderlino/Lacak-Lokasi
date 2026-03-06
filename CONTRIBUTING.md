# 🤝 Panduan Kontribusi - Lacak-Lokasi

Terima kasih telah tertarik berkontribusi pada proyek Lacak-Lokasi! Dokumen ini menjelaskan cara berkontribusi dengan cara yang efektif dan profesional.

## 📋 Daftar Isi

- [Code of Conduct](#code-of-conduct)
- [Cara Memulai](#cara-memulai)
- [Proses Pengembangan](#proses-pengembangan)
- [Style Guide](#style-guide)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)
- [Troubleshooting](#troubleshooting)

---

## 📝 Code of Conduct

Kami berkomitmen untuk menyediakan lingkungan yang ramah dan inklusif. Semua kontributor harus mengikuti [Code of Conduct](CODE_OF_CONDUCT.md).

**Ringkas:**

- Perlakukan semua orang dengan hormat
- Tidak ada diskriminasi atau pelecehan
- Beri feedback yang konstruktif
- Fokus pada kepentingan komunitas

---

## 🚀 Cara Memulai

### 1. Fork Repository

Kunjungi [repository ini](https://github.com/Sneijderlino/Lacak-Lokasi) dan klik **Fork** di sudut kanan atas.

### 2. Clone Fork Anda

```bash
git clone https://github.com/USERNAME/Lacak-Lokasi.git
cd Lacak-Lokasi
```

### 3. Setup Development Environment

```bash
# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies + dev tools
pip install -r requirements.txt
pip install -r requirements-dev.txt
```

### 4. Create Feature Branch

```bash
# Update main branch
git fetch upstream
git checkout main
git merge upstream/main

# Create feature branch
git checkout -b feature/deskripsi-fitur
# atau untuk bug fix
git checkout -b fix/deskripsi-bug
```

---

## 💻 Proses Pengembangan

### Development Workflow

```bash
# 1. Buat perubahan
# Edit files...

# 2. Test perubahan
python -m pytest tests/
python Ghost-Phishing-Lokasi.py

# 3. Lihat format code
pylint *.py
black *.py

# 4. Stage changes
git add .

# 5. Commit dengan pesan deskriptif
git commit -m "feat: tambah fitur pelacakan real-time"

# 6. Push ke fork
git push origin feature/deskripsi-fitur

# 7. Buat Pull Request via GitHub
```

### Testing

Sebelum submit, pastikan:

```bash
# Run unit tests
pytest tests/ -v

# Check code coverage
pytest --cov=. tests/

# Lint code
pylint **/*.py

# Format code
black .
```

### Local Testing

```bash
# Test aplikasi lokal
python Ghost-Phishing-Lokasi.py

# Akses di browser
http://localhost:8000

# Monitor logs
tail -f logs/app.log
```

---

## 🎨 Style Guide

### Python Code Style

Kami menggunakan **PEP 8** dan **Black** untuk formatting.

#### Naming Conventions

```python
# Functions dan variables: snake_case
def get_user_location():
    pass

user_data = {}

# Classes: PascalCase
class LocationTracker:
    pass

# Constants: UPPER_SNAKE_CASE
MAX_CONNECTIONS = 100
DEBUG_MODE = True
```

#### Code Structure

```python
"""
Module docstring dengan deskripsi singkat.
Deskripsi panjang jika diperlukan.
"""

# Imports diurutkan
import os
from typing import Dict, List

# Constants
DEFAULT_PORT = 8000

# Classes
class MyClass:
    """Class docstring."""

    def __init__(self):
        """Initialize."""
        pass

    def method(self):
        """Method docstring."""
        pass

# Functions
def my_function():
    """Function docstring."""
    pass

# Main
if __name__ == "__main__":
    pass
```

#### Comments dan Docstrings

```python
def calculate_distance(lat1, lon1, lat2, lon2):
    """
    Calculate distance between two coordinates.

    Args:
        lat1 (float): Latitude of first point
        lon1 (float): Longitude of first point
        lat2 (float): Latitude of second point
        lon2 (float): Longitude of second point

    Returns:
        float: Distance in kilometers

    Raises:
        ValueError: If coordinates are invalid
    """
    # Validate coordinates
    if not (-90 <= lat1 <= 90):
        raise ValueError("Invalid latitude")

    # Calculate using Haversine formula
    # ... implementation
```

### HTML/CSS/JavaScript

```html
<!-- Semantik HTML -->
<section class="tracker">
  <h1>Pelacakan Lokasi</h1>
  <div class="map-container">
    <!-- content -->
  </div>
</section>

<!-- CSS: BEM naming -->
<style>
  .tracker {
  }
  .tracker__title {
  }
  .tracker__map-container {
  }
  .tracker--active {
  }
</style>

<!-- JavaScript: camelCase -->
const mapContainer = document.querySelector('.map'); function initializeMap() {}
```

---

## 💬 Commit Messages

Gunakan **Conventional Commits** format:

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type

- **feat**: Fitur baru
- **fix**: Bug fix
- **docs**: Dokumentasi
- **style**: Formatting (tidak ada perubahan logic)
- **refactor**: Refactoring code
- **perf**: Performance improvement
- **test**: Menambah/update tests
- **chore**: Build, deps, tools

### Contoh

```bash
# Feature
git commit -m "feat(location): add real-time tracking"

# Bug fix
git commit -m "fix(server): resolve port conflict on startup"

# Documentation
git commit -m "docs: update installation guide for Termux"

# Dengan body dan footer
git commit -m "feat(api): add distance calculation endpoint

- Implement Haversine formula
- Add input validation
- Include unit tests

Fixes #123"
```

---

## 🔀 Pull Request Process

### Checklist Sebelum Submit PR

- [ ] Code sudah di-test lokal
- [ ] Semua tests lulus: `pytest tests/`
- [ ] Code di-format: `black .`
- [ ] Lint checks lulus: `pylint *.py`
- [ ] Updated relevant documentation
- [ ] Added unit tests untuk fitur baru
- [ ] Commit messages mengikuti convention
- [ ] Branch di-rebase dengan main branch terbaru

### Membuat Pull Request

1. **Pergi ke GitHub**

Kunjungi fork Anda dan klik "Compare & pull request"

2. **Fill PR Template**

```markdown
## Deskripsi

Jelaskan apa yang diubah dan mengapa.

## Tipe Perubahan

- [ ] Bug fix
- [ ] Fitur baru
- [ ] Breaking change
- [ ] Documentation update

## Bagaimana Ditest?

Jelaskan langkah-langkah untuk test perubahan.

## Screenshots (jika ada)

Tambahkan screenshot untuk UI changes.

## Checklist

- [ ] Kode sudah di-test
- [ ] Documentation updated
- [ ] Tidak ada breaking changes
```

3. **Review Expectations**

Maintainer akan:

- Review code quality
- Check tests coverage
- Verify documentation
- Request changes jika dibutuhkan

### Merespons Review Comments

```bash
# Edit file berdasarkan feedback
# ...

# Commit changes
git commit -m "refactor: address review comments"

# Push tanpa harus push force
git push origin feature/branch-name
```

---

## 🐛 Melaporkan Bug

### Bug Report Format

Buat issue dengan template ini:

```markdown
## Deskripsi Bug

Jelaskan bug dengan jelas dan singkat.

## Cara Mereproduksi

1. Step 1
2. Step 2
3. Step 3

## Expected Behavior

Apa yang seharusnya terjadi?

## Actual Behavior

Apa yang benar-benar terjadi?

## Environment

- OS: Ubuntu 22.04 / Windows WSL2 / Termux
- Python: 3.9
- Browser: Chrome 120
- Application version: 1.0.0

## Logs
```

Paste error logs atau stack trace

```

## Screenshots

Attached screenshots (jika relevan)
```

---

## 💡 Mengusulkan Fitur

Buat issue dengan template ini:

```markdown
## Deskripsi

Jelaskan fitur yang diusulkan.

## Motivasi

Mengapa fitur ini diperlukan?

## Solusi

Bagaimana fitur ini bisa diimplementasikan?

## Alternatif

Apakah ada alternatif lain?
```

---

## 🔍 Troubleshooting

### Merge Conflicts

```bash
# Update main branch Anda
git fetch upstream
git rebase upstream/main

# Resolve conflicts di text editor
# Lalu push lagi
git push origin feature/branch --force-with-lease
```

### Reset ke Main

```bash
git fetch upstream
git reset --hard upstream/main
git push origin main --force-with-lease
```

### Remove Local Branch

```bash
git branch -d feature/branch-name
```

---

## 📚 Resources

- [Python PEP 8](https://pep8.org/)
- [Black Code Formatter](https://black.readthedocs.io/)
- [Git Workflow](https://git-scm.com/)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

## 🎉 Terima Kasih!

Kontribusi Anda sangat berarti bagi pengembangan proyek ini. Bersama-sama kita membuat aplikasi yang lebih baik!

**Need help?**

- 💬 GitHub Discussions: [Lacak-Lokasi Discussions](https://github.com/Sneijderlino/Lacak-Lokasi/discussions)
- 🐛 Report Issues: [GitHub Issues](https://github.com/Sneijderlino/Lacak-Lokasi/issues)

---

**Happy coding! 🚀**
