# Tutorial 6 — Menu & In-Game GUI

Pada Tutorial 6 ini, saya mengimplementasikan sistem **Menu** dan **In-Game GUI** ke dalam proyek game platformer 2D berbasis Godot 4. Implementasi mencakup Main Menu, sistem manajemen nyawa, HUD berbasis ikon hati, layar Game Over, layar Win Screen, serta beberapa fitur tambahan.

---

## Daftar Fitur yang Diimplementasikan

| No | Fitur | Scene/Script |
|----|-------|-------------|
| 1 | Main Menu | `MainMenu.tscn` |
| 2 | Global Variable (Autoload) | `Global.gd` |
| 3 | HUD Life Counter (ikon hati) | `Life Counter.tscn` |
| 4 | Death Trigger & Game Over | `Area2D.gd` |
| 5 | Game Over Screen | `Game Over.tscn` |
| Tambahan | Tombol Try Again & Main Menu | `game_over.gd` |
| Tambahan | Stage Select Screen | `StageSelect.tscn` |
| Tambahan | Transisi Scene (efek fade) | `SceneTransition.gd` |
| Tambahan | Win Screen interaktif | `Win Screen.tscn` |

---

## Penjelasan Implementasi

### 1. Main Menu (`MainMenu.tscn`)

Scene dibuat dengan root node `MarginContainer` yang berisi `HBoxContainer` untuk membagi layar menjadi dua bagian:
- **Kiri:** judul game dan dua tombol `LinkButton` (*New Game* dan *Stage Select*)
- **Kanan:** gambar dekoratif menggunakan `TextureRect`

Tombol *New Game* menggunakan script `link_button.gd` dengan export variable `scene_to_load = "Level 1"`. Signal `pressed` dihubungkan ke fungsi `_on_New_Game_pressed` yang memanggil `change_scene_to_file()`.

---

### 2. Global Variable (`Global.gd`)

Script `Global.gd` didaftarkan sebagai **Autoload Singleton** melalui **Project → Project Settings → Autoload**.
```gdscript
extends Node

var lives = 3
```

Variabel `lives` dapat diakses dari scene manapun dan direset ke `3` setiap kali permainan dimulai ulang.

---

### 3. HUD Life Counter (`Life Counter.tscn`)

Scene menggunakan `MarginContainer` → `HBoxContainer` yang memuat tiga node `TextureRect` (`Heart1`, `Heart2`, `Heart3`).

Script `hearts.gd` memperbarui tampilan setiap frame via `_process()`:
- Jika `Global.lives >= i` → tampilkan `hudHeart_full.png`
- Sebaliknya → tampilkan `hudHeart_empty.png`

Scene ini diinstansiasi di dalam `CanvasLayer` pada Level 1 dan Level 2.

---

### 4. Death Trigger & Pengurangan Nyawa (`Area2D.gd`)

Area trigger ditempatkan di bawah peta. Saat player menyentuh trigger:
- `Global.lives` dikurangi 1
- Jika `lives == 0` → pindah ke `Game Over.tscn`
- Jika masih ada nyawa → reload level yang sama

Semua perpindahan scene dilakukan melalui `SceneTransition.change_scene()` agar mendapat efek fade.

---

### 5. Game Over Screen (`Game Over.tscn`)

Root node `ColorRect` berwarna merah gelap dengan `VBoxContainer` berisi label besar "GAME OVER" dan `HBoxContainer` dengan dua tombol: *Try Again* dan *Main Menu*.

---

## Fitur Tambahan

### Fitur Tambahan 1 — Tombol Try Again & Kembali ke Main Menu

Dua tombol ditambahkan pada `Game Over.tscn`. Script `game_over.gd` memiliki dua fungsi:
```gdscript
func _on_try_again_pressed():
    Global.lives = 3
    SceneTransition.change_scene("res://scenes/Level 1.tscn")

func _on_back_pressed():
    Global.lives = 3
    SceneTransition.change_scene("res://scenes/MainMenu.tscn")
```

---

### Fitur Tambahan 2 — Stage Select Screen (`StageSelect.tscn`)

Scene dengan root `ColorRect` biru gelap berisi `VBoxContainer` dengan label judul "Stage Select" dan tiga `LinkButton`: *Level 1*, *Level 2*, dan *Back*. Tombol *Stage Select* di Main Menu menggunakan `scene_to_load = "StageSelect"` untuk membuka layar ini.

---

### Fitur Tambahan 3 — Transisi Scene dengan Efek Fade (`SceneTransition.gd`)

Script `SceneTransition.gd` didaftarkan sebagai Autoload Singleton kedua. Cara kerja fungsi `change_scene(path)`:

1. Buat `ColorRect` hitam transparan di layer 100 (di atas semua elemen)
2. Fade in — layar menjadi hitam penuh dalam 0.4 detik
3. Panggil `change_scene_to_file()`
4. Fade out — layar kembali transparan dalam 0.4 detik

---

### Fitur Tambahan 4 — Win Screen Interaktif (`Win Screen.tscn`)

Layar menang didesain ulang menjadi scene interaktif dengan root `ColorRect` biru tua, menampilkan teks "YOU WIN!", gambar dekoratif, serta tombol *Play Again* (reset nyawa lalu ke Level 1) dan *Main Menu*.

---

## Referensi

- [Modul Tutorial 6 — Game Development FASILKOM UI](https://csui-game-development.github.io/tutorials/tutorial-6/)
- [Kenney Platformer Pack](https://kenney.nl/assets/platformer-pack-redux) — aset ikon hati HUD
- [Dokumentasi Godot Engine 4.x](https://docs.godotengine.org/en/stable/) — `CanvasLayer`, `Tween`, `Autoload`, scene management
- Implementasi kode dibantu oleh Claude AI (Anthropic) dan GitHub Copilot