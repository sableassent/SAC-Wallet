import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../blocs/wallet_bloc.dart';
import '../../widget/loading.dart';
import '../../model/user.dart';
import '../../util/global.dart';

WalletBloc walletBloc;

class BuyTokenPage extends StatefulWidget {
  @override
  _BuyTokenPageState createState() => _BuyTokenPageState();
}

class _BuyTokenPageState extends State<BuyTokenPage> {

  double screenWidth, screenHeight;
  User currentUser = GlobalValue.getCurrentUser;
  TextEditingController unitCT;
  bool isApprovedTransaction = false;
  bool isLoading = false;

  List<String> tokenOptions = <String>["Sable Coin(SAC)", "Bitcoin(BTC)", "Ether(ETH)"];
  int tokenIndex = 0;

  buyToken() async {
    String tokenName = tokenOptions[tokenIndex];
    String purchaseUnit = unitCT.text;

    if(purchaseUnit.isEmpty){
      Toast.show("Enter unit for purchase", context);
      return;
    }

    if(!isApprovedTransaction){
      Toast.show("Confirm approval of this transaction!", context);
      return;
    }

    setState(() {
      isLoading = true;
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    walletBloc = new WalletBloc();
    unitCT = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Text("Buy Tokens", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 40),
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
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: screenWidth,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[300])
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Select Token:", style: TextStyle(color: Colors.black, fontSize: 15)),
                        Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              items: tokenOptions.map((value){
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: TextStyle(color: Colors.black, fontSize: 15), overflow: TextOverflow.ellipsis, maxLines: 3),
                                );
                              }).toList(),
                              value: tokenOptions[tokenIndex],
                              onChanged: (newValue) {
                                setState(() {
                                  tokenIndex = tokenOptions.indexOf(newValue);
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: screenWidth,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[300])
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Units to purchase:", style: TextStyle(color: Colors.black87, fontSize: 15)),
                        Container(
                          width: screenWidth * 0.5,
                          padding: EdgeInsets.only(top: 10),
                          child: TextField(
                            controller: unitCT,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "1000",
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: screenWidth,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[300])
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("I approve this transaction.", style: TextStyle(color: Colors.black87, fontSize: 15)),
                        Switch(
                          value: isApprovedTransaction,
                          onChanged: (value) {
                            setState(() {
                              isApprovedTransaction = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  InkWell(
                    onTap: () {
                      buyToken();
                    },
                    child: Container(
                      width: screenWidth,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text("BUY NOW", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          LoadingScreen(
            inAsyncCall: isLoading,
            dismissible: false,
            mesage: "Buying token...",
          )
        ],
      ),
    );
  }
}
