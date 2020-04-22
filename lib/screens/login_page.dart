import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../blocs/firebase_bloc.dart';
import '../widget/loading.dart';
//import '../util/validator.dart';
import 'register_page.dart';
import 'dashboard_page.dart';

FirebaseBloc bloc;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  double screenWidth, screenHeight;
  TextEditingController emailCT, passwordCT;
  bool isLoading = false;

  login() async {

    String email = emailCT.text;
    String password = passwordCT.text;

    if(email.isEmpty || password.isEmpty){
      if(email.isEmpty){
        Toast.show("Enter your email", context);
      } else {
        Toast.show("Enter your password", context);
      }
      return;
    }

    setState(() {
      isLoading = true;
    });

    bool isSuccess = await bloc.login(email: email, password: password);
    if(isSuccess){
      print("success ...");
      Navigator.push(context,MaterialPageRoute(builder: (context) => DashboardPage()));
      
    } else {
      setState(() {
        isLoading = false;
      });
      Toast.show("Failed login!", context);
    }

  }

  @override
  void initState() {
    super.initState();
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
                SizedBox(height: screenHeight * 0.01),
                InkWell(
                  onTap: () {
                    print("okkk");
                    login();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: screenWidth,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue
                    ),
                    child: Center(
                      child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Not a Member?", style: TextStyle(color: Colors.white, fontSize: 14)),
                    RawMaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterPage()));
                      },
                      child: Text("SIGNUP", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                    )
                  ],
                )
              ],
            ),
          ),
          LoadingScreen(
            inAsyncCall: isLoading,
            mesage: "Logging in...",
            dismissible: false
          )
        ],
      ),
    );
  }
}
