Logbook5 IoT – Aplikasi Flutter Terhubung Blockchain

Aplikasi pencatatan dan pengelolaan data peminjaman berbasis Flutter yang terintegrasi dengan teknologi Blockchain menggunakan Smart Contract pada jaringan Ethereum Sepolia Testnet.

Project ini dibuat untuk memenuhi tugas proyek Aplikasi Flutter Terhubung Blockchain.

---

1. Deskripsi Project

Logbook5 IoT merupakan aplikasi mobile yang digunakan untuk membantu proses pencatatan dan pengelolaan data peminjaman alat secara digital.

Aplikasi dikembangkan menggunakan Flutter dan diintegrasikan dengan teknologi blockchain Ethereum agar pencatatan data peminjaman dapat dilakukan secara transparan dan transaksi dapat diverifikasi melalui blockchain explorer.

Fitur Aplikasi

- Menampilkan dashboard aplikasi.
- Melakukan pencatatan data peminjaman alat.
- Menambahkan data peminjaman ke Smart Contract.
- Menampilkan riwayat peminjaman.
- Mengembalikan alat yang dipinjam.
- Integrasi aplikasi dengan jaringan Ethereum Sepolia.
- Koneksi wallet menggunakan Reown AppKit.
- Interaksi dengan Smart Contract menggunakan web3dart.
- Melihat transaksi melalui Etherscan.

---

2. Teknologi yang Digunakan

Teknologi| Keterangan
Flutter| Framework pengembangan aplikasi mobile
Dart| Bahasa pemrograman aplikasi
Solidity| Bahasa pemrograman Smart Contract
Ethereum| Jaringan blockchain
Sepolia Testnet| Jaringan pengujian blockchain
web3dart| Library interaksi dengan Ethereum
Reown AppKit| Integrasi koneksi wallet
Wallet| Pengelolaan koneksi dan transaksi wallet
Etherscan| Blockchain explorer
Android Studio| Android SDK dan build tools
Visual Studio Code| Code editor
Gradle| Sistem build aplikasi Android

---

3. Struktur Project

logbook5_iot/
│
├── lib/
│   │
│   ├── config/
│   │   └── blockchain_config.dart
│   │
│   ├── models/
│   │   └── peminjaman.dart
│   │
│   ├── screens/
│   │   ├── dashboard_screen.dart
│   │   ├── peminjaman_screen.dart
│   │   └── riwayat_screen.dart
│   │
│   ├── services/
│   │   ├── blockchain_service.dart
│   │   └── wallet_connect_service.dart
│   │
│   ├── theme/
│   │   └── app_theme.dart
│   │
│   ├── utils/
│   │   └── etherscan.dart
│   │
│   ├── widgets/
│   │   └── menu_card.dart
│   │
│   ├── main_screen.dart
│   └── main.dart
│
├── assets/
│   └── abi/
│       └── LogbookIoT.json
│
├── pubspec.yaml
└── README.md

Penjelasan Folder

Folder/File| Fungsi
"config/"| Menyimpan konfigurasi jaringan blockchain dan Smart Contract.
"models/"| Menyimpan struktur model data peminjaman.
"screens/"| Menyimpan halaman dashboard, peminjaman, dan riwayat.
"services/"| Mengelola koneksi wallet dan komunikasi dengan blockchain.
"theme/"| Mengatur tema dan tampilan aplikasi.
"utils/"| Menyimpan fungsi pendukung, termasuk akses Etherscan.
"widgets/"| Menyimpan komponen UI yang dapat digunakan kembali.
"main_screen.dart"| Mengatur tampilan utama aplikasi.
"main.dart"| Entry point aplikasi Flutter.
"assets/abi/"| Menyimpan ABI Smart Contract.
"pubspec.yaml"| Mengatur dependency dan konfigurasi project Flutter.

---

4. Konfigurasi Blockchain

Aplikasi menggunakan jaringan Ethereum Sepolia Testnet untuk melakukan interaksi dengan Smart Contract.

Konfigurasi blockchain terdapat pada file:

"lib/config/blockchain_config.dart"

Detail Konfigurasi

Konfigurasi| Nilai
Blockchain Network| Ethereum Sepolia Testnet
Chain ID| "11155111"
RPC URL| "https://ethereum-sepolia-rpc.publicnode.com"
Smart Contract| "LogbookIoT"
Contract Address| "0xb89Bff51dEB10C090C4F0154478AFd062195225D"
ABI Path| "assets/abi/LogbookIoT.json"

Smart Contract Address

0xb89Bff51dEB10C090C4F0154478AFd062195225D

RPC URL

https://ethereum-sepolia-rpc.publicnode.com

Chain ID

11155111

---

5. Smart Contract

Smart Contract digunakan untuk mengelola pencatatan data peminjaman pada jaringan Ethereum Sepolia.

Nama Smart Contract:

"LogbookIoT"

File ABI yang digunakan aplikasi:

"assets/abi/LogbookIoT.json"

Fungsi Smart Contract yang Dipanggil Aplikasi

Fungsi| Keterangan
"tambahPeminjaman"| Menambahkan data peminjaman alat.
"kembalikanAlat"| Mengubah status pengembalian alat.
"jumlahPeminjaman"| Mengambil jumlah data peminjaman.
"ambilPeminjaman"| Mengambil detail data peminjaman berdasarkan ID.

Referensi Smart Contract

- Remix IDE: https://remix.ethereum.org/
- Solidity Documentation: https://docs.soliditylang.org/
- Ethereum Developer Documentation: https://ethereum.org/en/developers/docs/

Informasi tambahan:

- Nama file Solidity: [ISI NAMA FILE .sol]
- Compiler Version: [ISI VERSI SOLIDITY]
- Contract Address: "0xb89Bff51dEB10C090C4F0154478AFd062195225D"

