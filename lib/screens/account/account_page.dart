import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:sac_wallet/util/global.dart';
//import 'package:sac_wallet/widget/loading.dart';
//import 'edit_account_page.dart';
import '../../model/user.dart';
//import '../../util/global.dart';
import '../../blocs/firebase_bloc.dart';

FirebaseBloc bloc;

class AccountPage extends StatefulWidget {

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

   User currentUser = GlobalValue.getCurrentUser;
  
  @override
  void initState() {
    super.initState();
    bloc = new FirebaseBloc();
    //bloc.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                currentUser.photo == "" ?
                Image.asset("assets/images/default_profile.png", width: 100, height: 100, fit: BoxFit.fill)
                : CachedNetworkImage(
                    //placeholder: (context, url) => CircularProgressIndicator(),
                  imageUrl: currentUser.photo,
                  width: 100,
                  height: 100,
                  fadeInDuration: Duration(milliseconds: 300),
                  fadeOutDuration: Duration(milliseconds: 300),
                  placeholder: (context, url) => Image.asset("assets/images/loading.gif", width: 100, height: 100),
                  fit: BoxFit.scaleDown,
                  placeholderFadeInDuration: Duration(milliseconds: 300),),
                // currentUser.photo == ""
                //     ? Image.asset("assets/images/default_profile.png", width: 100, height: 100, fit: BoxFit.fill)
                //     : CachedNetworkImage(
                //   imageUrl: currentUser.photo,
                //   width: 100,
                //   height: 100,
                //   fadeInDuration: Duration(milliseconds: 300),
                //   fadeOutDuration: Duration(milliseconds: 300),
                //   placeholder: (context, url) => Image.asset("assets/images/loading.gif", width: 100, height: 100),
                //   fit: BoxFit.scaleDown,
                //   placeholderFadeInDuration: Duration(milliseconds: 300),
                // ),
                SizedBox(width: 20),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(currentUser.name, style: TextStyle(color: Colors.black, fontSize: 18)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: AutoSizeText(
                        "Wallet Address:\n${currentUser.eth_wallet_address}",
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                        minFontSize: 10,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Divider(height: 1, color: Colors.grey),
            SizedBox(height: 10),
            Text("Profile Description", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(currentUser.description == null ? "" : currentUser.description, style: TextStyle(color: Colors.black, fontSize: 14)),
            SizedBox(height: 20),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.greenAccent[700]
              ),
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: RawMaterialButton(
                      onPressed: () {},
                      child: Center(
                        child: SvgPicture.asset("assets/images/facebook.svg", color: Colors.white, width: 20, height: 20),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: RawMaterialButton(
                      onPressed: () {},
                      child: Center(
                        child: SvgPicture.asset("assets/images/twitter.svg", color: Colors.white, width: 20, height: 20),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: RawMaterialButton(
                      onPressed: () {},
                      child: Center(
                        child: SvgPicture.asset("assets/images/instagram.svg", color: Colors.white, width: 20, height: 20),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: RawMaterialButton(
                      onPressed: () {},
                      child: Center(
                        child: SvgPicture.asset("assets/images/linkedin.svg", color: Colors.white, width: 20, height: 20),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: currentUser.enabledChat,
                    child: Flexible(
                      flex: 1,
                      child: RawMaterialButton(
                        onPressed: () {},
                        child: Center(
                          child: SvgPicture.asset("assets/images/chat.svg", color: Colors.white, width: 20, height: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _launchURL(String url) async {
  //   if(await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
