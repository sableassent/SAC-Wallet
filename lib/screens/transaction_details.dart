import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:sac_wallet/Constants/AppColor.dart';
import 'package:sac_wallet/model/transaction.dart';
class TransactionDetails extends StatelessWidget{

  final Transaction transaction;
  TransactionDetails(this.transaction);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xfff0f0f0),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.height / 4),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.BLUE_START,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context, null);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Transaction Details",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.filter_list,
                            color: AppColor.BLUE_START,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 110,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text("Amount", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                trailing: Text("${FlutterMoneyFormatter(amount: BigInt.parse(transaction.amount).toDouble()).output.symbolOnLeft}"),
                              ),
                              ListTile(
                                title: Text("From", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                trailing: Text(transaction.from),
                              ),
                              ListTile(
                                title: Text("To", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                trailing: Text(transaction.to),
                              ),
                              ListTile(
                                title: Text("Date", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                trailing: Text(DateFormat('yyyy-MM-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(BigInt.parse(transaction.timeStamp).toInt()  * 1000)).toString()),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}