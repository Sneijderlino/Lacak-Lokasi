---
name: Pull Request
about: Kirim Pull Request untuk membawa perubahan ke repository
title: "[PR] Deskripsi singkat dari PR"
labels: review-needed
assignees: Sneijderlino
---

## 📝 Deskripsi

Jelaskan perubahan yang Anda buat dan mengapa perubahan ini diperlukan.

**Tipe Perubahan**:

- [ ] 🐛 Bug fix (non-breaking change yang memperbaiki issue)
- [ ] ✨ Fitur baru (non-breaking change yang menambah fitur)
- [ ] 💥 Breaking change (fix atau feature yang menyebabkan breaking change)
- [ ] 📚 Documentation update
- [ ] 🎨 Style/Format changes
- [ ] ♻️ Refactoring

---

## 🔗 Related Issues

Closes #(issue number)

---

## ✅ Checklist

**Pre-submission**:

- [ ] Kode saya sudah di-test lokal
- [ ] Semua tests lulus: `pytest tests/`
- [ ] Code sudah di-format: `black .`
- [ ] Lint checks lulus: `pylint *.py`
- [ ] Documentation sudah di-update
- [ ] Commit messages mengikuti convention

**Code Quality**:

- [ ] Tidak ada breaking changes
- [ ] Error handling sudah ditambahkan
- [ ] Logging sudah ditambahkan jika diperlukan
- [ ] Performance sudah dipertimbangkan

**Testing**:

- [ ] Unit tests sudah ditambahkan/diupdate
- [ ] Integration tests sudah ditambahkan jika perlu
- [ ] Manual testing sudah dilakukan
- [ ] Edge cases sudah di-test

**Documentation**:

- [ ] README updated
- [ ] Docstrings ditambahkan/diupdate
- [ ] API documentation updated (jika ada)
- [ ] CHANGELOG updated

---

## 🧪 Testing

Jelaskan bagaimana PR ini sudah ditest:

**Manual Testing Steps**:

1. Step 1
2. Step 2
3. ...

**Test Results**:

- [ ] ✅ All tests passed
- [ ] ❌ Some tests failed (jelaskan di bawah)

---

## 📸 Screenshots

Jika ada UI changes, sertakan screenshots:

**Before**:
(screenshot before changes)

**After**:
(screenshot after changes)

---

## 📊 Performance Impact

Apakah PR ini mempengaruhi performance?

- [ ] ✅ No performance impact
- [ ] ⚠️ Minor performance improvement/regression
- [ ] 📈 Significant performance change

Details:
(jelaskan jika ada impact)

---

## 🔍 Pertanyaan untuk Reviewer

Apakah ada hal spesifik yang Anda ingin reviewer fokus pada?

---

## 📝 Additional Notes

Informasi tambahan yang penting untuk reviewer:

---

## 🚀 Deployment

- [ ] Ready untuk production
- [ ] Perlu configuration changes
- [ ] Perlu database migration
- [ ] Perlu announce ke users

---

## ✨ Terima Kasih!

Terima kasih sudah berkontribusi pada Lacak-Lokasi! Kami sangat menghargai usaha Anda.

Jika Anda memiliki pertanyaan, jangan ragu untuk bertanya di PR ini atau hubungi kami di GitHub Discussions.
