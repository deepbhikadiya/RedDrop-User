class Address {
  String address;
  List<String> coordinates;

  Address(
      { this.address='',
        this.coordinates = const []});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        address: json['address'],
        coordinates:
        json['coordinates'] != null && json['coordinates'].isNotEmpty
            ? List<String>.from(json['coordinates'] as List<dynamic>)
            : []);
  }
  Map<String, dynamic> toJson() {
    return {
      "address": address,
      'coordinates': coordinates
    };
  }
}
