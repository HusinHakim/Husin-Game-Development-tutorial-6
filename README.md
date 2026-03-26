# Laporan Tutorial 6 - Game Development

Pada tugas Tutorial 6 ini, saya telah mengimplementasikan sistem *Menu* dan *In-Game GUI* ke dalam proyek game platformer. Implementasi mencakup pembuatan *Main Menu*, sistem manajemen nyawa menggunakan *Autoload*, *HUD* berbasis ikon hati, layar *Game Over*, layar *Win Screen*, serta berbagai fitur tambahan seperti *Stage Select*, transisi antar-*scene* dengan efek *fade*, dan tombol kembali ke *Main Menu*.

## Penjelasan Implementasi Menu & In-Game GUI

### 1. Main Menu (MainMenu.tscn)

**Proses Implementasi:** *Scene* `MainMenu.tscn` dibuat dengan *root* node `MarginContainer` yang berisi layout `HBoxContainer` untuk membagi layar menjadi dua bagian: panel navigasi di kiri dan gambar dekoratif di kanan. Panel navigasi memuat judul game serta dua tombol `LinkButton`, yaitu *New Game* dan *Stage Select*. Tombol *New Game* menggunakan *script* `link_button.gd` dengan *export variable* `scene_to_load` yang diisi nilai `"Level 1"` agar langsung memuat *Level 1* saat ditekan. Signal `pressed` dihubungkan ke fungsi `_on_New_Game_pressed` di dalam *script* yang sama.

### 2. Autoload Global (Global.gd)

**Proses Implementasi:** *Script* `Global.gd` didaftarkan sebagai *Autoload Singleton* melalui menu **Project → Project Settings → Autoload** dengan nama `Global`. Singleton ini menyimpan variabel `var lives = 3` yang dapat diakses dan dimodifikasi dari *scene* manapun tanpa perlu menggunakan `get_node`. Nilai `lives` dikurangi setiap kali pemain menyentuh *death trigger*, dan direset ke `3` setiap kali permainan dimulai ulang.

### 3. In-Game HUD — Life Counter (Life Counter.tscn)

**Proses Implementasi:** *Scene* `Life Counter.tscn` dibuat dengan *root* node `MarginContainer` dan *child* `HBoxContainer` yang memuat tiga node `TextureRect` bernama `Heart1`, `Heart2`, dan `Heart3`. Aset yang digunakan adalah `hudHeart_full.png` dan `hudHeart_empty.png` dari paket Kenney Platformer Pack. *Script* `hearts.gd` di-*attach* pada *root* dan memperbarui tekstur setiap *frame* melalui `_process()`: jika `Global.lives >= i`, tampilkan hati penuh; sebaliknya tampilkan hati kosong. *Scene* ini diinstansiasi di dalam `CanvasLayer` pada Level 1 dan Level 2 agar tampil di atas semua elemen *gameplay*.

### 4. Sistem Death Trigger & Game Over (Area2D.gd)

**Proses Implementasi:** *Script* `Area2D.gd` di-*attach* pada node *Area Trigger* yang ditempatkan di bawah peta permainan. Saat `body_entered` terdeteksi dan nama *body* adalah `"Player"`, nilai `Global.lives` dikurangi satu. Jika `Global.lives == 0`, permainan berpindah ke *scene* `Game Over.tscn`; jika masih ada sisa nyawa, *scene* level yang sama dimuat ulang. Seluruh perpindahan *scene* dilakukan melalui `SceneTransition.change_scene()` agar mendapat efek *fade*.

### 5. Game Over Screen (Game Over.tscn)

**Proses Implementasi:** *Scene* `Game Over.tscn` memiliki *root* node `ColorRect` berwarna merah gelap dengan *script* `game_over.gd` yang meng-*extend* `ColorRect`. Di dalamnya terdapat `VBoxContainer` yang menampung teks besar `"GAME OVER"` dan `HBoxContainer` berisi dua tombol: *Try Again* dan *Main Menu*. Kedua tombol menghubungkan signal `pressed`-nya ke *method* pada *root* menggunakan `to="."`. Saat tombol ditekan, `Global.lives` direset ke `3` sebelum berpindah *scene*.

