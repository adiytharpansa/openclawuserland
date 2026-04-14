---
name: permanent-memory
description: Skill untuk mengelola ingatan permanen agent lintas sesi. Gunakan ketika perlu menyimpan informasi penting ke MEMORY.md, membuat/mengupdate daily notes di memory/YYYY-MM-DD.md, mencari memori lama, atau mengkonsolidasi catatan harian menjadi ingatan jangka panjang.
---

# Permanent Memory

Skill ini menyediakan sistem ingatan terstruktur untuk agent agar bisa mengingat informasi penting lintas sesi.

## Struktur Memori

```
workspace/
├── MEMORY.md              # Ingatan jangka panjang (curated)
└── memory/
    ├── YYYY-MM-DD.md      # Catatan harian (raw logs)
    └── heartbeat-state.json # Status heartbeat tracking
```

## Kapan Menggunakan

### Gunakan MEMORY.md untuk:
- Keputusan penting yang dibuat user
- Preferensi user (nama, timezone, gaya komunikasi)
- Proyek ongoing dan statusnya
- Pelajaran yang sudah proven (dari .learnings/)
- Informasi yang perlu diingat >1 minggu

### Gunakan memory/YYYY-MM-DD.md untuk:
- Log aktivitas harian
- Catatan meeting/konversi
- Task yang selesai hari ini
- Informasi yang mungkin temporary

## Perintah Utama

### 1. Simpan ke MEMORY.md

```bash
scripts/save-memory.sh "Informasi yang ingin disimpan"
```

Atau edit langsung dengan format:
```markdown
## [2026-04-14] Topik
- Poin penting 1
- Poin penting 2
```

### 2. Buat Daily Note

```bash
scripts/daily-note.sh
```

Membuat file `memory/YYYY-MM-DD.md` dengan template jika belum ada.

### 3. Cari Memori

```bash
scripts/search-memory.sh "keyword yang dicari"
```

Mencari di MEMORY.md dan semua daily notes.

### 4. Konsolidasi Memori

```bash
scripts/consolidate-memory.sh
```

Review daily notes terakhir dan pindahkan yang penting ke MEMORY.md.

## Workflow Standar

### Saat Sesi Baru (Startup)
1. Baca `SOUL.md` - identitas agent
2. Baca `USER.md` - info user
3. Baca `MEMORY.md` - ingatan jangka panjang
4. Baca `memory/YYYY-MM-DD.md` (hari ini + kemarin)

### Saat Sesi Berakhir
1. Review percakapan - ada info penting?
2. Jika ada → update `memory/YYYY-MM-DD.md`
3. Jika sangat penting → update `MEMORY.md`

### Heartbeat (Periodik)
1. Cek `memory/heartbeat-state.json` - kapan terakhir check
2. Lakukan periodic review
3. Konsolidasi memori jika sudah >3 hari

## Format Entry

### MEMORY.md Entry
```markdown
## [2026-04-14] Nama Proyek/Topik
**Status**: ongoing | done | archived
**Prioritas**: high | medium | low
- Poin penting 1
- Poin penting 2
- Link terkait: [[path/to/file.md]]
```

### Daily Note Entry
```markdown
## [07:10] Aktivitas/Percakapan
- Apa yang terjadi
- Keputusan yang dibuat
- Action items

## TODO
- [ ] Task 1
- [ ] Task 2
```

## Best Practices

1. **Jangan simpan rahasia** - password, API keys, data sensitif
2. **Ringkas, jangan copy-paste** - tulis inti, bukan seluruh percakapan
3. **Update, jangan duplikat** - edit entry existing kalau ada update
4. **Review mingguan** - hapus yang udah nggak relevan

## Files

- `scripts/save-memory.sh` - Simpan entry ke MEMORY.md
- `scripts/daily-note.sh` - Buat/ambil daily note
- `scripts/search-memory.sh` - Cari di semua memori
- `scripts/consolidate-memory.sh` - Pindahkan daily → long-term
- `references/memory-template.md` - Template format memori
