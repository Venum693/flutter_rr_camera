
import 'dart:convert';

import 'package:date_time_format/date_time_format.dart';

//AllRestaurantItem allRestaurantItemFromJson(String str) => AllRestaurantItem.fromJson(json.decode(str));


class AllRestaurantItem {
  List<RestaurantItem> items;


  AllRestaurantItem({
    required this.items,
  });

  factory AllRestaurantItem.fromJson(Map<String, dynamic> json) /*{
    var itemsList = json['items'] as List;
    List<RestaurantItem> items1 = itemsList.map((e) => RestaurantItem.fromJson(e)).toList();
    print('$items1');
    return AllRestaurantItem(items: items1);
  }*/

  => AllRestaurantItem(
    items: List<RestaurantItem>.from(json["items"].map((x) => RestaurantItem.fromJson(x))),
  );
}

class RestaurantItem {
  String? id;
  String? locationName;
  LocationGps? locationGps;
  String? locationAddress;
  String? locationReview;
  List<RestaurantPhoto> locationPhoto;
  /*String locationH3IndexFarRange;
  String locationH3IndexCloseRange;*/
  UploadedUser uploadedUser;
  AudioClip? audioClip;
  //List<Dislikes>? dislikes;
  DateTime? timeCreated;

  RestaurantItem({
    //required
    this.id,
     this.locationName,
     this.locationGps,
     this.locationAddress,
     this.locationReview,
     required this.locationPhoto,
    /*required this.locationH3IndexFarRange,
    required this.locationH3IndexCloseRange,*/
     required this.uploadedUser,
     this.audioClip,
     //this.dislikes,
     this.timeCreated,
  });

  factory RestaurantItem.fromJson(Map<String, dynamic> json)

  /*{

    var list = json['location_photo'] as List;
    List<RestaurantPhoto> photoList = list.map((e) => RestaurantPhoto.fromJson(e)).toList();

    return RestaurantItem(
      id: json["_id"],
      locationPhoto: photoList,
      uploadedUser: UploadedUser.fromJson(json["uploaded_user"]),
      locationName: json["location_name"],
      locationAddress: json["location_address"],
      locationGps: (json['location_gps'])!=null ?
          LocationGps.fromJson(json['location_gps']) : null,
      audioClip: (json["audio_clip"])!=null ?
      AudioClip.fromJson(json["audio_clip"]) : null,
      locationReview:  json["location_review"],
      timeCreated: (json["time_created"]) !=null ?
      DateTime.parse(json["time_created"]) : null
    );

  }*/


  => RestaurantItem(
    id: json["_id"],
    locationName: json["location_name"],
    locationGps: LocationGps.fromJson(json["location_gps"]),
    locationAddress: json["location_address"],
    locationReview: json["location_review"],
    locationPhoto: List<RestaurantPhoto>.from(json["location_photo"].map((x) => RestaurantPhoto.fromJson(x))),
    // locationH3IndexFarRange: json["location_h3_index_far_range"],
    // locationH3IndexCloseRange: json["location_h3_index_close_range"],
    uploadedUser: UploadedUser.fromJson(json["uploaded_user"]),
    audioClip: json["audio_clip"] != null? AudioClip.fromJson(json["audio_clip"]) : null,
    //dislikes: List<dynamic>.from(json["dislikes"].map((x) => x)),
    timeCreated: json["time_created"] != null ? DateTime.parse(json["time_created"]): null,
  );
}

class AudioClip {
  //String linkCldflareId;
  String? linkName;
  //String linkUrl;

  AudioClip({
    //required this.linkCldflareId,
    this.linkName,
    //required this.linkUrl,
  });

  factory AudioClip.fromJson(Map<String, dynamic> json) => AudioClip(
    //linkCldflareId: json["link_cldflare_id"],
    linkName: json["link_name"],
    //linkUrl: json["link_url"],
  );
}
class RestaurantPhoto {
  String? linkCldflareId;
  String? linkName;
  String? linkUrl;

  RestaurantPhoto({
     this.linkCldflareId,
     this.linkName,
     this.linkUrl,
  });

  factory RestaurantPhoto.fromJson(Map<String, dynamic> json) => RestaurantPhoto(
    linkCldflareId: json["link_cldflare_id"],
    linkName: json["link_name"],
    linkUrl: json["link_url"],
  );
}

class LocationGps {
  String? type;
  List<double>? coordinates;

  LocationGps({
     this.type,
     this.coordinates,
  });

  factory LocationGps.fromJson(Map<String, dynamic> json) => LocationGps(
    type: json["type"],
    coordinates: List<double>.from(json["coordinates"].map((x) => x)),
  );
}

class UploadedUser {
  String? id;
  String? rrAFullName;
  String? rrAMobile;

  UploadedUser({
     this.id,
     this.rrAFullName,
     this.rrAMobile,
  });

  factory UploadedUser.fromJson(Map<String, dynamic> json) => UploadedUser(
    id: json["_id"],
    rrAFullName: json["rr_a_full_name"],
    rrAMobile: json["rr_a_mobile"],
  );
}
