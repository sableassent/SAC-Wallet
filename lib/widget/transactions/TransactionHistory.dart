import 'package:flutter/material.dart';
import 'package:sac_wallet/model/transaction.dart';
import 'package:sac_wallet/widget/transactions/TransactionList.dart';
class TransactionHistory extends StatelessWidget{
  final List<Transaction> transactions;
  TransactionHistory(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(10),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        )
      ),
      child: Column(
        children: <Widget>[
          TransactionList(transactions),
          SizedBox(height: 10,),
          Container(
            child: transactions.length >= 5 ? Text("View All", style: TextStyle(fontSize: 18, color: Colors.white),) : Text(""),
          )
        ],
      ),
    );
  }

}