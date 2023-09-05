// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Data data;
  int statusCode;
  String statusMessage;
  DateTime timestamp;

  Welcome({
    required this.data,
    required this.statusCode,
    required this.statusMessage,
    required this.timestamp,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    data: Data.fromJson(json["data"]),
    statusCode: json["statusCode"],
    statusMessage: json["statusMessage"],
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "statusCode": statusCode,
    "statusMessage": statusMessage,
    "timestamp": timestamp.toIso8601String(),
  };
}

class Data {
  List<Site> sites;

  Data({
    required this.sites,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sites: List<Site>.from(json["sites"].map((x) => Site.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sites": List<dynamic>.from(sites.map((x) => x.toJson())),
  };
}

class Site {
  String uid;
  String address;
  String city;
  String country;
  String name;
  String zip;
  String state;
  dynamic imageUrl;
  List<Charger> chargers;

  Site({
    required this.uid,
    required this.address,
    required this.city,
    required this.country,
    required this.name,
    required this.zip,
    required this.state,
    this.imageUrl,
    required this.chargers,
  });

  factory Site.fromJson(Map<String, dynamic> json) => Site(
    uid: json["uid"],
    address: json["address"],
    city: json["city"],
    country: json["country"],
    name: json["name"],
    zip: json["zip"],
    state: json["state"],
    imageUrl: json["imageUrl"],
    chargers: List<Charger>.from(json["chargers"].map((x) => Charger.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "address": address,
    "city": city,
    "country": country,
    "name": name,
    "zip": zip,
    "state": state,
    "imageUrl": imageUrl,
    "chargers": List<dynamic>.from(chargers.map((x) => x.toJson())),
  };
}

class Charger {
  String uid;
  String chargerId;
  List<Evse> evses;
  String imageUrl;
  String isPublic;
  double latitude;
  double longitude;
  bool isFavorite;

  Charger({
    required this.uid,
    required this.chargerId,
    required this.evses,
    required this.imageUrl,
    required this.isPublic,
    required this.latitude,
    required this.longitude,
    required this.isFavorite,
  });

  factory Charger.fromJson(Map<String, dynamic> json) => Charger(
    uid: json["uid"],
    chargerId: json["chargerId"],
    evses: List<Evse>.from(json["evses"].map((x) => Evse.fromJson(x))),
    imageUrl: json["imageUrl"],
    isPublic: json["isPublic"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    isFavorite: json["isFavorite"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "chargerId": chargerId,
    "evses": List<dynamic>.from(evses.map((x) => x.toJson())),
    "imageUrl": imageUrl,
    "isPublic": isPublic,
    "latitude": latitude,
    "longitude": longitude,
    "isFavorite": isFavorite,
  };
}

class Evse {
  String evseId;
  String uid;
  List<Connector> connector;
  EvseStatus evseStatus;

  Evse({
    required this.evseId,
    required this.uid,
    required this.connector,
    required this.evseStatus,
  });

  factory Evse.fromJson(Map<String, dynamic> json) => Evse(
    evseId: json["evseId"],
    uid: json["uid"],
    connector: List<Connector>.from(json["connector"].map((x) => Connector.fromJson(x))),
    evseStatus: json["evseStatus"],
  );

  Map<String, dynamic> toJson() => {
    "evseId": evseId,
    "uid": uid,
    "connector": List<dynamic>.from(connector.map((x) => x.toJson())),
    "evseStatus": evseStatusValues.reverse[evseStatus],
  };
}

class Connector {
  String id;
  String type;
  double maxPortPowerInKw;
  dynamic tariff;

  Connector({
    required this.id,
    required this.type,
    required this.maxPortPowerInKw,
    this.tariff,
  });

  factory Connector.fromJson(Map<String, dynamic> json) => Connector(
    id: json["id"],
    type: json["type"],
    maxPortPowerInKw: json["maxPortPowerInKw"].toDouble(),
    tariff: json["tariff"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "maxPortPowerInKw": maxPortPowerInKw,
    "tariff": tariff,
  };
}

enum EvseStatus {
  AVAILABLE,
  UNKNOWN
}

final evseStatusValues = EnumValues({
  "AVAILABLE": EvseStatus.AVAILABLE,
  "UNKNOWN": EvseStatus.UNKNOWN
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
