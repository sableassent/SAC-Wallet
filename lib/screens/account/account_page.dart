import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Ink(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: new AssetImage("assets/images/main_background.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
              Ink(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black38,
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 160),
                child: Column(
                  children: <Widget>[
                    Avatar(
                      image: currentUser.photo == null ? new AssetImage("assests/images/default_profile.png") : CachedNetworkImageProvider(
                          currentUser.photo),
                      radius: 40,
                      backgroundColor: Colors.white,
                      borderColor: Colors.grey.shade300,
                      borderWidth: 4.0,
                    ),
                    Text(
                      currentUser.name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      " ",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          UserInfo(currentUser),
          SocialMedia(currentUser),
        ],
      ),
    );
  }
}

class SocialMedia extends StatelessWidget {
  final User currentUser;
  SocialMedia(this.currentUser);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
              alignment: Alignment.topLeft,
              child: Text(
                "Social Media Information",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Card(
              child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              leading: SvgPicture.asset(
                                  "assets/images/facebook.svg",
                                  color: Colors.grey,
                                  width: 20,
                                  height: 20),
                              title: Text("Facebook"),
                              subtitle: Text("${currentUser.facebook_link} "),
                            ),
                            onTap: () {
                              if (currentUser.facebook_link != null)
                                _launchURL(currentUser.facebook_link);
                            },
                          ),
                          GestureDetector(
                            child: ListTile(
                              leading: SvgPicture.asset(
                                  "assets/images/twitter.svg",
                                  color: Colors.grey,
                                  width: 20,
                                  height: 20),
                              title: Text("Twitter"),
                              subtitle: Text("${currentUser.twitter_link} "),
                            ),
                            onTap: () {
                              if (currentUser.twitter_link != null)
                                _launchURL(currentUser.instagram_link);
                            },
                          ),
                          GestureDetector(
                            child: ListTile(
                              leading: SvgPicture.asset(
                                  "assets/images/instagram.svg",
                                  color: Colors.grey,
                                  width: 20,
                                  height: 20),
                              title: Text("Instagram"),
                              subtitle: Text("${currentUser.instagram_link} "),
                            ),
                            onTap: () {
                              if (currentUser.instagram_link != null)
                                _launchURL(currentUser.instagram_link);
                            },
                          ),
                          GestureDetector(
                            child: ListTile(
                              leading: SvgPicture.asset(
                                  "assets/images/linkedin.svg",
                                  color: Colors.grey,
                                  width: 20,
                                  height: 20),
                              title: Text("LinkedIn"),
                              subtitle: Text("${currentUser.linkedin_link} "),
                            ),
                            onTap: () {
                              if (currentUser.linkedin_link != null)
                                _launchURL(currentUser.linkedin_link);
                            },
                          )
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class UserInfo extends StatelessWidget {
  final User currentUser;
  UserInfo(this.currentUser);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
              alignment: Alignment.topLeft,
              child: Text(
                "User Information",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Card(
              child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(Icons.info_outline),
                            title: Text("Wallet Address"),
                            subtitle: Text(currentUser.eth_wallet_address == null
                                ? "-"
                                : currentUser.eth_wallet_address),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(Icons.my_location),
                            title: Text("Country"),
                            subtitle: Text(currentUser.country == null
                                ? "-"
                                : currentUser.country),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text("Email"),
                            subtitle: Text(currentUser.email == null
                                ? "-"
                                : currentUser.email),
                          ),
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text("Description"),
                            subtitle: Text(currentUser.description == null
                                ? "-"
                                : currentUser.description),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key key,
      @required this.image,
      this.borderColor = Colors.grey,
      this.backgroundColor,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image,
        ),
      ),
    );
  }
}
