import 'package:cloud_firestore/cloud_firestore.dart';

class Education {
  final String courseType;
  final String degree;
  final double duration;
  final Timestamp endTime;
  final String fieldOfStudyMajor;
  final String institutionName;
  final GeoPoint location;
  final double percentage;
  final String projects;
  final List<String> softSkills;
  final Timestamp startTime;
  final List<Map<String, String>> syllabus;
  final String universityName;
  final String universityLogoUrl;

  Education({
    required this.courseType,
    required this.degree,
    required this.duration,
    required this.endTime,
    required this.fieldOfStudyMajor,
    required this.institutionName,
    required this.location,
    required this.percentage,
    required this.projects,
    required this.softSkills,
    required this.startTime,
    required this.syllabus,
    required this.universityLogoUrl,
    required this.universityName
  });

  factory Education.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    List<Map<String, String>> syllabusList = (data['syllabus'] as List?)
        ?.map((subject) => Map<String, String>.from(subject as Map))
        .toList() ?? [];

    return Education(
      courseType: data['courseType'] ?? '',
      degree: data['degree'] ?? '',
      duration: data['duration'] ?? 0,
      endTime: data['endTime'] as Timestamp,
      fieldOfStudyMajor: data['fieldOfStudyMajor'] ?? '',
      institutionName: data['institutionName'] ?? '',
      location: data['location'] as GeoPoint,
      percentage: data['percentage'] ?? 0.0,
      projects: data['projects'] ?? '',
      softSkills: List<String>.from(data['softSkills'] ?? []),
      startTime: data['startTime'] as Timestamp,
      syllabus: syllabusList,
      universityLogoUrl: data['universityLogoUrl'] ?? '',
      universityName: data['universityName'] ?? ''
    );
  }
}
