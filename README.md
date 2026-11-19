# Logbook5 IoT – Aplikasi Flutter Terhubung Blockchain

Aplikasi pencatatan dan pengelolaan peminjaman alat laboratorium berbasis **Flutter**, yang terhubung dengan **Smart Contract Ethereum** pada jaringan **Sepolia Testnet**.

Proyek ini dibuat untuk memenuhi tugas mata kuliah **Pemrograman Mobile** oleh **Kelompok 5**.

## 1. Deskripsi Proyek

**Logbook5 IoT** membantu mencatat peminjaman dan pengembalian alat secara digital. Integrasi blockchain memungkinkan transaksi yang dikirim ke jaringan diperiksa melalui blockchain explorer.

### Fitur aplikasi

- Dashboard aplikasi.
- Pencatatan data peminjaman alat.
- Pengiriman data peminjaman ke Smart Contract.
- Riwayat peminjaman.
- Pengembalian alat yang dipinjam.
- Integrasi Ethereum Sepolia Testnet.
- Koneksi wallet menggunakan Reown AppKit.
- Interaksi Smart Contract menggunakan `web3dart`.
- Pemeriksaan transaksi melalui Etherscan.

## 2. Teknologi yang Digunakan

| Teknologi | Kegunaan |
| --- | --- |
| Flutter | Framework aplikasi mobile |
| Dart | Bahasa pemrograman aplikasi |
| Solidity | Bahasa pemrograman Smart Contract |
| Ethereum Sepolia | Jaringan blockchain untuk pengujian |
| web3dart | Interaksi aplikasi dengan Ethereum |
| Reown AppKit | Koneksi wallet |
| Etherscan | Pemeriksaan transaksi blockchain |
| Android Studio | Android SDK dan build tools |
| Visual Studio Code | Editor kode |
| Gradle | Sistem build Android |
| GitHub | Penyimpanan kode sumber |

## 3. Struktur Proyek

Struktur berikut menggambarkan **bagian utama** proyek. Folder platform seperti `android`, `ios`, `web`, `windows`, `linux`, dan `macos` juga tersedia di repository.

```text
logbook5_iot/
├── lib/
│   ├── config/
│   │   └── blockchain_config.dart
│   ├── models/
│   │   └── peminjaman.dart
│   ├── screens/
│   │   ├── dashboard_screen.dart
│   │   ├── peminjaman_screen.dart
│   │   └── riwayat_screen.dart
│   ├── services/
│   │   ├── blockchain_service.dart
│   │   └── wallet_connect_service.dart
│   ├── theme/
│   │   └── app_theme.dart
│   ├── utils/
│   │   └── etherscan.dart
│   ├── widgets/
│   │   └── menu_card.dart
│   ├── main_screen.dart
│   └── main.dart
├── assets/
│   └── abi/
│       └── LogbookIoT.json
├── smart_contract/
│   └── Remix Web3 - Smart Contract Development.html
├── android/
├── ios/
├── web/
├── windows/
├── linux/
├── macos/
├── pubspec.yaml
└── README.md
```

### Penjelasan folder

| Folder / File | Fungsi |
| --- | --- |
| `lib/config/` | Konfigurasi blockchain dan Smart Contract |
| `lib/models/` | Model data peminjaman |
| `lib/screens/` | Halaman dashboard, peminjaman, dan riwayat |
| `lib/services/` | Koneksi wallet dan komunikasi blockchain |
| `lib/theme/` | Pengaturan tampilan aplikasi |
| `lib/utils/` | Fungsi pendukung, termasuk Etherscan |
| `lib/widgets/` | Komponen antarmuka yang digunakan ulang |
| `lib/main.dart` | Titik awal aplikasi Flutter |
| `lib/main_screen.dart` | Tampilan utama |
| `assets/abi/` | ABI Smart Contract |
| `smart_contract/` | File pendukung pengembangan Smart Contract |
| `pubspec.yaml` | Dependensi dan konfigurasi Flutter |

