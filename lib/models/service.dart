import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  final String serviceName;
  final String serviceId;
  final String serviceUrl;
  final List<String> media;
  final List<String> skills;

  Service({
    required this.serviceName,
    required this.serviceId,
    required this.serviceUrl,
    required this.media,
    required this.skills
  });

  factory Service.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Service(
      serviceName: data['serviceName'] ?? '',
      serviceId: data['serviceId'] ?? '',
      serviceUrl: data['serviceUrl'] ?? '',
      media: List<String>.from(data['media'] ?? []),
      skills: List<String>.from(data['skills'] ?? []),
    );
  }
}