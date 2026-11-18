import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Etherscan {
  // Ganti sesuai jaringan kontrakmu:
  // Sepolia : https://sepolia.etherscan.io
  // Mainnet : https://etherscan.io
  static const String baseUrl = 'https://sepolia.etherscan.io';

  static Uri txUri(String hash) => Uri.parse('$baseUrl/tx/$hash');

  static Future<void> bukaTransaksi(String hash) async {
    await launchUrl(txUri(hash), mode: LaunchMode.externalApplication);
  }

  /// Snackbar berisi hash singkat dan tombol "Lihat" ke Etherscan.
  static void tampilkanSnackBar(BuildContext context, String hash) {
    final singkat = hash.length > 14
        ? '${hash.substring(0, 8)}...${hash.substring(hash.length - 6)}'
        : hash;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 10),
        content: Text('Transaksi dikirim: $singkat'),
        action: SnackBarAction(
          label: 'Lihat',
          onPressed: () => bukaTransaksi(hash),
        ),
      ),
    );
  }
}