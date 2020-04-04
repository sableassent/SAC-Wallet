import 'dart:async';
import 'package:meta/meta.dart';
import '../model/transaction.dart';
import '../repository/wallet_repository.dart';

class WalletBloc {
  final WalletRepository walletRepository = new WalletRepository();

  StreamController<List<Transaction>> _transactionController = new StreamController<List<Transaction>>.broadcast();
  Stream<List<Transaction>> get transactions => _transactionController.stream;

  Future<String> getCurrentBalance({@required String address}) async => await walletRepository.getCurrentBalance(address: address);

  Future<bool> sendToken({@required String myAddress, @required String toAddress, @required String privateKey, @required String amount}) async => await walletRepository.sendToken(myAddress: myAddress, toAddress: toAddress, privateKey: privateKey, amount: amount);

  Future<bool> checkAddress({@required String address}) async => await walletRepository.checkAddress(address: address);

  getTransactionHistory({@required String address, String searchWord}) async {
    _transactionController.sink.add(await walletRepository.getTransactionHistory(address: address, searchWord: searchWord));
  }

  dispose() {
    _transactionController.close();
  }
}