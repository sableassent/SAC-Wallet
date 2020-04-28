import 'package:flutter/material.dart';
import 'package:sac_wallet/Constants/AppColor.dart';
import 'package:sac_wallet/model/transaction.dart';
import 'package:sac_wallet/model/user.dart';
import 'package:sac_wallet/repository/wallet_repository.dart';
import 'package:sac_wallet/util/global.dart';
import 'package:toast/toast.dart';
import 'home/home_page.dart';
import 'account/account_page.dart';
//import 'account/edit_account_page.dart';
import 'wallet/wallet_page.dart';
import 'registry/registry_page.dart';
import 'profit/profit_page.dart';
import '../screens/login_page.dart';
import '../widget/loading.dart';
import '../blocs/firebase_bloc.dart';

FirebaseBloc bloc;

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  double screenWidth, screenHeight;
  int navigation_current_index = 0;
  bool isLoading = false;
  static User currentUser = GlobalValue.getCurrentUser;

  Future<List<Transaction>> transactions = WalletRepository().getTransactionHistory(address: currentUser.eth_wallet_address, limit: 5);

  Future<String> currentBalance = WalletRepository().getCurrentBalance(address: currentUser.eth_wallet_address);

  @override
  void initState() {
    super.initState();
    bloc = new FirebaseBloc();
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => null));
                  },
                  icon: Icon(Icons.edit, color: Colors.black, size: 25),
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
                bool isSuccess = await bloc.logout();
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
        decoration: BoxDecoration(
          color: Colors.green[900]
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 30,),
              Image.asset("assets/images/nav_header_image.png"),
              SizedBox(height: 30),
              Text(
                "Sable Assent is dedicated to\nempowering black businesses,\ncommunities, governments, and\nnon profits.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                "We provide the diaspora with the\ntools needed to build wealth, and\nincentivize workforces.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                "The Sable Coin is the medium of\nexchange which facilitates\nmonetary transactions between\nindividuals worldwide.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                "With the Sable Coin, Africans\nthroughout the diaspora can take\npride in owning their own currency.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

