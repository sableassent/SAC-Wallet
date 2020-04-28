import 'package:flutter/material.dart';
import 'package:sac_wallet/model/transaction.dart';
class TransactionList extends StatefulWidget{

  List<Transaction> transactions;
  TransactionList(this.transactions);

  @override
  State<StatefulWidget> createState() => _TransactionList();
}

class _TransactionList extends State<TransactionList>{
  List<Transaction> transactions;

  @override
  void initState() {
    super.initState();
    transactions = widget.transactions;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Column(
            children: transactions.map((transaction) =>
                Container(
                  child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(7.0),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(transaction.to, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                Text("\$ ${transaction.amount}", style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 22),),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(transaction.timeStamp, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.green),),
                              ],
                            )
                          ],
                        ),
                      )
                  ),
                ),
            ).toList()
        )
    );// end of container
  }

}