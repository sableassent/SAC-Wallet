import 'dart:async';
import 'package:meta/meta.dart';
import '../client/wallet_client.dart';
import '../model/transaction.dart';

class WalletRepository {
  final WalletClient walletClient = new WalletClient();

  Future<String> getCurrentBalance({@required String address}) async => await walletClient.getCurrentBalance(address: address);

  Future<bool> sendToken({@required String myAddress, @required String toAddress, @required String privateKey, @required String amount}) async => await walletClient.sendToken(myAddress: myAddress, toAddress: toAddress, privateKey: privateKey, amount: amount);

  Future<bool> checkAddress({@required String address}) async => await walletClient.checkAddress(address: address);

  Future<List<Transaction>> getTransactionHistory({@required String address, int limit, String searchWord}) async => await walletClient.getTransactionHistory(address: address, searchWord: searchWord);
}