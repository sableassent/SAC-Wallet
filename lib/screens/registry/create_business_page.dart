import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../model/company.dart';
import '../../model/user.dart';
import '../../blocs/user_bloc.dart';
import '../../util/global.dart';
import '../../widget/loading.dart';

UserBloc bloc;

class CreateBusinessPage extends StatefulWidget {
  @override
  _CreateBusinessPageState createState() => _CreateBusinessPageState();
}

class _CreateBusinessPageState extends State<CreateBusinessPage> {

  double screenWidth, screenHeight;
  TextEditingController nameCT, yearCT, phoneCT, emailCT, websiteCT, facebookCT, twitterCT, instagramCT;
  int industryIndex = 0, locationIndex = 0;
  bool isCertified = false;
  bool isLoading = false;

  List<String> industryOptions = <String>["Service", "Merchandise", "Non Profit", "Tech", "Food \& Beverage", "Creative", "Other"];
  List<String> locations = <String>["Africa", "N. America", "S. America", "Caribbean Islands", "Asia", "Antarctica", "Australia", "Europe"];

  addCompanyData() async {
    String name = nameCT.text;
    String industry = industryOptions[industryIndex];
    String location = locations[locationIndex];
    String year = yearCT.text;
    String phone = phoneCT.text;
    String email = emailCT.text;
    String website = websiteCT.text;
    String facebook = facebookCT.text;
    String twitter = twitterCT.text;
    String instagram = instagramCT.text;

    if(name.isEmpty){
      Toast.show("Enter company name", context);
      return;
    }

    if(year.isEmpty){
      Toast.show("Enter yearf in operation", context);
      return;
    }

    if(phone.isEmpty){
      Toast.show("Enter company phone number", context);
      return;
    }

    if(email.isEmpty){
      Toast.show("Enter company email address", context);
      return;
    }

    if(website.isEmpty){
      Toast.show("Enter company site link", context);
      return;
    }

    if(!isCertified){
      Toast.show("Confirm if above the informations are true", context);
      return;
    }

    setState(() {
      isLoading = true;
    });

    Random random = new Random();
    User user = GlobalValue.getCurrentUser;

    Company company = new Company(
      id: "${random.nextInt(1000)}",
      companyName: name,
      userName: user.name,
      userWalletAddress: user.eth_wallet_address,
      industry: industry,
      location: location,
      year: year,
      phone: phone,
      email: email,
      website: website,
      facebookLink: facebook,
      twitterLink: twitter,
      instagramLink: instagram
    );

    // bool isSuccess = await bloc.addCompany(company: company, userId: user.id);
    bool isSuccess = await true;
    if(isSuccess){
      setState(() {
        isLoading = false;
      });
      Toast.show("Successfully added your company data", context);
    } else {
      setState(() {
        isLoading = false;
      });
      Toast.show("Failed!", context);
    }

  }

