import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? image;
  String? gender;
  String? city;
  Timestamp? dateOfBirth;
  String? lastName;
  String? middleName;
  int? isVerified;
  String? userId;
  String? referralCode;
  String? aadharNo;
  String? bloodGroup;
  String? phoneNumber;
  String? firstName;
  String? country;
  String? state;
  String? aadharImage;
  String? fcmToken;
  bool? isAvailable;
  int? stars;

  UserData({
    this.country,
    this.state,
    this.city,

    this.image,
    this.gender,
    this.dateOfBirth,
    this.lastName,
    this.middleName,
    this.isVerified,
    this.isAvailable,
    this.userId,
    this.referralCode,
    this.aadharNo,
    this.bloodGroup,
    this.phoneNumber,
    this.firstName,
    this.aadharImage,
    this.fcmToken,
    this.stars,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      city: map['city'],
      country: map['country'],
      state: map['state'],
      image: map['image'],
      gender: map['gender'],
      dateOfBirth: map['date_of_birth'],
      lastName: map['last_name'],
      middleName: map['middle_name'],
      isVerified: map['is_verified'],
      userId: map['user_id'],
      referralCode: map['referral_code'],
      aadharNo: map['aadhar_no'],
      bloodGroup: map['blood_group'],
      phoneNumber: map['phone_number'],
      firstName: map['first_name'],
      aadharImage: map['aadhar_image'],
      isAvailable: map['is_available'],
      stars: map['stars'],
      fcmToken: map['fcm_token'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'gender': gender,
      'city': city,
      'country': country,
      'state': state,
      'date_of_birth': dateOfBirth,
      'last_name': lastName,
      'middle_name': middleName,
      'is_verified': isVerified,
      'user_id': userId,
      'first_name': firstName,
      'referral_code': referralCode,
      'aadhar_no': aadharNo,
      'blood_group': bloodGroup,
      'phone_number': phoneNumber,
      'aadhar_image': aadharImage,
      'is_available': isAvailable,
      'stars': stars,
      'fcm_token': fcmToken,
    };
  }
}
