import 'package:flutter/material.dart';
import 'add_token_page.dart';
import 'buy_token_page.dart';
import 'send_token_page.dart';
import '../../model/user.dart';
import '../../model/transaction.dart';
import '../../util/global.dart';
import '../../blocs/wallet_bloc.dart';

WalletBloc walletBloc;

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  double screenWidth, screenHeight;

  TextEditingController searchCT;
  User currentUser = GlobalValue.getCurrentUser;

  @override
  void initState() {
    super.initState();
    walletBloc = new WalletBloc();
    walletBloc.getTransactionHistory(address: currentUser.eth_wallet_address);
    searchCT = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Name: ",
                      style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: currentUser.name,
                      style: TextStyle(color: Colors.black, fontSize: 15)
                    )
                  ]
                ),
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                  children: [
                    TextSpan(
                        text: "My Wallet: ",
                        style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                        text: currentUser.eth_wallet_address,
                        style: TextStyle(color: Colors.black, fontSize: 15)
                    )
                  ]
              ),
            ),
            SizedBox(height: 30),
            FutureBuilder(
              future: walletBloc.getCurrentBalance(address: currentUser.eth_wallet_address),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if(snapshot.hasError) print(snapshot.error);

                if(snapshot.hasData && snapshot.data != null){
                  return Container(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                                text: "My Sable Coins(SAC): ",
                                style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
                            ),
                            TextSpan(
                                text: snapshot.data,
                                style: TextStyle(color: Colors.black, fontSize: 15)
                            )
                          ]
                      ),
                    ),
                  );
                } else {
                  return Image.asset("assets/images/loading.gif", width: screenWidth, height: 50, fit: BoxFit.scaleDown);
                }
              }
            ),
//            SizedBox(height: 10),
//            Container(
//              alignment: Alignment.topLeft,
//              child: RichText(
//                text: TextSpan(
//                    children: [
//                      TextSpan(
//                          text: "My Ether(Eth): ",
//                          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
//                      ),
//                      TextSpan(
//                          text: "2.75",
//                          style: TextStyle(color: Colors.black, fontSize: 15)
//                      )
//                    ]
//                ),
//              ),
//            ),
//            SizedBox(height: 10),
//            Container(
//              alignment: Alignment.topLeft,
//              child: RichText(
//                text: TextSpan(
//                    children: [
//                      TextSpan(
//                          text: "My Bitcoin(BTC): ",
//                          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
//                      ),
//                      TextSpan(
//                          text: ".0257",
//                          style: TextStyle(color: Colors.black, fontSize: 15)
//                      )
//                    ]
//                ),
//              ),
//            ),
//            SizedBox(height: 10),
//            Container(
//              alignment: Alignment.topLeft,
//              child: RichText(
//                text: TextSpan(
//                    children: [
//                      TextSpan(
//                          text: "My Cash: ",
//                          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
//                      ),
//                      TextSpan(
//                          text: "\u00244,985",
//                          style: TextStyle(color: Colors.black, fontSize: 15)
//                      )
//                    ]
//                ),
//              ),
//            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => BuyTokenPage()));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue
                      ),
                      child: Center(
                        child: Text("Buy Tokens", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendTokenPage()));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.green
                      ),
                      child: Center(
                        child: Text("Send Tokens", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400])
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: searchCT,
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey, size: 25),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(5),
                        hintText: "Search Transaction History",
                      ),
                      onChanged: (value) {
                        walletBloc.getTransactionHistory(address: currentUser.eth_wallet_address, searchWord: value);
                      },
                    ),
                  ),
                  Divider(color: Colors.grey[400]),
                  StreamBuilder<List<Transaction>>(
                    stream: walletBloc.transactions,
                    builder: (context, AsyncSnapshot<List<Transaction>> snapshot) {

                      if(snapshot.hasError) print(snapshot.error);

                      if(snapshot.hasData && snapshot.data.length != 0){

                        List<Transaction> transactionList = snapshot.data;

                        return Container(
                          width: screenWidth,
                          height: screenHeight * 0.5,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: transactionList.length,
                              itemBuilder: (context, index) {

                                Transaction transaction = transactionList[index];
                                if(transaction != null){
                                  String from = transaction.from;
                                  String to = transaction.to;
                                  String amount = transaction.amount;
                                  String hash = transaction.hash;
                                  String timeStamp = transaction.timeStamp;
                                  DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp) * 1000);

                                  return Column(
                                    children: <Widget>[
                                      Container(
                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Text(from == currentUser.eth_wallet_address ? "User Sent $amount SAC to $to" : "User Received $amount SAC from $from", style: TextStyle(color: Colors.black, fontSize: 16)),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: "Hash: ",
                                                          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
                                                      ),
                                                      TextSpan(
                                                          text: hash,
                                                          style: TextStyle(color: Colors.grey, fontSize: 15)
                                                      )
                                                    ]
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "Time: ",
                                                        style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                                      ),
                                                      TextSpan(
                                                          text: "${date.year}-${date.month}-${date.day}",
                                                          style: TextStyle(color: Colors.grey, fontSize: 15)
                                                      )
                                                    ]
                                                ),
                                              )
                                            ],
                                          )
                                      ),
                                      Visibility(
                                          visible: index != transactionList.length - 1,
                                          child: Divider(color: Colors.grey[400])
                                      )
                                    ],
                                  );
                                } else {
                                  return null;
                                }
                              }
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
