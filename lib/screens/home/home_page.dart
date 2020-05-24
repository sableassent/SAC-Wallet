import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:sac_wallet/Constants/AppColor.dart';
import 'package:sac_wallet/model/transaction.dart';
import 'package:sac_wallet/model/user.dart';
import 'package:sac_wallet/screens/transactions/transactions_page.dart';
import 'package:sac_wallet/screens/wallet/buy_token_page.dart';
import 'package:sac_wallet/screens/wallet/send_token_page.dart';
import 'package:sac_wallet/util/global.dart';


class HomePage extends StatelessWidget{
  final Future<List<Transaction>> transactions;
  final Future<String> currentBalance;
  HomePage(this.transactions, this.currentBalance);
    User currentUser = GlobalValue.getCurrentUser;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
        child: new Stack(
          children: <Widget>[
            Container(
                child: Container(
                  decoration: new BoxDecoration(
                      gradient: LinearGradient(
                          colors: AppColor.PRIMARY_GRADIENT
                      ),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(28),
                        bottomLeft: Radius.circular(28),
                      )
                  ),
                  padding: EdgeInsets.all(20),
                  height: (MediaQuery.of(context).size.height / 2.7),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          currentUser.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 26
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        child: Text(
                          "Wallet Address",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0
                          ),  
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          child: Container(
                            height: 40.0,
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            child: Row(children: [
                            Text(currentUser.eth_wallet_address)
                          ],)
                          )
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        child: Text(
                          "Total Balance",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0
                          )
                        ),
                      ),
                      SizedBox(height: 10,),
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
                                      child: Text("${FlutterMoneyFormatter(amount: BigInt.parse(snapshot.data.substring(0,6)).toDouble()).output.symbolOnLeft}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),)),
                                );
                            }
                            return null;
                          }),
                      SizedBox(height: 25,)
                    ],
                  ),
                ),
            ),
           Container(
             margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height / 2.4) - 100 ),
               child:  Column(
                 children: <Widget>[
                    SizedBox(height: 20,),
                    SizedBox(height: 0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _sectionCard(context,"assets/images/buy_token.png", "Buy Token", BuyTokenPage()),
                        _sectionCard(context,"assets/images/sell_token.png", "Send Token", SendTokenPage()),
                    ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _sectionCard(context,"assets/images/transaction_history.png", "Transaction History", TransactionsPage()),
                        _sectionCard(context,"assets/images/buy_token.png", "Affiliate", SendTokenPage()),
                    ],)
                 ],
               )
           )

          ],
        ),
      ),
    );
  }

  Widget _sectionCard(BuildContext context,String imgPath, String title, widget) {
    return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
            },
            child: Container(
              width: 160,
              height: 160,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(imgPath, width: 60.0, ),
                    Text(
                       title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ) ,),
            )
          );
       }

}