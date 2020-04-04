import 'package:flutter/material.dart';
import '../../widget/image_slider.dart';
import 'join_network_page.dart';

class ProfitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ImageSlider(["assets/images/profit_slider_1.jpg", "assets/images/profit_slider_2.jpg", "assets/images/profit_slider_3.jpg"]),
          SizedBox(height: 10),
          Container(
            child: Text("Together, we can do more.", style: TextStyle(color: Colors.black, fontSize: 20),),
          ),
          SizedBox(height: 20),
          Text(
            "Sable Assent could not do this work on our own. Economic hardships faced by Africans throughtout the diaspora are too complicated for one organization to solve alone. We are proud to work with other NGO's and non profit organizations who share our mission and vision.",
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
          SizedBox(height: 40),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => JoinNetworkPage()));
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.blue
              ),
              child: Center(
                child: Text("Join the Network", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
