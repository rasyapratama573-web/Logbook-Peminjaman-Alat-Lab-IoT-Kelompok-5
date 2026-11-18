
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reown_appkit/reown_appkit.dart';

import '../models/peminjaman.dart';
import '../services/blockchain_service.dart';

class RiwayatScreen extends StatefulWidget {
  final ReownAppKitModal appKitModal;

  const RiwayatScreen({
    super.key,
    required this.appKitModal,
  });

  @override
  State<RiwayatScreen> createState() =>
      _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  late final BlockchainService service;

  List<Peminjaman> data = [];

  bool loading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();

    service = BlockchainService(
      appKitModal: widget.appKitModal,
    );

    refreshData();
  }

  // AMBIL DATA BLOCKCHAIN
  Future<void> refreshData() async {
    if (!mounted) return;

    setState(() {
      loading = true;
      errorMessage = null;
    });

    try {
      final hasil = await service.ambilSemuaPeminjaman();

      if (!mounted) return;

      setState(() {
        data = hasil;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
        errorMessage = e.toString();
      });
    }
  }

  // PENGEMBALIAN ALAT
  Future<void> kembalikan(int id) async {
    if (!widget.appKitModal.isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Hubungkan MetaMask terlebih dahulu',
          ),
        ),
      );
      return;
    }

    try {
      final txHash = await service.kembalikanAlat(id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Transaksi pengembalian dikirim: $txHash',
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 6),
        ),
      );

      await refreshData();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal mengembalikan alat: $e',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // FORMAT TANGGAL
  String formatTanggal(DateTime tanggal) {
    return DateFormat(
      'dd-MM-yyyy HH:mm',
    ).format(tanggal);
  }

  // TAMPILAN
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

      body: RefreshIndicator(
        onRefresh: refreshData,
        child: loading
            ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 250),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              )
            : errorMessage != null
                ? ListView(
                    physics:
                        const AlwaysScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: 120),
                      const Icon(
                        Icons.error_outline,
                        size: 50,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 12),
                      const Center(
                        child: Text(
                          'Gagal mengambil data blockchain',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          errorMessage!,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: FilledButton(
                          onPressed: refreshData,
                          child: const Text('Coba Lagi'),
                        ),
                      ),
                    ],
                  )
                : data.isEmpty
                    ? ListView(
                        physics:
                            const AlwaysScrollableScrollPhysics(),
                        children: const [
                          SizedBox(height: 150),
                          Icon(
                            Icons.inventory_2_outlined,
                            size: 55,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 15),
                          Center(
                            child: Text(
                              'Belum ada data peminjaman',
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        physics:
                            const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index];

                          return Card(
                            color: Colors.white,
                            margin: const EdgeInsets.only(
                              bottom: 12,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.devices,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          item.namaAlat,
                                          style: const TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                      Chip(
                                        label: Text(
                                          item.dikembalikan
                                              ? 'Dikembalikan'
                                              : 'Dipinjam',
                                        ),
                                        backgroundColor:
                                            item.dikembalikan
                                                ? Colors.green.shade100
                                                : Colors.orange.shade100,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  Text('ID: ${item.id}'),

                                  Text(
                                    'Kode alat: ${item.kodeAlat}',
                                  ),

                                  Text(
                                    'Peminjam: ${item.peminjam}',
                                  ),

                                  Text(
                                    'Tanggal pinjam: '
                                    '${formatTanggal(item.tanggalPinjam)}',
                                  ),

                                  if (item.tanggalKembali != null)
                                    Text(
                                      'Tanggal kembali: '
                                      '${formatTanggal(item.tanggalKembali!)}',
                                    ),

                                  const SizedBox(height: 12),

                                  if (!item.dikembalikan)
                                    SizedBox(
                                      width: double.infinity,
                                      child: FilledButton.icon(
                                        onPressed: () =>
                                            kembalikan(item.id),
                                        icon: const Icon(
                                          Icons.assignment_return,
                                        ),
                                        label: const Text(
                                          'Kembalikan Alat',
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
      ),
    );
  }

  @override
  void dispose() {
    service.dispose();
    super.dispose();
  }
}
