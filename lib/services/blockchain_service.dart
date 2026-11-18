
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:wallet/wallet.dart' show EthereumAddress;

import '../config/blockchain_config.dart';
import '../models/peminjaman.dart';
import 'wallet_connect_service.dart';

class BlockchainService {
  Web3Client? _client;
  DeployedContract? _contract;

  Future<void> initialize() async {
    if (_contract != null) return;

    _client = Web3Client(
      BlockchainConfig.rpcUrl,
      http.Client(),
    );

    final abiString = await rootBundle.loadString(
      BlockchainConfig.abiPath,
    );

    final abi = jsonDecode(abiString);

    _contract = DeployedContract(
      ContractAbi.fromJson(
        jsonEncode(abi),
        'LogbookIoT',
      ),
      EthereumAddress.fromHex(
        BlockchainConfig.contractAddress,
      ),
    );
  }

  String _encode(List<int> bytes) {
    return '0x${bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}';
  }

  Future<String> tambahPeminjaman({
    required String namaAlat,
    required String kodeAlat,
  }) async {
    await initialize();

    final function = _contract!.function(
      'tambahPeminjaman',
    );

    final data = function.encodeCall([
      namaAlat,
      kodeAlat,
    ]);

    return WalletConnectService.instance.sendTransaction(
      contractAddress: BlockchainConfig.contractAddress,
      data: _encode(data),
    );
  }

  Future<String> kembalikanAlat(int id) async {
    await initialize();

    final function = _contract!.function(
      'kembalikanAlat',
    );

    final data = function.encodeCall([
      BigInt.from(id),
    ]);

    return WalletConnectService.instance.sendTransaction(
      contractAddress: BlockchainConfig.contractAddress,
      data: _encode(data),
    );
  }

  Future<BigInt> getJumlahPeminjaman() async {
    await initialize();

    final result = await _client!.call(
      contract: _contract!,
      function: _contract!.function('jumlahPeminjaman'),
      params: [],
    );

    return result.first as BigInt;
  }

  Future<Peminjaman> getPeminjaman(int id) async {
    await initialize();

    final result = await _client!.call(
      contract: _contract!,
      function: _contract!.function('ambilPeminjaman'),
      params: [BigInt.from(id)],
    );

    return Peminjaman.fromTuple(
      result.first as List<dynamic>,
    );
  }

  Future<List<Peminjaman>> ambilSemuaPeminjaman() async {
    final jumlah = await getJumlahPeminjaman();

    final List<Peminjaman> hasil = [];

    for (int i = 1; i <= jumlah.toInt(); i++) {
      hasil.add(await getPeminjaman(i));
    }

    return hasil.reversed.toList();
  }

  void dispose() {
    _client?.dispose();
    _client = null;
    _contract = null;
  }
}
