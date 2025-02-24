import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../model/education.dart';

class EducationViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Education> _educationRecords = [];
  bool _isLoading = true;

  List<Education> get educationRecords => _educationRecords;
  bool get isLoading => _isLoading;

  Future<void> fetchEducationRecords() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('education').get();
      _educationRecords = querySnapshot.docs.map((doc) {
        return Education.fromFirestore(doc);
      }).where((education) => education != null).toList();

      _educationRecords.sort((a, b) {
        return b.startTime.toDate().compareTo(a.startTime.toDate()); // Sort by start date (descending)
      });

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Error fetching education records: $e');
    }
  }

  Future<void> addEducation(Education education) async {
    await _firestore.collection('education').add({
      'courseType': education.courseType,
      'degree': education.degree,
      'duration': education.duration,
      'endTime': education.endTime,
      'fieldOfStudyMajor': education.fieldOfStudyMajor,
      'institutionName': education.institutionName,
      'location': education.location,
      'percentage': education.percentage,
      'projects': education.projects,
      'softSkills': education.softSkills,
      'startTime': education.startTime,
      'syllabus': education.syllabus,
      'universityName': education.universityName,
      'universityLogoUrl': education.universityLogoUrl
    });
  }
}