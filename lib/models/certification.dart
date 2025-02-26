import 'package:cloud_firestore/cloud_firestore.dart';

class Certification {
  final String certificateName;
  final String credentialId;
  final String credentialUrl;
  final Timestamp expirationDate;
  final Timestamp issueDate;
  final String issuingOrganization;
  final String issuingOrgUrl;
  final List<String> media;
  final List<String> skills;

  Certification({
    required this.certificateName,
    required this.credentialId,
    required this.credentialUrl,
    required this.expirationDate,
    required this.issueDate,
    required this.issuingOrganization,
    required this.issuingOrgUrl,
    required this.media,
    required this.skills,
  });

  // Factory constructor to convert Firestore DocumentSnapshot into a Certification object
  factory Certification.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Certification(
      certificateName: data['certificateName'] ?? '',
      credentialId: data['credentialId'] ?? '',
      credentialUrl: data['credentialUrl'] ?? '',
      expirationDate: data['expirationDate'] as Timestamp,
      issueDate: data['issueDate'] as Timestamp,
      issuingOrganization: data['issuingOrganization'] ?? '',
      issuingOrgUrl: data['issuingOrgUrl'] ?? '',
      media: List<String>.from(data['media'] ?? []),
      skills: List<String>.from(data['skills'] ?? []),
    );
  }
}
