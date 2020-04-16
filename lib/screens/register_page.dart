import 'package:flutter/material.dart';
import 'package:sac_wallet/client/firebase_client.dart';
import 'package:toast/toast.dart';
import 'user_agreement_page.dart';
import '../blocs/firebase_bloc.dart';
import '../widget/loading.dart';

FirebaseBloc bloc;
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseClient client;
  double screenWidth, screenHeight;
  TextEditingController nameCT, emailCT, passwordCT;
  bool isUserAgreement = false;
  bool isLoading = false;

  register() async {

    String name = nameCT.text;
    String email = emailCT.text;
    String password = passwordCT.text;

    if(name.isEmpty || email.isEmpty || password.isEmpty){
      Toast.show("Fill all forms", context);
      return;
    }

    if(!isUserAgreement){
      Toast.show("You should agree to User Agreement.", context);
      return;
    }

    setState(() {
      isLoading = true;
    });

    var isSuccess = await bloc.register(name: name, email: email, password: password);
    if(isSuccess){
      Navigator.pop(context);
      Toast.show("Successfully registered!", context);
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
    nameCT = TextEditingController();
    emailCT = TextEditingController();
    passwordCT = TextEditingController();
    bloc = new FirebaseBloc();
  }

  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/home_background.jpg"),
                    fit: BoxFit.cover
                )
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/images/app_icon.png", width: screenWidth * 0.3, height: screenHeight * 0.2),
                SizedBox(height: screenHeight * 0.01),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: screenWidth,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Name", style: TextStyle(color: Colors.black87, fontSize: 17)),
                      Container(
                        width: screenWidth * 0.65,
                        child: TextField(
                          controller: nameCT,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Enter Name",
                            contentPadding: EdgeInsets.all(5)
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      )
                    ],
                  ),
                ),
                Divider(height: 0.2, color: Colors.grey),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: screenWidth,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Email", style: TextStyle(color: Colors.black87, fontSize: 17)),
                      Container(
                        width: screenWidth * 0.65,
                        child: TextField(
                          controller: emailCT,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Enter Email",
                            contentPadding: EdgeInsets.all(5)
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      )
                    ],
                  ),
                ),
                Divider(height: 0.2, color: Colors.grey),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: screenWidth,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Password", style: TextStyle(color: Colors.black87, fontSize: 17)),
                      Container(
                        width: screenWidth * 0.65,
                        child: TextField(
                          obscureText: true,
                          controller: passwordCT,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Enter Password",
                            contentPadding: EdgeInsets.all(5)
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      )
                    ],
                  ),
                ),
                Divider(height: 0.2, color: Colors.grey),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: screenWidth,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isUserAgreement = !isUserAgreement;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: isUserAgreement ? Colors.blue : Colors.black45),
                            shape: BoxShape.circle,
                            color: isUserAgreement ? Colors.blue : Colors.white
                          ),
                          child: Center(
                            child: Icon(Icons.check, color: Colors.white, size: 20),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text("I agree to the user agreement.", style: TextStyle(color: Colors.black, fontSize: 15))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                InkWell(
                  onTap: () {
                    register();
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: screenWidth,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue
                    ),
                    child: Center(
                      child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Already a Member?", style: TextStyle(color: Colors.white, fontSize: 14)),
                    RawMaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                    )
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RawMaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserAgreementPage()));
              },
              child: Text("View this app's user agreement", style: TextStyle(color: Colors.greenAccent, fontSize: 13, fontWeight: FontWeight.bold)),
            ),
          ),
          LoadingScreen(
            inAsyncCall: isLoading,
            mesage: "Signing up...",
            dismissible: false,
          )
        ],
      ),
    );
  }
}
