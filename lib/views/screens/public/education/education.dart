import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deepakkaligotla/core/constants/constants.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';
import 'package:deepakkaligotla/view_models/educationViewModel.dart';
import 'package:deepakkaligotla/view_models/responsive.dart';
import 'package:deepakkaligotla/views/widgets/title_text.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<EducationViewModel>(context, listen: false).fetchEducationRecords());
  }

  Future<void> _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile uploadFile = result.files.single;
      await uploadToFirebaseStorage(uploadFile);
    }
  }

  Future<void> uploadToFirebaseStorage(PlatformFile uploadFile) async {
    final uploadTask = FirebaseStorage.instance
        .ref("videos/ShinChan/001/${uploadFile.name}")
        .putData(uploadFile.bytes!);

    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress = 100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.success: print("Upload successful!");
          break;
        default: print("Upload failed or canceled.");
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EducationViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (viewModel.educationRecords.isEmpty) {
          return Center(child: Text('No Education Records Found'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                            end: Alignment.centerRight,
                            begin: Alignment.centerLeft,
                            colors: [
                              Colors.purple,
                              Colors.cyanAccent,
                            ]).createShader(bounds);
                      },
                      child: Text(
                        "Education Qualifications",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                for (var education in viewModel.educationRecords)
                  _buildEducationCard(
                      logoUrl: education.universityLogoUrl ?? '',
                      degree: education.degree ?? 'N/A',
                      major: education.fieldOfStudyMajor ?? 'Unknown',
                      duration: education.duration ?? 0,
                      percentage: '${education.percentage}%',
                      courseType: education.courseType ?? 'N/A',
                      institutionName: education.institutionName ?? 'Unknown',
                      location: '${education.location.latitude}, ${education.location.longitude}',
                      projects: education.projects ?? 'No Projects Available',
                      softSkills: education.softSkills ?? [],
                      universityName: education.universityName ?? 'N/A',
                      subjects: education.syllabus ?? [],
                      startTime: education.startTime,
                      endTime: education.endTime
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEducationCard({
    required String logoUrl,
    required String degree,
    required String major,
    required double duration,
    required String percentage,
    required String courseType,
    required String institutionName,
    required String location,
    required String projects,
    required List<String> softSkills,
    required String universityName,
    required List<Map<String, String>> subjects,
    required Timestamp startTime,
    required Timestamp endTime,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // University logo
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Provider.of<LocalStorageProvider>(context, listen: true).localStorage.userDetails.userColorScheme?.onPrimaryFixed,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FractionallySizedBox(
                      alignment: Alignment.center,
                      widthFactor: 0.8,
                      heightFactor: 0.8,
                      child: logoUrl.isNotEmpty
                          ? Image.network(logoUrl, fit: BoxFit.contain)
                          : Placeholder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Degree and Major
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      degree + ' in ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Provider.of<LocalStorageProvider>(context, listen: true).localStorage.userDetails.userColorScheme?.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      major,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Provider.of<LocalStorageProvider>(context, listen: true).localStorage.userDetails.userColorScheme?.onSurfaceVariant,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          institutionName+', ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Provider.of<LocalStorageProvider>(context, listen: true).localStorage.userDetails.userColorScheme?.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          universityName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Provider.of<LocalStorageProvider>(context, listen: true).localStorage.userDetails.userColorScheme?.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '$courseType | ${startTime.toDate().year} - ${endTime.toDate().year} | $percentage | $duration years',
                      style: TextStyle(
                        fontSize: 14,
                        color: Provider.of<LocalStorageProvider>(context, listen: true).localStorage.userDetails.userColorScheme?.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Location: $location',
              style: TextStyle(
                fontSize: 14,
                color: Provider.of<LocalStorageProvider>(context, listen: true).localStorage.userDetails.userColorScheme?.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Projects: $projects',
              style: TextStyle(
                fontSize: 14,
                color: Provider.of<LocalStorageProvider>(context, listen: true).localStorage.userDetails.userColorScheme?.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Soft Skills:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Provider.of<LocalStorageProvider>(context, listen: true).localStorage.userDetails.userColorScheme?.onSurfaceVariant,
              ),
            ),
            ...softSkills.map((skill) {
              return Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  skill,
                  style: TextStyle(
                    fontSize: 14,
                    color: Provider.of<LocalStorageProvider>(context, listen: true).localStorage.userDetails.userColorScheme?.onSurfaceVariant,
                  ),
                ),
              );
            }).toList(),
            // Display subjects (syllabus)
            Text(
              'Syllabus:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Provider.of<LocalStorageProvider>(context, listen: true).localStorage.userDetails.userColorScheme?.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 5),
            ...subjects.map((subject) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject['subjectName']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Provider.of<LocalStorageProvider>(context, listen: true).localStorage.userDetails.userColorScheme?.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    subject['details']!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Provider.of<LocalStorageProvider>(context, listen: true).localStorage.userDetails.userColorScheme?.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}