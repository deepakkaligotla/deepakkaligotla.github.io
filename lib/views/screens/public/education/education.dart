import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:deepakkaligotla/views/widgets/components/glowing_container.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

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
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.success:
          print("Upload successful!");
          break;
        default:
          print("Upload failed or canceled.");
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GlowingContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Post Graduation Diploma in Mobile Computing',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _openFileExplorer,
                child: const Text('Upload File'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}