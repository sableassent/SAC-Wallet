import 'package:flutter/material.dart';

class UserAgreementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text("Sable Assent User Agreement", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Image.asset("assets/images/user_agreement.jpeg", width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, fit: BoxFit.fill),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 40),
            child: Text(
              "This is where we will put the terms and conditions of the application, including but not limited to the site's KYC compliance policies. "
                  "This is where we will put the terms and conditions of the application, including but not limited to the site's KYC compliance policies. "
                  "This is where we will put the terms and conditions of the application, including but not limited to the site's KYC compliance policies. "
                  "This is where we will put the terms and conditions of the application, including but not limited to the site's KYC compliance policies. "
                  "This is where we will put the terms and conditions of the application, including but not limited to the site's KYC compliance policies. "
                  "This is where we will put the terms and conditions of the application, including but not limited to the site's KYC compliance policies. ",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
