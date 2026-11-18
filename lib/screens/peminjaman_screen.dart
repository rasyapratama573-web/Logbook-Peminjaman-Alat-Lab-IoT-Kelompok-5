
import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

import '../services/blockchain_service.dart';

class PeminjamanScreen extends StatefulWidget {
  final ReownAppKitModal appKitModal;

  const PeminjamanScreen({
    super.key,
    required this.appKitModal,
  });

  @override
  State<PeminjamanScreen> createState() =>
      _PeminjamanScreenState();
}

class _PeminjamanScreenState extends State<PeminjamanScreen> {
  final namaController = TextEditingController();
  final kodeController = TextEditingController();

  late final BlockchainService service;

  bool loading = false;

  @override
  void initState() {
    super.initState();

    service = BlockchainService(
      appKitModal: widget.appKitModal,
    );
  }

  Future<void> simpanPeminjaman() async {
    if (namaController.text.trim().isEmpty ||
        kodeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua kolom wajib diisi'),
        ),
      );
      return;
    }

    if (!widget.appKitModal.isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hubungkan MetaMask terlebih dahulu'),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final txHash = await service.tambahPeminjaman(
        namaAlat: namaController.text.trim(),
        kodeAlat: kodeController.text.trim(),
      );

      if (!mounted) return;

      namaController.clear();
      kodeController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Transaksi dikirim: $txHash',
          ),
          backgroundColor: const Color(0xFF167C52),
          duration: const Duration(seconds: 6),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan: $e'),
          backgroundColor: Colors.red.shade800,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  Widget inputLabel(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final connected = widget.appKitModal.isConnected;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          const Text(
            'Peminjaman Alat',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Catat peminjaman alat ke blockchain',
            style: TextStyle(
              color: Colors.white60,
            ),
          ),

          const SizedBox(height: 22),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF174B9B),
                  Color(0xFF102443),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.inventory_2_rounded,
                  color: Colors.lightBlueAccent,
                  size: 38,
                ),
                SizedBox(height: 15),
                Text(
                  'Form Peminjaman',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Masukkan informasi alat yang akan dipinjam. '
                  'Wallet yang terhubung akan tercatat '
                  'sebagai peminjam.',
                  style: TextStyle(
                    color: Colors.white70,
                    height: 1.5,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  inputLabel('Nama Alat'),

                  TextField(
                    controller: namaController,
                    decoration: const InputDecoration(
                      hintText: 'Contoh: Sensor DHT22',
                      prefixIcon: Icon(Icons.devices),
                    ),
                  ),

                  const SizedBox(height: 20),

                  inputLabel('Kode Alat'),

                  TextField(
                    controller: kodeController,
                    textCapitalization:
                        TextCapitalization.characters,
                    decoration: const InputDecoration(
                      hintText: 'Contoh: MHS002',
                      prefixIcon: Icon(Icons.qr_code_2),
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed:
                          loading ? null : simpanPeminjaman,
                      icon: loading
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.send_rounded),
                      label: Text(
                        loading
                            ? 'Menunggu transaksi...'
                            : 'Simpan Peminjaman',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: connected
                  ? const Color(0xFF103B32)
                  : const Color(0xFF42252B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: connected
                    ? Colors.greenAccent.withValues(alpha: 0.3)
                    : Colors.redAccent.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  connected
                      ? Icons.verified_user
                      : Icons.warning_amber_rounded,
                  color: connected
                      ? Colors.greenAccent
                      : Colors.orangeAccent,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    connected
                        ? 'Wallet MetaMask terhubung'
                        : 'Wallet belum terhubung. Hubungkan terlebih dahulu.',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          const Center(
            child: Text(
              'LOGBOOK IoT • ETHEREUM SEPOLIA',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    kodeController.dispose();
    service.dispose();
    super.dispose();
  }
}
