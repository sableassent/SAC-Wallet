import 'package:flutter/material.dart';
import 'package:sac_wallet/Constants/AppColor.dart';
import 'package:sac_wallet/model/transaction.dart';
import 'package:sac_wallet/model/user.dart';
import 'package:sac_wallet/repository/wallet_repository.dart';
import 'package:sac_wallet/screens/account/edit_account_page.dart';
import 'package:sac_wallet/util/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'home/home_page.dart';
import 'account/account_page.dart';
//import 'account/edit_account_page.dart';
import 'wallet/wallet_page.dart';
import 'registry/registry_page.dart';
import 'profit/profit_page.dart';
import '../screens/login_page.dart';
import '../widget/loading.dart';
import '../blocs/user_bloc.dart';

UserBloc bloc;

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  double screenWidth, screenHeight;
  int navigation_current_index = 0;
  bool isLoading = false;
  static User currentUser = GlobalValue.getCurrentUser;

  static String tempWalletAddress = "0xf641e24c4084eb0ec8496d6b5a3b91d29dfcf66a"; // currentUser.eth_wallet_address <- replace with

  var sharedPreferences;  

  Future<List<Transaction>> transactions = WalletRepository().getTransactionHistory(address: tempWalletAddress, limit: 5);

  Future<String> currentBalance = WalletRepository().getCurrentBalance(address: currentUser.eth_wallet_address);

  @override
  void initState() {
    super.initState();
    bloc = new UserBloc();
    sharedPreferences =  SharedPreferences.getInstance();
  }

  Widget getPageFromIndex(int index) {

    switch(index) {
      case 0:
        return HomePage(transactions, currentBalance);
      case 1:
        return AccountPage();
      case 2:
        return WalletPage();
      case 3:
        return RegistryPage();
      case 4:
        return ProfitPage();
      case 5:
        return EditAccountPage();
      default:
        return HomePage(transactions, currentBalance);
    }
  }

  Widget getTitleFromIndex(int index) {
    switch(index) {
      case 0:
        return Text("SABLE ASSENT", style: TextStyle(color: Colors.black));
      case 1:
        return Text("My Account", style: TextStyle(color: Colors.black));
      case 2:
        return Text("My Wallet", style: TextStyle(color: Colors.black));
      case 3:
        return Text("Empowering Global Trade", style: TextStyle(color: Colors.black));
      case 4:
        return Text("Global Non-Profit Network", style: TextStyle(color: Colors.black));
      default:
        return Text("SABLE ASSENT", style: TextStyle(color: Colors.black));
    }
  }


  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: AppColor.MAIN_BG,
          appBar: AppBar(
            title: getTitleFromIndex(navigation_current_index),
            centerTitle: true,
            iconTheme: new IconThemeData(color: Colors.white),
            actions: <Widget>[
              Visibility(
                visible: navigation_current_index == 1,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => EditAccountPage()));
                  },
                  icon: Icon(Icons.edit, color: Colors.white, size: 25),
                ),
              )
            ],
          ),
          drawer: CustomDrawer(),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            currentIndex: navigation_current_index,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("Home")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text("My Account")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.payment),
                  title: Text("My Wallet")
              ),
              /*BottomNavigationBarItem(
                            icon: Icon(Icons.assignment),
                            title: Text("Registry")
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.public),
                            title: Text("Non-Profits")
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.input),
                            title: Text("Logout")
                        ),*/
            ],
            onTap: (index) async {
              if(index == 5){
                setState(() {
                  isLoading = true;
                });
                // bool isSuccess = await bloc.logout();
                bool isSuccess = await true;
                if(isSuccess){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route route) => false);
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  Toast.show("Failed!", context);
                }
              } else {
                setState(() {
                  navigation_current_index = index;
                });
              }
            },
          ),
          body: getPageFromIndex(navigation_current_index),
        ),
        LoadingScreen(
          inAsyncCall: isLoading,
          mesage: "Logging out...",
          dismissible: false,
        )
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/home_background.jpg"),
                    fit: BoxFit.cover
                     )
                ),
                child: Image.asset("assets/images/nav_header_image.png"),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 15.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1
                    ) )
                ),
                child: _sideMenuRow(context,"Registry", Icon(Icons.assessment, size: 32.0), RegistryPage()),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 15.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1
                    ) )
                ),
                child: _sideMenuRow(context, "Non-Profits", Icon(Icons.public, size: 32.0,),ProfitPage() ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),  
                    ),
                    GestureDetector(
                      child: Icon(Icons.exit_to_app, size: 32.0,),
                      onTap:  () async {
                        // bool isSuccess = await bloc.logout();
                        bool isSuccess = await true;
                        if(isSuccess){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route route) => false);
                      }
                      },  
                    )
                ],),
              ),
              SizedBox(height: 30),
              SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1
                    )
                  ) ),
                child: Container(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text("BETA Version 1.0.0")
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _sideMenuRow( BuildContext context,String title, Icon icon, Widget widget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),  
        ),
        GestureDetector(
          child: icon,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
          },  
        )
    ],);
  }
}