  @override
  void initState() {
    super.initState();
    bloc = new UserBloc();
    nameCT = new TextEditingController();
    yearCT = new TextEditingController();
    phoneCT = new TextEditingController();
    emailCT = new TextEditingController();
    websiteCT = new TextEditingController();
    facebookCT = new TextEditingController();
    twitterCT = new TextEditingController();
    instagramCT = new TextEditingController();
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
        title: Text("Register Your Business", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: screenWidth,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[300])
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Company Name:", style: TextStyle(color: Colors.black87, fontSize: 15)),
                        Container(
                          width: screenWidth * 0.5,
                          padding: EdgeInsets.only(top: 10),
                          child: TextField(
                            controller: nameCT,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Enter Name",
                              contentPadding: EdgeInsets.all(2)
                            ),
                            keyboardType: TextInputType.text,
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
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Select Industry:", style: TextStyle(color: Colors.black87, fontSize: 15)),
                        Container(
                          width: screenWidth * 0.5,
                          padding: EdgeInsets.only(top: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              items: industryOptions.map((value){
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: TextStyle(color: Colors.black, fontSize: 15),),
                                );
                              }).toList(),
                              value: industryOptions[industryIndex],
                              onChanged: (newValue) {
                                setState(() {
                                  industryIndex = industryOptions.indexOf(newValue);
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
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Location:", style: TextStyle(color: Colors.black87, fontSize: 15)),
                        Container(
                          width: screenWidth * 0.5,
                          padding: EdgeInsets.only(top: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: locations[locationIndex],
                              isDense: true,
                              onChanged: (newValue) {
                                setState(() {
                                  locationIndex = locations.indexOf(newValue);
                                });
                              },
                              items: locations.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value, style: TextStyle(color: Colors.black, fontSize: 15)),
                                );
                              }).toList(),
                              isExpanded: true,
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
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Years in Operation:", style: TextStyle(color: Colors.black87, fontSize: 15)),
                        Container(
                          width: screenWidth * 0.5,
                          padding: EdgeInsets.only(top: 10),
                          child: TextField(
                            controller: yearCT,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Enter year",
                                contentPadding: EdgeInsets.all(2)
                            ),
                            keyboardType: TextInputType.number,
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
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Phone:", style: TextStyle(color: Colors.black87, fontSize: 15)),
                        Container(
                          width: screenWidth * 0.5,
                          padding: EdgeInsets.only(top: 10),
                          child: TextField(
                            controller: phoneCT,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Enter phone number",
                                contentPadding: EdgeInsets.all(2)
                            ),
                            keyboardType: TextInputType.phone,
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
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Email:", style: TextStyle(color: Colors.black87, fontSize: 15)),
                        Container(
                          width: screenWidth * 0.5,
                          padding: EdgeInsets.only(top: 10),
                          child: TextField(
                            controller: emailCT,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Enter email",
                                contentPadding: EdgeInsets.all(2)
                            ),
                            keyboardType: TextInputType.emailAddress,
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
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Website:", style: TextStyle(color: Colors.black87, fontSize: 15)),
                        Container(
                          width: screenWidth * 0.5,
                          padding: EdgeInsets.only(top: 10),
                          child: TextField(
                            controller: websiteCT,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Enter site link",
                                contentPadding: EdgeInsets.all(2)
                            ),
                            keyboardType: TextInputType.url,
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
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Facebook Page:", style: TextStyle(color: Colors.black87, fontSize: 15)),
                        Container(
                          width: screenWidth * 0.5,
                          padding: EdgeInsets.only(top: 10),
                          child: TextField(
                            controller: facebookCT,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "facebook.com/company",
                                contentPadding: EdgeInsets.all(2)
                            ),
                            keyboardType: TextInputType.url,
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
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Twitter Page:", style: TextStyle(color: Colors.black87, fontSize: 15)),
                        Container(
                          width: screenWidth * 0.5,
                          padding: EdgeInsets.only(top: 10),
                          child: TextField(
                            controller: twitterCT,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "twitter.com/company",
                                contentPadding: EdgeInsets.all(2)
                            ),
                            keyboardType: TextInputType.url,
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
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Instagram Page:", style: TextStyle(color: Colors.black87, fontSize: 15)),
                        Container(
                          width: screenWidth * 0.5,
                          padding: EdgeInsets.only(top: 10),
                          child: TextField(
                            controller: instagramCT,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "instagram.com/company",
                                contentPadding: EdgeInsets.all(2)
                            ),
                            keyboardType: TextInputType.url,
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
                      mainAxisSize: MainAxisSize.min,
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
                      addCompanyData();
                    },
                    child: Container(
                      width: screenWidth,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text("Register my Black Business!", style: TextStyle(color: Colors.white)),
                      )
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
          LoadingScreen(
            inAsyncCall: isLoading,
            dismissible: false,
            mesage: "Adding as company...",
          )
        ],
      ),
    );
  }
}
