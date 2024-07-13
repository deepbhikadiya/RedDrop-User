import 'package:cloud_firestore/cloud_firestore.dart';

class MyRequestModel {
  Timestamp? date;
  List<PotentialDonor>? potentialDonors;
  String? userId;
  String? bloodGroup;
  Location? location;
  Timestamp? time;
  String? requestId;
  String? note;

  MyRequestModel({
    this.date,
    this.potentialDonors,
    this.userId,
    this.bloodGroup,
    this.location,
    this.time,
    this.requestId,
    this.note,
  });

  MyRequestModel.fromMap(Map<String, dynamic> map)
      : date = map['date'],
        potentialDonors = map['potential_donors'] != null
            ? List<PotentialDonor>.from(map['potential_donors'].map((x) => PotentialDonor.fromMap(x)))
            : null,
        userId = map['user_id'],
        bloodGroup = map['blood_group'],
        location = map['location'] != null ? Location.fromMap(map['location']) : null,
        time = map['time'],
        requestId = map['request_id'],
        note = map['note'];
}

class PotentialDonor {
  bool? isDonated;
  String? userId;
  bool? isConfirm;
  double? lat;
  double? long;
  bool? isAvailable;

  PotentialDonor({
    this.isDonated,
    this.userId,
    this.isConfirm,
    this.isAvailable,
    this.lat,
    this.long,
  });

  PotentialDonor.fromMap(Map<String, dynamic> map)
      : isDonated = map['is_donated'],
        userId = map['user_id'],
        isConfirm = map['is_confirm'],
        lat = map['lat'],
        long = map['long'],
        isAvailable = map['is_available'];
}

class Location {
  String? address;
  List<double>? coordinates;

  Location({
    this.address,
    this.coordinates,
  });

  Location.fromMap(Map<String, dynamic> map)
      : address = map['address'],
        coordinates = _parseCoordinates(map['coordinates']);

  static List<double>? _parseCoordinates(dynamic value) {
    if (value is List<dynamic>) {
      return List<double>.from(value.map((element) => double.tryParse(element)));
    } else if (value is String) {
      List<String> parts = value.split(',');
      return parts.map((part) => double.tryParse(part) ?? 0.0).toList();
    }
    return null;
  }
}

