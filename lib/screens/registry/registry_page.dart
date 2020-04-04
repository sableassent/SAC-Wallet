import 'package:flutter/material.dart';
import '../../widget/image_slider.dart';
import 'create_business_page.dart';

class RegistryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ImageSlider(["assets/images/registry_slider_1.jpg", "assets/images/registry_slider_2.jpg", "assets/images/registry_slider_3.jpg"]),
          SizedBox(height: 20),
          Text(
            "Sable Assent is currently coordinating with Black owned business throughout the world to develop a Global Business Registry. Member businesses will be capable of accepting the Sable Assent Coin in exchange for products and services and will also be listed as featured companies on our website and mobile app.",
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
          SizedBox(height: 40),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateBusinessPage()));
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue
              ),
              child: Center(
                child: Text("Register your Business", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
