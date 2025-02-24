import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

late final FirebaseFirestore firestoreDB;
late final FirebaseStorage firebaseStorage;
late final CollectionReference userCollection;

void startFirebaseServices() {
  firestoreDB = FirebaseFirestore.instance;
  firebaseStorage = FirebaseStorage.instanceFor(bucket: 'gs://deepakkaligotla-githubio.firebasestorage.app');
  userCollection = firestoreDB.collection('users');
}