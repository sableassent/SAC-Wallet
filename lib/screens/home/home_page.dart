import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/main_background.jpg"),
              fit: BoxFit.fill
            )
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/images/app_icon.png", width: screenWidth * 0.5, height: screenHeight * 0.2),
              SizedBox(height: screenHeight * 0.1),
              Text("ONE COMMUNITY", style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.07, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("ONE GLOBAL ECONOMY", style: TextStyle(color: Colors.white.withAlpha(0x80), fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold))
            ],
          ),
        )
      ],
    );
  }
}
