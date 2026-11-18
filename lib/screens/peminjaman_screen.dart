import 'package:flutter/material.dart';

import '../services/blockchain_service.dart';
import '../main.dart';
import '../utils/etherscan.dart';

class PeminjamanScreen extends StatefulWidget {
  const PeminjamanScreen({super.key});

  @override
  State<PeminjamanScreen> createState() => _PeminjamanScreenState();
}

class _PeminjamanScreenState extends State<PeminjamanScreen> {
  final namaController = TextEditingController();
  final kodeController = TextEditingController();

  final service = BlockchainService();

  bool loading = false;

  Future<void> simpanPeminjaman() async {
    if (namaController.text.trim().isEmpty ||
        kodeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama dan kode alat wajib diisi'),
        ),
      );
      return;
    }

    setState(() => loading = true);

    try {
      final hash = await service.tambahPeminjaman(
        namaAlat: namaController.text.trim(),
        kodeAlat: kodeController.text.trim(),
      );

           if (!mounted) return;

      Etherscan.tampilkanSnackBar(context, hash);

      namaController.clear();
      kodeController.clear();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal: $e')),
      );
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    kodeController.dispose();
    super.dispose();
  }

  Widget _formCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.surfaceHigh, AppColors.surface],
        ),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.22)),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.06),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.gold, AppColors.goldDark],
                  ),
                ),
                child: const Icon(
                  Icons.assignment_add,
                  color: Color(0xFF1A1305),
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Text(
                  'Data Peminjaman Baru',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          TextField(
            controller: namaController,
            textInputAction: TextInputAction.next,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: const InputDecoration(
              labelText: 'Nama Alat',
              prefixIcon: Icon(
                Icons.precision_manufacturing_outlined,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: kodeController,
            textInputAction: TextInputAction.done,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: const InputDecoration(
              labelText: 'Kode Alat',
              prefixIcon: Icon(
                Icons.qr_code_2_rounded,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: loading ? null : simpanPeminjaman,
            icon: loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: AppColors.gold,
                    ),
                  )
                : const Icon(Icons.save_rounded),
            label: Text(
              loading ? 'Memproses...' : 'Simpan Peminjaman',
            ),
          ),
        ],
      ),
    );
  }

  Widget _noteCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.verified_user_outlined,
            color: AppColors.gold.withValues(alpha: 0.9),
            size: 22,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Data dicatat sebagai transaksi blockchain sehingga transparan dan tidak dapat diubah.',
              style: TextStyle(
                fontSize: 13,
                height: 1.45,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        children: [
          const Text(
            'Peminjaman Alat',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.6,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Catat peminjaman alat laboratorium ke blockchain.',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          _formCard(),
          const SizedBox(height: 16),
          _noteCard(),
        ],
      ),
    );
  }
}