> **Catatan:** File `.html` pada folder `smart_contract` bukan pengganti file sumber Solidity `.sol`. Nama dan lokasi file `.sol` masih perlu dikonfirmasi kepada anggota kelompok.

## 4. Konfigurasi Blockchain

Konfigurasi aplikasi berada pada `lib/config/blockchain_config.dart`.

| Konfigurasi | Nilai |
| --- | --- |
| Network | Ethereum Sepolia Testnet |
| Chain ID | `11155111` |
| RPC URL | `https://ethereum-sepolia-rpc.publicnode.com` |
| Smart Contract | `LogbookIoT` |
| Contract Address | `0xb89Bff51dEB10C090C4F0154478AFd062195225D` |
| ABI | `assets/abi/LogbookIoT.json` |

[Lihat alamat kontrak di Sepolia Etherscan](https://sepolia.etherscan.io/address/0xb89Bff51dEB10C090C4F0154478AFd062195225D)

## 5. Smart Contract

Smart Contract **LogbookIoT** digunakan untuk mengelola data peminjaman alat pada blockchain.

| Fungsi | Keterangan |
| --- | --- |
| `tambahPeminjaman` | Menambahkan data peminjaman |
| `kembalikanAlat` | Mencatat pengembalian alat |
| `jumlahPeminjaman` | Mengambil jumlah catatan peminjaman |
| `ambilPeminjaman` | Mengambil detail peminjaman berdasarkan ID |

**Informasi tambahan:**

- File ABI: `assets/abi/LogbookIoT.json`
- File Solidity `.sol`: belum dikonfirmasi.
- Versi compiler Solidity: belum dikonfirmasi.

**Referensi:** [Remix IDE](https://remix.ethereum.org/) · [Dokumentasi Solidity](https://docs.soliditylang.org/) · [Dokumentasi Ethereum](https://ethereum.org/en/developers/docs/)

## 6. Integrasi Wallet

Aplikasi menggunakan **Reown AppKit** untuk menghubungkan wallet. Pengguna dapat memberi persetujuan saat mengirim transaksi peminjaman atau pengembalian.

Alur umumnya:

1. Hubungkan wallet ke aplikasi.
2. Pastikan wallet menggunakan jaringan Sepolia.
3. Pilih tindakan peminjaman atau pengembalian.
4. Setujui transaksi melalui wallet.
5. Periksa status transaksi di Etherscan.

**Keamanan:** Jangan memasukkan private key, seed phrase, atau kata sandi wallet ke repository publik.

Referensi: [Reown AppKit](https://docs.reown.com/appkit/flutter/core/installation) · [web3dart](https://pub.dev/packages/web3dart)

## 7. Dependensi dan Package

Dependensi dikelola lewat `pubspec.yaml`. Versi berikut mengikuti dokumentasi proyek yang diberikan kelompok; untuk versi yang terpasang, periksa `pubspec.yaml` dan `pubspec.lock`.

| Package | Versi pada dokumentasi | Kegunaan |
| --- | --- | --- |
| `web3dart` | `3.0.3` | Interaksi dengan Ethereum |
| `http` | `^1.6.0` | Komunikasi melalui HTTP/RPC |
| `intl` | `^0.20.3` | Format tanggal dan angka |
| `reown_appkit` | `^1.9.0` | Koneksi wallet |
| `wallet` | `^0.0.18` | Utilitas wallet |
| `url_launcher` | `^6.3.3` | Membuka tautan eksternal |
| `cupertino_icons` | `^1.0.8` | Ikon |
| `material_ui` | `^1.1.0` | Komponen antarmuka |

Perintah yang dapat digunakan:

```bash
flutter pub get
flutter pub deps
flutter pub outdated
```

## 8. Persyaratan Instalasi

Siapkan Flutter SDK, Dart SDK, Android Studio/Android SDK, VS Code, Git, perangkat Android atau emulator, dan koneksi internet.

| Perangkat lunak | Tautan |
| --- | --- |
| Flutter | https://docs.flutter.dev/get-started/install |
| Dart | https://dart.dev/get-dart |
| Android Studio | https://developer.android.com/studio |
| VS Code | https://code.visualstudio.com/ |
| Git | https://git-scm.com/downloads |

## 9. Cara Menjalankan Proyek

### A. Clone repository

```bash
git clone https://github.com/rasyapratama573-web/Logbook-Peminjaman-Alat-Lab-IoT-Kelompok-5.git
cd Logbook-Peminjaman-Alat-Lab-IoT-Kelompok-5
```

### B. Instal dependensi

```bash
flutter pub get
```

### C. Periksa Flutter dan perangkat

```bash
flutter doctor
flutter devices
```

Aktifkan **USB Debugging** apabila menggunakan smartphone Android.

### D. Jalankan aplikasi

```bash
flutter run
```

### E. Build APK release

```bash
flutter build apk --release
```

Hasil build biasanya terdapat di:

```text
build/app/outputs/flutter-apk/app-release.apk
```

**APK yang sudah tersedia di GitHub Releases merupakan `app-debug.apk` untuk pengujian**, bukan bukti bahwa build release sudah berhasil.

[Unduh APK dari GitHub Releases](https://github.com/rasyapratama573-web/Logbook-Peminjaman-Alat-Lab-IoT-Kelompok-5/releases/tag/v1.0.0)

## 10. Verifikasi Transaksi Blockchain

Buka [Sepolia Etherscan](https://sepolia.etherscan.io/), kemudian masukkan **transaction hash** untuk melihat status, alamat pengirim, alamat tujuan, nomor blok, gas fee, dan waktu transaksi.

[Alamat Smart Contract di Sepolia Etherscan](https://sepolia.etherscan.io/address/0xb89Bff51dEB10C090C4F0154478AFd062195225D)

> Transaksi yang baru dikirim belum tentu langsung berhasil. Pastikan transaksi sudah terkonfirmasi dan statusnya sukses.

## 11. Troubleshooting

### Masalah dependensi

```bash
flutter clean
flutter pub get
```

### Masalah Gradle atau Android SDK

Periksa hasil `flutter doctor`, versi Android SDK, Kotlin, dan Gradle. Setelah konfigurasi diperbaiki, coba:

```bash
flutter clean
flutter pub get
flutter run
```

### Masalah koneksi blockchain atau wallet

Periksa koneksi internet, RPC URL, Chain ID, Contract Address, ABI, jaringan wallet, serta ketersediaan Sepolia ETH untuk biaya gas testnet.

## 12. Link Proyek

| Keterangan | Tautan |
| --- | --- |
| Repository GitHub | [Logbook Peminjaman Alat Lab IoT – Kelompok 5](https://github.com/rasyapratama573-web/Logbook-Peminjaman-Alat-Lab-IoT-Kelompok-5) |
| APK (debug) | [GitHub Release v1.0.0](https://github.com/rasyapratama573-web/Logbook-Peminjaman-Alat-Lab-IoT-Kelompok-5/releases/tag/v1.0.0) |
| Smart Contract | [Sepolia Etherscan](https://sepolia.etherscan.io/address/0xb89Bff51dEB10C090C4F0154478AFd062195225D) |

## 13. Identitas Pengembang

| Keterangan | Identitas |
| --- | --- |
| Nama Proyek | Logbook5 IoT – Aplikasi Flutter Terhubung Blockchain |
| Kelompok | Kelompok 5 |
| Anggota 1 | Muhammad Ezra Fadillah |
| Anggota 2 | Rasya Adzie Pratama |
| Anggota 3 | Jawhariyatu Ummul Immama |
| Anggota 4 | Deandy Jovadhan Diraja K |
| Anggota 5 | Marvin Dimas Awang |
| Mata Kuliah | Pemrograman Mobile |
| Dosen Pengampu | Fara Triadi |

---

**Logbook5 IoT — Kelompok 5**  
Proyek integrasi aplikasi mobile Flutter dengan Smart Contract Ethereum pada Sepolia Testnet.
