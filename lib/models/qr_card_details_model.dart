import 'dart:convert';

class FamilyMember {
  final String name;
  final String sex;
  final String age;
  final String relation;
  final String adhaar;

  FamilyMember({
    required this.name,
    required this.sex,
    required this.age,
    required this.relation,
    required this.adhaar,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) {
    return FamilyMember(
      name: json['family_name'] ?? '',
      sex: json['sex'] ?? '',
      age: json['age'] ?? '',
      relation: json['relation'] ?? '',
      adhaar: json['adhaar'] ?? '',
    );
  }
}

class PublicHelpingCard {
  final String cardNumber;
  final String name;
  final int age;
  final String mobile;
  final String rationOrAadhaar;
  final String gender;
  final int totalFamilyMembers;
  final String dateOfExpiry;
  final String address;
  final String imageUrl;
  final List<FamilyMember> familyDetails;

  PublicHelpingCard({
    required this.cardNumber,
    required this.name,
    required this.age,
    required this.mobile,
    required this.rationOrAadhaar,
    required this.gender,
    required this.totalFamilyMembers,
    required this.dateOfExpiry,
    required this.address,
    required this.imageUrl,
    required this.familyDetails,
  });

  factory PublicHelpingCard.fromJson(Map<String, dynamic> json) {
    final List<dynamic> familyJson = json['family_detail'] != null
        ? List<Map<String, dynamic>>.from(
            (json['family_detail'] is String)
                ? List<Map<String, dynamic>>.from(
                    jsonDecode(json['family_detail']),
                  )
                : json['family_detail'],
          )
        : [];

    return PublicHelpingCard(
      cardNumber: json['card_number'] ?? '',
      name: json['name'] ?? '',
      age: int.tryParse(json['age'] ?? '0') ?? 0,
      mobile: json['mobile'] ?? '',
      rationOrAadhaar: json['adhaar_number'] ?? '',
      gender: json['gender'] ?? '',
      totalFamilyMembers: int.tryParse(json['family_members'] ?? '0') ?? 0,
      dateOfExpiry: json['date_of_expiry'] ?? '',
      address: json['address'] ?? '',
      imageUrl: json['image_url'] ?? '',
      familyDetails: familyJson.map((f) => FamilyMember.fromJson(f)).toList(),
    );
  }
}
