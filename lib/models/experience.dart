import 'package:cloud_firestore/cloud_firestore.dart';

class Experience {
  final String companyName;
  final bool currentlyWorking;
  final Timestamp dateOfJoining;
  final String jobTitle;
  final Timestamp? lastWorkingDay;
  final GeoPoint location;
  final String logoUrl;
  final List<String> skills;
  final List<String> technologies;
  final String roleDescription;
  final List<DocumentReference> projects; // Keep this as DocumentReference list

  Experience({
    required this.companyName,
    required this.currentlyWorking,
    required this.dateOfJoining,
    required this.jobTitle,
    this.lastWorkingDay,
    required this.location,
    required this.logoUrl,
    required this.skills,
    required this.technologies,
    required this.roleDescription,
    required this.projects,
  });

  factory Experience.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Fetch references for projects (still a list of DocumentReference)
    List<DocumentReference> projectRefs = (data['projects'] as List)
        .map((projectRef) => projectRef as DocumentReference)
        .toList();

    return Experience(
      companyName: data['companyName'] ?? '',
      currentlyWorking: data['currentlyWorking'] ?? false,
      dateOfJoining: data['dateOfJoining'] as Timestamp,
      jobTitle: data['jobTitle'] ?? '',
      lastWorkingDay: data['lastWorkingDay'] as Timestamp?,
      location: data['location'] as GeoPoint,
      logoUrl: data['logoUrl'] ?? '',
      skills: List<String>.from(data['skills'] ?? []),
      technologies: List<String>.from(data['technologies'] ?? []),
      roleDescription: data['roleDescription'] ?? '',
      projects: projectRefs,
    );
  }

  // The copyWith method allows you to create a new Experience instance with modified values
  Experience copyWith({
    String? companyName,
    bool? currentlyWorking,
    Timestamp? dateOfJoining,
    String? jobTitle,
    Timestamp? lastWorkingDay,
    GeoPoint? location,
    String? logoUrl,
    List<String>? skills,
    List<String>? technologies,
    String? roleDescription,
    List<DocumentReference>? projects, // Use DocumentReference here instead of Project
  }) {
    return Experience(
      companyName: companyName ?? this.companyName,
      currentlyWorking: currentlyWorking ?? this.currentlyWorking,
      dateOfJoining: dateOfJoining ?? this.dateOfJoining,
      jobTitle: jobTitle ?? this.jobTitle,
      lastWorkingDay: lastWorkingDay ?? this.lastWorkingDay,
      location: location ?? this.location,
      logoUrl: logoUrl ?? this.logoUrl,
      skills: skills ?? this.skills,
      technologies: technologies ?? this.technologies,
      roleDescription: roleDescription ?? this.roleDescription,
      projects: projects ?? this.projects,  // Maintain the DocumentReference type
    );
  }
}