---

## Fitur Tambahan

### Fitur Tambahan 1 — Tombol Kembali ke Main Menu & Try Again

**Proses Implementasi:** Tombol *Try Again* dan *Main Menu* ditambahkan pada `Game Over.tscn` menggunakan node `Button` di dalam `HBoxContainer`. *Script* `game_over.gd` yang meng-*extend* `ColorRect` (node *root*) memiliki dua fungsi: `_on_try_again_pressed()` dan `_on_back_pressed()`. Keduanya memanggil `Global.lives = 3` terlebih dahulu untuk mereset nyawa, kemudian memanggil `SceneTransition.change_scene()` untuk berpindah ke *scene* yang sesuai. Signal dari masing-masing tombol dihubungkan ke *root* scene menggunakan sintaks `to="."` pada blok `[connection]` di file `.tscn`.

### Fitur Tambahan 2 — Stage Select Screen (StageSelect.tscn)

**Proses Implementasi:** *Scene* `StageSelect.tscn` dibuat dengan *root* node `ColorRect` berwarna biru gelap. Di dalamnya terdapat `VBoxContainer` yang berisi label judul `"Stage Select"` serta tiga `LinkButton`: *Level 1*, *Level 2*, dan *← Back*. Ketiga tombol menggunakan *script* `link_button.gd` yang sama dengan tombol di *Main Menu*, cukup dengan mengisi *export variable* `scene_to_load` sesuai nama *scene* tujuan. Tombol *Stage Select* di `MainMenu.tscn` dihubungkan ke *script* yang sama dengan `scene_to_load = "StageSelect"` sehingga saat ditekan akan membuka layar pemilihan level.

### Fitur Tambahan 3 — Transisi Scene dengan Efek Fade (SceneTransition.gd)

**Proses Implementasi:** *Script* `SceneTransition.gd` meng-*extend* `CanvasLayer` dan didaftarkan sebagai *Autoload Singleton* kedua melalui **Project Settings → Autoload**. Saat *ready*, *script* ini membuat sebuah `ColorRect` hitam transparan yang menutupi seluruh layar (`PRESET_FULL_RECT`) dan menempatkannya pada *layer* 100 agar berada di atas semua elemen lain. Fungsi publik `change_scene(path)` menjalankan dua *Tween*: pertama memudarkan layar menjadi hitam penuh (0 → 1 dalam 0,4 detik), memanggil `change_scene_to_file()`, menunggu satu *frame* agar *scene* baru selesai dimuat, kemudian memudarkan kembali menjadi transparan (1 → 0 dalam 0,4 detik). Seluruh perpindahan *scene* dalam proyek ini diganti menggunakan `SceneTransition.change_scene()`.

### Fitur Tambahan 4 — Win Screen (Win Screen.tscn)

**Proses Implementasi:** *Scene* `Win Screen.tscn` didesain ulang dari `Sprite2D` statis menjadi *scene* interaktif dengan *root* `ColorRect` berwarna biru tua dan *script* `win_screen.gd`. Layar ini menampilkan teks `"YOU WIN!"` berwarna kuning emas, gambar dekoratif `Keanu.png`, serta dua tombol: *Play Again* (memuat ulang dari Level 1 dengan nyawa direset) dan *Main Menu* (kembali ke *Main Menu* dengan nyawa direset). Tanpa fitur ini, layar menang adalah *dead end* tanpa cara kembali ke permainan.

---

## Referensi

- Modul Tutorial 6 Game Development, Fakultas Ilmu Komputer Universitas Indonesia.
- [Kenney Platformer Pack](https://kenney.nl/assets/platformer-pack-redux) — Aset HUD hati (`hudHeart_full.png`, `hudHeart_empty.png`) dan elemen visual lainnya.
- Dokumentasi resmi Godot Engine 4.x (Terkait modul `CanvasLayer`, `Tween`, `Control`, `Autoload`, dan sistem *scene change*).
- Implementasi kode dibantu oleh Claude AI (Anthropic).
