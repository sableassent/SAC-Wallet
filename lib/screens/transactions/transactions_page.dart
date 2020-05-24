import 'package:flutter/material.dart';
import 'package:sac_wallet/model/transaction.dart';
import 'package:sac_wallet/repository/wallet_repository.dart';
import 'package:sac_wallet/widget/transactions/TransactionHistory.dart';

class TransactionsPage extends StatefulWidget {
  TransactionsPage({Key key}) : super(key: key);

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
    static String tempWalletAddress = "0xf641e24c4084eb0ec8496d6b5a3b91d29dfcf66a"; // currentUser.eth_wallet_address <- replace with

  Future<List<Transaction>> transactions = WalletRepository().getTransactionHistory(address: tempWalletAddress, limit: 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Text("Transactions History", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
               child:  Column(
                 children: <Widget>[
                    SizedBox(height: 20,),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Transaction History", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),),
                    ),
                    SizedBox(height: 0,),
                    FutureBuilder<List<Transaction>>(
                       future: transactions,
                       builder:
                           (BuildContext context, AsyncSnapshot<List<Transaction>> snapshot) {
                         switch (snapshot.connectionState) {
                           case ConnectionState.none:
                             return Text(' none ');
                           case ConnectionState.active:
                           case ConnectionState.waiting:
                             return new Center(
                               child: new CircularProgressIndicator(),
                             );
                           case ConnectionState.done:
                             if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                             return Container(
                               padding: EdgeInsets.all(0),
                               child: Container(
                                   child: TransactionHistory(snapshot.data)),
                             );
                         }
                         return null;
                       }),
                 ],
               )
           ) ,
      )
    );
  }
}