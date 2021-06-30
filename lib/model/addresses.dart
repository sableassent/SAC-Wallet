class Address {
  Address({
    this.id,
    this.houseNumber,
    this.streetName,
    this.city,
    this.state,
    this.country,
    this.zipCode,
  });

  String id;
  String houseNumber;
  String streetName;
  String city;
  String state;
  String country;
  String zipCode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["_id"],
    houseNumber: json["houseNumber"],
    streetName: json["streetName"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    zipCode: json["zipCode"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "houseNumber": houseNumber,
    "streetName": streetName,
    "city": city,
    "state": state,
    "country": country,
    "zipCode": zipCode,
  };
}