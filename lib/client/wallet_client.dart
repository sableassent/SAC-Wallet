import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../util/api_config.dart';
import '../util/text_util.dart';
import '../model/transaction.dart';

class WalletClient {

  Future<Map<String, dynamic>> createWallet() async {
    var response = await http.post(ApiConfig.API_CREATE_WALLET);
    return jsonDecode(response.body);
  }

  Future<String> getCurrentBalance({@required String address}) async {
    Map body = {
      TextUtil.ADDRESS : address
    };
    var response = await http.post(ApiConfig.API_ETH_BALANCE, headers: {
      HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
    }, body: body);

    var result = jsonDecode(response.body);
    print("Result balnce: $result");
    if(result[TextUtil.STATUS]){
      print("Balance - ${result[TextUtil.BALANCE]}");
      return result[TextUtil.BALANCE];
    } else {
      return null;
    }
  }

  Future<bool> sendToken({@required String myAddress, @required String toAddress, @required String privateKey, @required String amount}) async {
    Map body = {
      TextUtil.MY_ADDRESS: myAddress,
      TextUtil.TO_ADDRESS: toAddress,
      TextUtil.AMOUNT: amount,
      TextUtil.PRIVATE_BODY_KEY: privateKey
    };

    var response = await http.post(ApiConfig.API_SEND_TOKEN, headers: {
      HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
    }, body: body);

    var result = jsonDecode(response.body);
    return result[TextUtil.STATUS];
  }

  Future<bool> checkAddress({@required String address}) async {
    Map body = {
      TextUtil.ADDRESS: address
    };

    var response = await http.post(ApiConfig.API_CHECK_ADDRESS, headers: {
      HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
    }, body: body);

    var result = jsonDecode(response.body);
    if(result[TextUtil.STATUS] && result[TextUtil.MESSAGE] == "valid"){
      return true;
    } else {
      return false;
    }
  }

  Future<List<Transaction>> getTransactionHistorySeeder() async{
    List<Transaction> transactions = new List();
    transactions.add(Transaction.name("Ricardo Gaynor", "James Spark", "3,000", "#######", "2019-09-12"));
    transactions.add(Transaction.name("Guillermo Perry", "Kerion Willis", "29", "#######", "2019-34-12"));
    transactions.add(Transaction.name("Daryl Speaks", "Nicholas Graham", "45", "#######", "2020-12-09"));
    transactions.add(Transaction.name("Marlena Daley", "Guillermo Perry", "9,000", "#######", "2019-09-09"));
    transactions.add(Transaction.name("James Spark", "Kerion Willis", "2,383", "#######", "2019-12-08"));
    transactions.add(Transaction.name("Nicholas Graham", "Daryl Speaks", "1,233", "#######", "2020-09-07"));
    return transactions;
  }

  Future<List<Transaction>> getTransactionHistory({@required String address, String searchWord}) async {
    //return getTransactionHistorySeeder();
    String api_url = "${ApiConfig.API_GET_TRANSACTION_HISTORY}?module=account&action=tokentx&address=$address&startblock=0&endblock=999999999&sort=asc&apikey=DX4SADSQBSAYA6VI8NFUYE878QWNYMG181";
    var response = await http.get(api_url);
    var result = jsonDecode(response.body);

    if(result[TextUtil.STATUS] == "1"){
      print(result["result"]);
      List<Transaction> transactions;
      List<dynamic> histories = result["result"];
      print("Transation hisory: ${histories.toString()}");
      transactions = histories.map((item) {
        if(searchWord != null && searchWord.isNotEmpty){
          if(item["from"].toString().contains(searchWord) || item["to"].toString().contains(searchWord) || item["value"].toString().contains(searchWord) || item["hash"].toString().contains(searchWord)){
            return Transaction.fromJSON(item);
          } else {
            return null;
          }
        } else {
          return Transaction.fromJSON(item);
        }
      }).toList();
      return transactions;
    } else {
      return new List();
    }
  }

}