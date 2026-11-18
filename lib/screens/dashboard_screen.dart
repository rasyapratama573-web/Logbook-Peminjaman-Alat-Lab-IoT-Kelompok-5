
import 'package:flutter/material.dart';

import '../models/peminjaman.dart';
import '../services/blockchain_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final BlockchainService service = BlockchainService();

  List<Peminjaman> data = [];
  bool loading = true;
  String? error;

  int get total => data.length;

  int get dipinjam =>
      data.where((e) => !e.dikembalikan).length;

  int get dikembalikan =>
      data.where((e) => e.dikembalikan).length;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final result = await service.ambilSemuaPeminjaman();

      if (!mounted) return;

      setState(() {
        data = result;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  Widget statCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 23,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              value,
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: loadData,
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const SizedBox(height: 8),

          const Text(
            'Overview',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Monitoring peminjaman alat berbasis blockchain',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 22),

          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF174B9B),
                  Color(0xFF102443),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFF367DDB),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.account_tree_rounded,
                      color: Colors.lightBlueAccent,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'BLOCKCHAIN LOGBOOK',
                      style: TextStyle(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                const Text(
                  'Total Peminjaman',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  loading ? '...' : '$total',
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Data tercatat pada jaringan Ethereum',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          const Text(
            'Statistik Peminjaman',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 10),

          if (loading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: CircularProgressIndicator(),
              ),
            )
          else if (error != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.redAccent,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    const Text('Gagal memuat blockchain'),
                    const SizedBox(height: 8),
                    Text(
                      error!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 11),
                    ),
                    TextButton(
                      onPressed: loadData,
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            )
          else
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.25,
              children: [
                statCard(
                  'Total Peminjaman',
                  '$total',
                  Icons.inventory_2_outlined,
                  Colors.blueAccent,
                ),
                statCard(
                  'Sedang Dipinjam',
                  '$dipinjam',
                  Icons.schedule,
                  Colors.orangeAccent,
                ),
                statCard(
                  'Dikembalikan',
                  '$dikembalikan',
                  Icons.check_circle_outline,
                  Colors.greenAccent,
                ),
                statCard(
                  'Status Jaringan',
                  'Sepolia',
                  Icons.hub_outlined,
                  Colors.cyanAccent,
                ),
              ],
            ),

          const SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Aktivitas Terbaru',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: loading ? null : loadData,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),

          if (!loading && error == null && data.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    'Belum ada aktivitas peminjaman',
                    style: TextStyle(color: Colors.white60),
                  ),
                ),
              ),
            ),

          if (!loading && error == null)
            ...data.reversed.take(5).map((item) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF1C3559),
                    child: Icon(
                      Icons.devices,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  title: Text(
                    item.namaAlat,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Kode: ${item.kodeAlat} • ID: ${item.id}',
                  ),
                  trailing: Icon(
                    item.dikembalikan
                        ? Icons.check_circle
                        : Icons.access_time,
                    color: item.dikembalikan
                        ? Colors.greenAccent
                        : Colors.orangeAccent,
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    service.dispose();
    super.dispose();
  }
}
