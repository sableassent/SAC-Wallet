import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sac_wallet/model/transaction.dart';
import 'package:sac_wallet/screens/transaction_details.dart';
import 'package:sac_wallet/util/text_util.dart';
class TransactionList extends StatefulWidget{

  final List<Transaction> transactions;
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
    return Container(
        child: Column(
            children: transactions.map((transaction) =>
                Container(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => TransactionDetails(transaction))
                      );
                    },
                    child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 7),
                        child: ListTile(
                          leading: Image.asset("assets/images/app_icon.png", height: 50, width: 50,),
                          title: Text(TextUtil().formatAddressText(transaction.to),),
                          subtitle: Text(DateFormat('yyyy-MM-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(BigInt.parse(transaction.timeStamp).toInt()  * 1000)).toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.green),),
                          trailing: Text("\$ ${TextUtil().formatText(transaction.amount, 6)}", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 22),),
                        )
                    ),
                  ),
                ),
            ).toList()
        )
    );// end of container
  }

}