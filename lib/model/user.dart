// import 'package:firebase_database/firebase_database.dart';
import '../util/text_util.dart';

class User {
  String id;
  String token;
  String name;
  String description;
  String email;
  String photo;
  String country;
  String eth_wallet_address;
  String facebook_link;
  String twitter_link;
  String instagram_link;
  String linkedin_link;
  bool enabledChat;

  User({this.id, this.token, this.name, this.description, this.email, this.photo, this.country, this.eth_wallet_address, this.facebook_link, this.twitter_link, this.instagram_link, this.linkedin_link, this.enabledChat});

  factory User.fromServer(Map<String, dynamic> snapshot) => User(
    id: snapshot["key"],
    token: snapshot[TextUtil.TOKEN],
    name: snapshot[TextUtil.NAME],
    description: snapshot[TextUtil.DESCRIPTION],
    email: snapshot[TextUtil.EMAIL],
    photo: snapshot[TextUtil.PHOTO],
    country: snapshot[TextUtil.COUNTRY],
    eth_wallet_address: snapshot[TextUtil.ETH_WALLET_ADDRESS],
    facebook_link: snapshot[TextUtil.FACEBOOK_LINK],
    twitter_link: snapshot[TextUtil.TWITTER_LINK],
    instagram_link: snapshot[TextUtil.INSTAGRAM_LINK],
    linkedin_link: snapshot[TextUtil.LINKEDIN_LINK],
    enabledChat: snapshot[TextUtil.ENABLED_CHAT]
  );

  User.create(Map<String, dynamic> snapshot){
      id = snapshot["key"];
      token = snapshot[TextUtil.TOKEN];
      name = snapshot[TextUtil.NAME];
      description = snapshot[TextUtil.DESCRIPTION];
      email = snapshot[TextUtil.EMAIL];
      photo = snapshot[TextUtil.PHOTO];
      country = snapshot[TextUtil.COUNTRY];
      eth_wallet_address = snapshot[TextUtil.ETH_WALLET_ADDRESS];
      print("ETH address: $eth_wallet_address");
      facebook_link = snapshot[TextUtil.FACEBOOK_LINK];
      twitter_link = snapshot[TextUtil.TWITTER_LINK];
      instagram_link = snapshot[TextUtil.INSTAGRAM_LINK];
      linkedin_link = snapshot[TextUtil.LINKEDIN_LINK];
      enabledChat = snapshot[TextUtil.ENABLED_CHAT];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[TextUtil.ID] = id;
    map[TextUtil.TOKEN] = token;
    map[TextUtil.NAME] = name;
    map[TextUtil.DESCRIPTION] = description;
    map[TextUtil.EMAIL] = email;
    map[TextUtil.PHOTO] = photo;
    map[TextUtil.COUNTRY] = country;
    map[TextUtil.ETH_WALLET_ADDRESS] = eth_wallet_address;
    map[TextUtil.FACEBOOK_LINK] = facebook_link;
    map[TextUtil.TWITTER_LINK] = twitter_link;
    map[TextUtil.INSTAGRAM_LINK] = instagram_link;
    map[TextUtil.LINKEDIN_LINK] = linkedin_link;
    map[TextUtil.ENABLED_CHAT] = enabledChat;
    return map;
  }

}