---

6. Integrasi Wallet

Aplikasi menggunakan Reown AppKit untuk mendukung koneksi wallet dan interaksi pengguna dengan jaringan blockchain.

Wallet digunakan untuk melakukan persetujuan transaksi ketika pengguna menambahkan data peminjaman atau mengembalikan alat.

Referensi

- Reown AppKit: https://docs.reown.com/appkit/flutter/core/installation
- Ethereum Wallet: https://ethereum.org/en/wallets/
- web3dart: https://pub.dev/packages/web3dart

Catatan keamanan:

Jangan pernah membagikan atau mengunggah private key, seed phrase, maupun informasi rahasia wallet ke repository GitHub.

---

7. Dependency dan Package

Dependency aplikasi dikelola menggunakan file "pubspec.yaml".

Beberapa package yang digunakan:

Package| Versi| Fungsi
"web3dart"| 3.0.3| Interaksi dengan Smart Contract Ethereum
"http"| ^1.6.0| Komunikasi HTTP dengan RPC
"intl"| ^0.20.3| Format tanggal dan angka
"reown_appkit"| ^1.9.0| Integrasi wallet
"wallet"| ^0.0.18| Dukungan fungsi wallet
"url_launcher"| ^6.3.3| Membuka URL eksternal
"cupertino_icons"| ^1.0.8| Ikon aplikasi
"material_ui"| ^1.1.0| Komponen UI

Untuk mengunduh dependency:

flutter pub get

Untuk melihat dependency:

flutter pub deps

Untuk memeriksa pembaruan package:

flutter pub outdated

---

8. Persyaratan Instalasi

Sebelum menjalankan aplikasi, pastikan perangkat pengembangan sudah memiliki:

- Flutter SDK
- Dart SDK
- Android Studio
- Android SDK
- Visual Studio Code
- Git
- Smartphone Android atau emulator
- Koneksi internet

Referensi Instalasi

Tools| Link
Flutter| https://docs.flutter.dev/get-started/install
Dart| https://dart.dev/get-dart
Android Studio| https://developer.android.com/studio
Visual Studio Code| https://code.visualstudio.com/
Git| https://git-scm.com/downloads

---

9. Cara Menjalankan Project

A. Clone Repository

git clone [LINK_REPOSITORY_GITHUB]

Masuk ke direktori project:

cd logbook5_iot

B. Install Dependencies

flutter pub get

C. Periksa Konfigurasi Flutter

flutter doctor

Pastikan Flutter SDK dan Android SDK sudah terpasang dengan benar.

D. Hubungkan Perangkat Android

Aktifkan USB Debugging pada smartphone Android.

Periksa perangkat yang terhubung:

flutter devices

E. Jalankan Aplikasi

flutter run

F. Build APK

Untuk membuat file APK:

flutter build apk --release

File APK dapat ditemukan pada:

build/app/outputs/flutter-apk/app-release.apk

---

10. Verifikasi Transaksi Blockchain

Transaksi yang dilakukan melalui aplikasi dapat diperiksa menggunakan Etherscan pada jaringan Ethereum Sepolia.

Link Smart Contract

https://sepolia.etherscan.io/address/0xb89Bff51dEB10C090C4F0154478AFd062195225D

Link Blockchain Explorer

- Ethereum Mainnet: https://etherscan.io/
- Ethereum Sepolia: https://sepolia.etherscan.io/

Untuk memeriksa transaksi, masukkan Transaction Hash yang diperoleh setelah transaksi dikirim melalui wallet.

Informasi yang dapat diperiksa meliputi:

- Transaction Hash.
- Status transaksi.
- Alamat pengirim.
- Alamat tujuan Smart Contract.
- Block Number.
- Gas Fee.
- Timestamp transaksi.

---

11. Troubleshooting

Error Dependencies

Jalankan:

flutter clean
flutter pub get

Error Gradle

Periksa konfigurasi Android Gradle Plugin, Kotlin, Gradle, dan Android SDK agar kompatibel dengan versi Flutter yang digunakan.

Kemudian jalankan:

flutter clean
flutter pub get
flutter run

Error Android SDK

Jalankan:

flutter doctor

Pastikan Android SDK dan Android SDK Command-line Tools sudah terpasang.

Error Koneksi Blockchain

Periksa kembali:

- Koneksi internet.
- RPC URL.
- Chain ID.
- Contract Address.
- File ABI.
- Jaringan wallet yang digunakan.

Error Wallet

Pastikan wallet sudah terhubung dan menggunakan jaringan Ethereum Sepolia Testnet.

Pastikan juga wallet memiliki Sepolia ETH untuk membayar biaya transaksi pada jaringan testnet.

---

12. Repository Project

Link GitHub:

[ISI LINK REPOSITORY GITHUB]

Repository ini berisi source code aplikasi Flutter, konfigurasi blockchain, file ABI Smart Contract, serta file pendukung lainnya.

---

13. Identitas Pengembang

Keterangan| Identitas
Nama Project| Logbook5 IoT
Nama Kelompok| [KELOMPOK 5]
Anggota 1| [Muhammad Ezra Fadillah]
Anggota 2| [Rasya Adzie Pratama]
Anggota 3| [Jawhariyatu Ummul Immama]
Anggota 4| [Deandy Jovadhan Diraja K]
Anggota 5| [Marvin Dimas Awang]
Mata Kuliah| [Pemrograman Mobile]
Dosen Pengampu| [Fara Triadi]

---

Logbook5 IoT – Aplikasi Flutter Terhubung Blockchain

Dikembangkan untuk memenuhi tugas proyek integrasi aplikasi mobile Flutter dengan teknologi Blockchain menggunakan Ethereum Smart Contract.
