// models/affiliation_model.dart

class AffiliationModel {
  final String name;
  final String address;
  final String contactNo;
  final String image_url;

  AffiliationModel({
    required this.name,
    required this.address,
    required this.contactNo,
    required this.image_url,
  });

  factory AffiliationModel.fromJson(Map<String, dynamic> json) {
    return AffiliationModel(
      name: json['name'] ?? '',
      address: json['location'] ?? '',
      contactNo: json['mobile'] ?? '',
      image_url: json['image_url'] ?? '',
    );
  }
}
