import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

class WalletConnectService {
  WalletConnectService._();

  static final WalletConnectService instance = WalletConnectService._();

  static const String projectId = '2338b4bd006b79a948587b4e251e6baf';

  static const String chainIdNumber = '11155111';
  static const String chainId = 'eip155:$chainIdNumber'; // untuk rpcRequest

  static final ReownAppKitModalNetworkInfo sepolia =
      ReownAppKitModalNetworkInfo(
    name: 'Sepolia',
    chainId: chainIdNumber,
    currency: 'SepoliaETH',
    rpcUrl: 'https://ethereum-sepolia-rpc.publicnode.com',
    explorerUrl: 'https://sepolia.etherscan.io',
    isTestNetwork: true,
  );

  ReownAppKitModal? _modal;

  bool get isConnected => _modal?.isConnected ?? false;

  List<String> get _accounts {
    final session = _modal?.session;
    if (session == null) return <String>[];
    return session.getAccounts() ?? <String>[];
  }

  // Alamat akun khusus Sepolia (format sesi: eip155:11155111:0xabc...)
  String? get _sepoliaAddress {
    for (final acc in _accounts) {
      if (acc.startsWith('$chainId:')) {
        return acc.split(':').last;
      }
    }
    return null;
  }

  String? get walletAddress {
    final modal = _modal;

    if (modal == null || !modal.isConnected) {
      return null;
    }

    final sepoliaAddr = _sepoliaAddress;
    if (sepoliaAddr != null) return sepoliaAddr;

    if (_accounts.isNotEmpty) {
      return _accounts.first.split(':').last;
    }

    return modal.session?.getAddress('eip155');
  }

  Future<void> initialize(BuildContext context) async {
    if (_modal != null) return;

    // Hanya Sepolia yang didukung
    ReownAppKitModalNetworks.removeSupportedNetworks('eip155');
    ReownAppKitModalNetworks.addSupportedNetworks('eip155', [sepolia]);

    final modal = ReownAppKitModal(
      context: context,
      projectId: projectId,
      metadata: const PairingMetadata(
        name: 'Logbook IoT',
        description: 'Sistem Peminjaman Alat Laboratorium',
        url: 'https://example.com',
        icons: [],
      ),
    );

    await modal.init();

    // Pilih Sepolia setiap kali wallet berhasil terhubung
    modal.onModalConnect.subscribe((_) async {
      try {
        await modal.selectChain(sepolia);
      } catch (_) {}
    });

    try {
      await modal.selectChain(sepolia);
    } catch (_) {}

    _modal = modal;
  }

  Future<void> connect(BuildContext context) async {
    await initialize(context);
    await _modal!.openModalView();
  }

  Future<void> disconnect() async {
    if (_modal != null) {
      await _modal!.disconnect();
    }
  }

  Future<String> sendTransaction({
    required String contractAddress,
    required String data,
  }) async {
    final modal = _modal;

    if (modal == null || !modal.isConnected) {
      throw Exception(
        'Wallet belum terhubung. Hubungkan wallet terlebih dahulu.',
      );
    }

    // Coba pilih Sepolia (kalau gagal, tidak masalah)
    try {
      await modal.selectChain(sepolia);
    } catch (_) {}

    // Pastikan sesi wallet memang punya akun untuk Sepolia
    final address = _sepoliaAddress;

    if (address == null || address.isEmpty) {
      throw Exception(
        'Wallet belum memberi akses ke Sepolia. '
        'Pilih jaringan Sepolia di wallet, hapus sesi Logbook IoT '
        'di wallet, lalu hubungkan ulang.',
      );
    }

    try {
      // Buka aplikasi wallet supaya user bisa menyetujui transaksi
      try {
        modal.launchConnectedWallet();
      } catch (_) {}

      final response = await modal.request(
        topic: modal.session!.topic,
        chainId: chainId,
        request: SessionRequestParams(
          method: 'eth_sendTransaction',
          params: [
            {
              'from': address,
              'to': contractAddress,
              'data': data,
              'value': '0x0',
            }
          ],
        ),
      );

      if (response == null) {
        throw Exception('Hash transaksi tidak ditemukan.');
      }

      return response.toString();
    } catch (e) {
      throw Exception('Transaksi blockchain gagal: $e');
    }
  }
}