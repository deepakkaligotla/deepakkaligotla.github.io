import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/certification.dart';
import 'package:flutter/cupertino.dart';

class CertificationViewModel extends ChangeNotifier {
  List<Certification> _certifications = [];
  bool _isLoading = true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Certification> get certifications => _certifications;
  bool get isLoading => _isLoading;

  Future<void> fetchCertifications() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('certificates')
          .get();
      _certifications = await Future.wait(querySnapshot.docs.map((doc) async {
        var certificate = Certification.fromFirestore(doc);
        return certificate;
      }).toList());
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Error fetching certifications: $e');
    }
  }

  Future<void> addCertification(Certification certification) async {
    await _firestore.collection('certificates').add({
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
