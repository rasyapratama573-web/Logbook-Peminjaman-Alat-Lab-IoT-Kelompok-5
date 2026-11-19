# Logbook Peminjaman Alat Lab IoT

**Proyek Pemrograman Mobile 2 — Kelompok 5**

Aplikasi ini dikembangkan menggunakan Flutter untuk membantu pencatatan peminjaman dan pengembalian alat di Laboratorium IoT. Proyek ini juga mengintegrasikan teknologi blockchain melalui smart contract agar aplikasi dapat berinteraksi dengan data yang tercatat di jaringan blockchain.

## Fitur Aplikasi

### Pengguna
- Melihat halaman utama atau dashboard aplikasi.
- Mengakses menu peminjaman alat.
- Mengisi atau mengelola informasi peminjaman melalui tampilan aplikasi.
- Melihat riwayat peminjaman.
- Menghubungkan wallet melalui komponen integrasi Web3 yang digunakan aplikasi.

### Integrasi Blockchain
- Menghubungkan aplikasi Flutter ke jaringan blockchain melalui layanan RPC.
- Menggunakan ABI dan alamat smart contract untuk berkomunikasi dengan kontrak.
- Menyiapkan proses pembacaan data dan pengiriman transaksi dari aplikasi.

> Catatan: Fitur yang tersedia dan keberhasilan transaksi perlu diperiksa melalui pengujian langsung pada versi aplikasi yang digunakan.

## Teknologi yang Digunakan

| Teknologi | Kegunaan |
| --- | --- |
| Flutter | Framework untuk membangun aplikasi |
| Dart | Bahasa pemrograman aplikasi Flutter |
| Solidity | Bahasa yang digunakan untuk mengembangkan smart contract |
| Remix IDE | Lingkungan pengembangan dan pengujian smart contract |
| Web3dart | Komunikasi dengan blockchain dari Dart |
| Reown AppKit | Integrasi koneksi wallet |
| Ethereum Sepolia | Jaringan testnet yang digunakan dalam konfigurasi blockchain proyek |

## Versi Perangkat dan Paket

### Versi Proyek
- Versi aplikasi pada `pubspec.yaml`: `1.0.0+1`.
- Persyaratan Dart SDK pada `pubspec.yaml`: `^3.14.0`.
- Versi Flutter SDK yang terpasang pada komputer pengembang dapat diperiksa dengan `flutter --version`.

### Dependencies Utama

| Paket | Versi pada `pubspec.yaml` |
| --- | --- |
| `material_ui` | `^1.1.0` |
| `web3dart` | `3.0.3` |
| `http` | `^1.6.0` |
| `intl` | `^0.20.3` |
| `cupertino_icons` | `^1.0.8` |
| `reown_appkit` | `^1.9.0` |
| `wallet` | `^0.0.18` |
| `url_launcher` | `^6.3.3` |

**Dev dependencies:** `flutter_test` dan `flutter_lints` (`^6.0.0`).

## Jaringan Blockchain

Konfigurasi koneksi blockchain aplikasi terdapat pada file `lib/config/blockchain_config.dart`.

- **Jaringan pengembangan:** Ethereum Sepolia Testnet.
- **Chain ID Sepolia:** `11155111`.
- **RPC endpoint dan alamat kontrak:** lihat konfigurasi proyek yang terbaru sebelum menjalankan aplikasi.
- **ABI:** `assets/abi/LogbookIoT.json`.

Jangan pernah menyimpan private key, seed phrase, atau token rahasia di repository publik.

## Smart Contract

Proyek menggunakan smart contract untuk mendukung pencatatan data melalui blockchain. File ABI yang dipakai aplikasi berada di `assets/abi/LogbookIoT.json`.

Repository juga memiliki folder `smart_contract/`. Pada unggahan yang sudah terkonfirmasi, folder ini berisi file halaman Remix berformat HTML. **File HTML tersebut bukan pengganti source code Solidity (`.sol`)**. Apabila file `.sol` asli tersedia, tambahkan ke folder ini agar kode kontrak bisa diperiksa dan dikompilasi ulang.

## Struktur Repository

```text
Logbook-Peminjaman-Alat-Lab-IoT-Kelompok-5/
├── android/                 # Konfigurasi aplikasi Android
├── assets/
│   └── abi/
│       └── LogbookIoT.json  # ABI smart contract
├── ios/
├── lib/
│   ├── config/              # Konfigurasi blockchain
│   ├── models/              # Model data aplikasi
│   ├── screens/             # Halaman aplikasi
│   ├── services/            # Layanan dan integrasi blockchain
│   └── main.dart            # Titik awal aplikasi
├── linux/
├── macos/
├── smart_contract/          # Berkas terkait smart contract
├── web/
├── windows/
├── README.md
├── analysis_options.yaml
└── pubspec.yaml
```

## Cara Menjalankan Aplikasi

### 1. Persiapan

Pastikan Flutter SDK, Android SDK, dan Visual Studio Code atau Android Studio sudah terpasang. Siapkan emulator Android atau HP Android yang terhubung ke komputer.

### 2. Clone Repository

```bash
git clone https://github.com/rasyapratama573-web/Logbook-Peminjaman-Alat-Lab-IoT-Kelompok-5.git
cd Logbook-Peminjaman-Alat-Lab-IoT-Kelompok-5
```

### 3. Instal Dependencies

```bash
flutter pub get
```

### 4. Jalankan Aplikasi

```bash
flutter run
```

Jika aplikasi menggunakan blockchain, periksa terlebih dahulu konfigurasi RPC, jaringan, alamat kontrak, serta koneksi wallet.

## Cara Mengembangkan Smart Contract melalui Remix IDE

1. Buka [Remix IDE](https://remix.ethereum.org/).
2. Buka file Solidity (`.sol`) asli apabila sudah tersedia dari pengembang kontrak.
3. Pilih compiler yang sesuai dengan versi Solidity pada file tersebut, lalu lakukan **Compile**.
4. Hubungkan wallet dan pilih jaringan testnet yang digunakan proyek, misalnya Sepolia.
5. Lakukan deployment apabila diperlukan, kemudian simpan alamat kontrak hasil deployment.
6. Jika smart contract berubah, perbarui file ABI dan alamat kontrak pada konfigurasi Flutter agar keduanya sesuai.

## APK Aplikasi

Hasil build APK debug yang diunggah kelompok tersedia melalui GitHub Releases:

**[Unduh APK — Release v1.0.0](https://github.com/rasyapratama573-web/Logbook-Peminjaman-Alat-Lab-IoT-Kelompok-5/releases/tag/v1.0.0)**

File yang terunggah bernama `app-debug.apk`. File ini merupakan **APK debug**, bukan APK release produksi, meskipun tersimpan pada halaman *GitHub Releases*.

## Catatan Keamanan

- Gunakan jaringan testnet saat pengembangan dan pengujian transaksi.
- Jangan memasukkan private key atau seed phrase ke dalam kode dan GitHub.
- Pastikan alamat smart contract dan ABI sesuai sebelum menjalankan transaksi.
- Uji proses peminjaman dan pengembalian, termasuk status keberhasilan transaksi, sebelum aplikasi digunakan lebih luas.

## Tentang Proyek

**Logbook Peminjaman Alat Lab IoT — Kelompok 5** merupakan proyek mata kuliah Pemrograman Mobile 2 yang menggabungkan pengembangan aplikasi Flutter dengan integrasi blockchain untuk kebutuhan pencatatan peminjaman alat laboratorium.
