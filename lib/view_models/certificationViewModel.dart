import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/certification.dart';

class CertificationViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to fetch all certifications
  Future<List<Certification>> fetchCertifications() async {
    QuerySnapshot snapshot = await _firestore.collection('certifications').get();
    return snapshot.docs
        .map((doc) => Certification.fromFirestore(doc))
        .toList();
  }

  // Method to add a new certification
  Future<void> addCertification(Certification certification) async {
    await _firestore.collection('certifications').add({
      'certificateName': certification.certificateName,
      'credentialId': certification.credentialId,
      'credentialUrl': certification.credentialUrl,
      'expirationDate': certification.expirationDate,
      'issueDate': certification.issueDate,
      'issuingOrganization': certification.issuingOrganization,
      'media': certification.media,
      'skills': certification.skills,
    });
  }
}
