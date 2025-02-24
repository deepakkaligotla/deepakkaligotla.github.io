import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  final String title;
  final String description;
  final List<String> projectImagesUrl;
  final List<String> projectVideosUrl;
  final String repoLink;
  final List<String> technologies;

  Project({
    required this.title,
    required this.description,
    required this.projectImagesUrl,
    required this.projectVideosUrl,
    required this.repoLink,
    required this.technologies,
  });

  factory Project.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Project(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      projectImagesUrl: List<String>.from(data['projectImagesUrl'] ?? []),
      projectVideosUrl: List<String>.from(data['projectVideosUrl'] ?? []),
      repoLink: data['repoLink'] ?? '',
      technologies: List<String>.from(data['technologies'] ?? []),
    );
  }
}