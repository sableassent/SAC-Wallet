import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:sac_wallet/Constants/AppColor.dart';
import 'package:sac_wallet/model/transaction.dart';
import 'package:sac_wallet/widget/transactions/TransactionHistory.dart';
class HomePage extends StatelessWidget{
  final Future<List<Transaction>> transactions;
  final Future<String> currentBalance;
  HomePage(this.transactions, this.currentBalance);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/home_background.jpg"),
            fit: BoxFit.cover
          )
        ),
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  gradient: LinearGradient(
                      colors: AppColor.PRIMARY_GRADIENT
                  ),
                // borderRadius: BorderRadius.only(
                //   bottomRight: Radius.circular(20),
                //   bottomLeft: Radius.circular(20),
                // )
              ),
              padding: EdgeInsets.all(20),
              height: (MediaQuery.of(context).size.height / 3.5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FutureBuilder<String>(
                      future: currentBalance,
                      builder:
                          (BuildContext context, AsyncSnapshot<String> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text(' - ');
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return new Center(
                              child: new Text("...."),
                            );
                          case ConnectionState.done:
                            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                            return Container(
                              padding: EdgeInsets.all(0),
                              child: Container(
                                  child: Text("${FlutterMoneyFormatter(amount: BigInt.parse(snapshot.data.substring(0,6)).toDouble()).output.symbolOnLeft}", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),)),
                            );
                        }
                        return null;
                      }),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20),
              child: Text("Transaction History", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
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
        ),
      ),
    );
  }

}