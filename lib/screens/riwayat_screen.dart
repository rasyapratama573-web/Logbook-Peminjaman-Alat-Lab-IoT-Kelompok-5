import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/peminjaman.dart';
import '../services/blockchain_service.dart';
import '../utils/etherscan.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  final service = BlockchainService();

  List<Peminjaman> data = [];
  bool loading = true;
  int? prosesId; // id yang sedang dikembalikan

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  Future<void> refreshData() async {
    setState(() => loading = true);

    try {
      final hasil = await service.ambilSemuaPeminjaman();

      if (!mounted) return;

      setState(() {
        data = hasil;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil data: $e')),
      );
    }
  }

  Future<void> kembalikan(int id) async {
    setState(() => prosesId = id);

    try {
       final hash = await service.kembalikanAlat(id);

      if (!mounted) return;

      Etherscan.tampilkanSnackBar(context, hash);

      // beri waktu transaksi masuk blok, lalu muat ulang
      await Future.delayed(const Duration(seconds: 5));

      // beri waktu transaksi masuk blok, lalu muat ulang
      await Future.delayed(const Duration(seconds: 5));
      if (!mounted) return;
      await refreshData();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal: $e')),
      );
    } finally {
      if (mounted) setState(() => prosesId = null);
    }
  }

  String tanggal(DateTime value) =>
      DateFormat('dd-MM-yyyy HH:mm').format(value);

  Widget _kartu(Peminjaman item) {
    final sudahKembali = item.dikembalikan;
    final sedangProses = prosesId == item.id;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.namaAlat,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Chip(
                  label: Text(
                    sudahKembali ? 'Kembali' : 'Dipinjam',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'ID: ${item.id}\n'
              'Kode: ${item.kodeAlat}\n'
              'Peminjam: ${item.peminjam}\n'
              'Tanggal pinjam: ${tanggal(item.tanggalPinjam)}'
              '${item.tanggalKembali != null ? '\nTanggal kembali: ${tanggal(item.tanggalKembali!)}' : ''}',
              style: const TextStyle(height: 1.5),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: (sudahKembali || sedangProses)
                    ? null
                    : () => kembalikan(item.id),
                icon: sedangProses
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2.4),
                      )
                    : const Icon(Icons.assignment_return),
                label: Text(
                  sedangProses
                      ? 'Memproses...'
                      : sudahKembali
                          ? 'Sudah dikembalikan'
                          : 'Kembalikan',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Peminjaman'),
        actions: [
          IconButton(
            onPressed: loading ? null : refreshData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: refreshData,
              child: data.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 120),
                        Center(child: Text('Belum ada peminjaman')),
                      ],
                    )
                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      itemCount: data.length,
                      itemBuilder: (context, index) => _kartu(data[index]),
                    ),
            ),
    );
  }
}