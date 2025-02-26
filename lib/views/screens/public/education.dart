import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:deepakkaligotla/core/services/firebase_services.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreen();
}

class _EducationScreen extends State<EducationScreen> {
  PlatformFile? uploadFile;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() async {
        uploadFile = result.files.single;
        await uploadToFirebaseStorage(uploadFile!);
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> uploadToFirebaseStorage(PlatformFile uploadFile) async {
    final uploadTask = firebaseStorage.ref("videos/ShinChan/001/${uploadFile.name}").putData(uploadFile.bytes!);
    
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress = 100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          // Handle successful uploads on complete
          // ...
          break;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final finalData = Provider.of<LocalStorageProvider>(context, listen: true).localStorage;

    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Text('Education Page'),
              Card(elevation: 50, color: finalData.userDetails.userColorScheme!.surfaceTint, shape: 
                RoundedRectangleBorder(side: BorderSide(color: finalData.userDetails.userColorScheme!.outline),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: const SizedBox(
                  width: 400,
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Post Graduation Diploma in Mobile Computing'),
                      Text('Post Graduation Diploma in Mobile Computing')
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 50,
                color:
                    finalData.userDetails.userColorScheme!.background,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: finalData.userDetails.userColorScheme!.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: const SizedBox(
                  width: 400,
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Post Graduation Diploma in Mobile Computing'),
                      Text('Post Graduation Diploma in Mobile Computing')
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 50,
                color:
                    finalData.userDetails.userColorScheme!.background,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: finalData.userDetails.userColorScheme!.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: const SizedBox(
                  width: 400,
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Post Graduation Diploma in Mobile Computing'),
                      Text('Post Graduation Diploma in Mobile Computing')
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _openFileExplorer,
                child: const Text('Upload File'),
              ),
            ],
          ),
        ),
      )
    );
  }
}
