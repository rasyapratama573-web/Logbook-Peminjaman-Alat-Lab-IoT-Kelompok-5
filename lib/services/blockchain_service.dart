
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:wallet/wallet.dart' show EthereumAddress;
import 'package:reown_appkit/reown_appkit.dart';

import '../config/blockchain_config.dart';
import '../models/peminjaman.dart';

class BlockchainService {
  final ReownAppKitModal? appKitModal;

  late final Web3Client _client;
  late DeployedContract _contract;

  bool _initialized = false;

  BlockchainService({
    this.appKitModal,
  }) {
    _client = Web3Client(
      BlockchainConfig.rpcUrl,
      http.Client(),
    );
  }

  // ==================================
  // INISIALISASI SMART CONTRACT
  // ==================================

  Future<void> initialize() async {
    if (_initialized) return;

    final abiJson = await rootBundle.loadString(
      BlockchainConfig.abiPath,
    );

    final abi = ContractAbi.fromJson(
      abiJson,
      'LogbookIoT',
    );

    _contract = DeployedContract(
      abi,
      EthereumAddress.fromHex(
        BlockchainConfig.contractAddress.trim(),
      ),
    );

    _initialized = true;
  }

  // ==================================
  // MENGAMBIL ALAMAT WALLET
  // ==================================

  String getWalletAddress() {
    final modal = appKitModal;

    if (modal == null || !modal.isConnected) {
      throw Exception(
        'Silakan Connect Wallet MetaMask terlebih dahulu',
      );
    }

    final session = modal.session;

    if (session == null) {
      throw Exception('Session wallet tidak ditemukan');
    }

    final address = session.getAddress('eip155');

    if (address == null || address.isEmpty) {
      throw Exception('Alamat wallet tidak ditemukan');
    }

    return address;
  }

  // ==================================
  // JUMLAH PEMINJAMAN
  // ==================================

  Future<int> jumlahPeminjaman() async {
    await initialize();

    final function = _contract.function(
      'jumlahPeminjaman',
    );

    final result = await _client.call(
      contract: _contract,
      function: function,
      params: [],
    );

    return (result[0] as BigInt).toInt();
  }

  // ==================================
  // DETAIL PEMINJAMAN
  // ==================================

  Future<Peminjaman> ambilPeminjaman(int id) async {
    await initialize();

    final function = _contract.function(
      'ambilPeminjaman',
    );

    final result = await _client.call(
      contract: _contract,
      function: function,
      params: [
        BigInt.from(id),
      ],
    );

    return Peminjaman.fromTuple(
      result[0] as List<dynamic>,
    );
  }

  // ==================================
  // SEMUA DATA PEMINJAMAN
  // ==================================

  Future<List<Peminjaman>> ambilSemuaPeminjaman() async {
    final jumlah = await jumlahPeminjaman();

    final List<Peminjaman> daftar = [];

    for (int id = 1; id <= jumlah; id++) {
      final data = await ambilPeminjaman(id);
      daftar.add(data);
    }

    return daftar;
  }

  Future<List<Peminjaman>> semuaPeminjaman() {
    return ambilSemuaPeminjaman();
  }

  // ==================================
  // TAMBAH PEMINJAMAN
  // ==================================

  Future<String> tambahPeminjaman({
    required String namaAlat,
    required String kodeAlat,
  }) async {
    await initialize();

    final modal = appKitModal;

    if (modal == null || !modal.isConnected) {
      throw Exception('Wallet belum terhubung');
    }

    final address = getWalletAddress();
    final session = modal.session!;

    final function = _contract.function(
      'tambahPeminjaman',
    );

    final parameters = [
      namaAlat,
      kodeAlat,
    ];

    final transaction = Transaction.callContract(
      contract: _contract,
      function: function,
      parameters: parameters,
      from: EthereumAddress.fromHex(address),
    );

    final result = await modal.requestWriteContract(
      topic: session.topic,
      chainId: session.chainId,
      deployedContract: _contract,
      functionName: 'tambahPeminjaman',
      transaction: transaction,
      parameters: parameters,
    );

    return result.toString();
  }

  // ==================================
  // KEMBALIKAN ALAT
  // ==================================

  Future<String> kembalikanAlat(int id) async {
    await initialize();

    final modal = appKitModal;

    if (modal == null || !modal.isConnected) {
      throw Exception('Wallet belum terhubung');
    }

    final address = getWalletAddress();
    final session = modal.session!;

    final function = _contract.function(
      'kembalikanAlat',
    );

    final parameters = [
      BigInt.from(id),
    ];

    final transaction = Transaction.callContract(
      contract: _contract,
      function: function,
      parameters: parameters,
      from: EthereumAddress.fromHex(address),
    );

    final result = await modal.requestWriteContract(
      topic: session.topic,
      chainId: session.chainId,
      deployedContract: _contract,
      functionName: 'kembalikanAlat',
      transaction: transaction,
      parameters: parameters,
    );

    return result.toString();
  }

  // ==================================
  // DISPOSE
  // ==================================

  void dispose() {
    _client.dispose();
  }
}
