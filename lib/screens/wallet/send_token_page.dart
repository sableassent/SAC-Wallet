import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../blocs/wallet_bloc.dart';
import '../../widget/loading.dart';
import '../../model/user.dart';
import '../../util/global.dart';

WalletBloc walletBloc;

class SendTokenPage extends StatefulWidget {
  @override
  _SendTokenPageState createState() => _SendTokenPageState();
}

class _SendTokenPageState extends State<SendTokenPage> {

  double screenWidth, screenHeight;
  User currentUser = GlobalValue.getCurrentUser;
  TextEditingController toAddressCT, amountCT;
  bool isCertified = false;
  bool isLoading = false;

  List<String> tokenOptions = <String>["Sable Coin(SAC)", "Bitcoin(BTC)", "Ether(ETH)", "Send Cash"];
  int tokenIndex = 0;

  sendToken() async {
//    String tokenName = tokenOptions[tokenIndex];
    String toAddress = toAddressCT.text;
    String amount = amountCT.text;

    if(toAddress.isEmpty){
      Toast.show("Enter an address of receiver", context);
      return;
    }

    if(amount.isEmpty){
      Toast.show("Enter amount of cost", context);
      return;
    }

    if(!isCertified){
      Toast.show("Confirm approval of this transaction!", context);
      return;
    }

    setState(() {
      isLoading = true;
    });

    bool isValidAddress = await walletBloc.checkAddress(address: toAddress);
    if(isValidAddress){
      bool isSuccess = await walletBloc.sendToken(myAddress: currentUser.eth_wallet_address, toAddress: toAddress, privateKey: GlobalValue.getPrivateKey, amount: amount);
      if(isSuccess){
        setState(() {
          isLoading = false;
        });
        Toast.show("Success!", context);
      } else {
        setState(() {
          isLoading = false;
        });
        Toast.show("Failed!", context);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      Toast.show("Receiver address is invalid. Enter a valid address!", context);
    }
  }

  @override
  void initState() {
    super.initState();
    walletBloc = new WalletBloc();
    toAddressCT = new TextEditingController();
    amountCT = new TextEditingController();
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
        title: Text("Send Tokens", style: TextStyle(color: Colors.black)),
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
                    child: Text("Transaction Information", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 10),
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
//                          child: DropdownButtonHideUnderline(
//                            child: DropdownButton<String>(
//                              items: tokenOptions.map((value){
//                                return DropdownMenuItem<String>(
//                                  value: value,
//                                  child: Text(value, style: TextStyle(color: Colors.black, fontSize: 15), overflow: TextOverflow.ellipsis, maxLines: 3),
//                                );
//                              }).toList(),
//                              value: tokenOptions[tokenIndex],
//                              onChanged: (newValue) {
//                                setState(() {
//                                  tokenIndex = tokenOptions.indexOf(newValue);
//                                });
//                              },
//                            ),
//                          ),
                          child: Text("Stable Coin(SAC)", style: TextStyle(color: Colors.black),),
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
                        Text("Send to:", style: TextStyle(color: Colors.black87, fontSize: 15)),
                        Container(
                          width: screenWidth * 0.5,
                          padding: EdgeInsets.only(top: 10),
                          child: TextField(
                            controller: toAddressCT,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: "0x0s9832oisoiw34",
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        )
                      ],
                    ),
                  ),
//                  Container(
//                    padding: EdgeInsets.only(left: 10, right: 10),
//                    width: screenWidth,
//                    height: 50,
//                    decoration: BoxDecoration(
//                        color: Colors.white,
//                        border: Border.all(color: Colors.grey[300])
//                    ),
//                    child: Row(
//                      mainAxisSize: MainAxisSize.max,
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Text("Private Key:", style: TextStyle(color: Colors.black87, fontSize: 15)),
//                        Container(
//                          width: screenWidth * 0.7,
//                          padding: EdgeInsets.only(top: 10),
//                          child: Center(child: Text(GlobalValue.getPrivateKey, style: TextStyle(color: Colors.black))),
//                        )
//                      ],
//                    ),
//                  ),
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
                        Text("Amount:", style: TextStyle(color: Colors.black87, fontSize: 15)),
                        Container(
                          width: screenWidth * 0.5,
                          padding: EdgeInsets.only(top: 10),
                          child: TextField(
                            controller: amountCT,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: "amount",
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
                        Text("I certify the above is true.", style: TextStyle(color: Colors.black87, fontSize: 15)),
                        Switch(
                          value: isCertified,
                          onChanged: (value) {
                            setState(() {
                              isCertified = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  InkWell(
                    onTap: () {
                      sendToken();
                    },
                    child: Container(
                      width: screenWidth,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text("SEND", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
            mesage: "Sending token...",
          )
        ],
      ),
    );
  }
}
