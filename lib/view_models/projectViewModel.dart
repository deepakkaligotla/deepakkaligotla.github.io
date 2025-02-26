import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/project.dart';

class ProjectViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to fetch all projects
  Future<List<Project>> fetchProjects() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('projects').get();
      return snapshot.docs
          .map((doc) => Project.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching projects: $e');
      return [];
    }
  }

  // Method to fetch a specific project by its ID
  Future<Project?> fetchProjectById(String projectId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('projects').doc(projectId).get();
      if (doc.exists) {
        return Project.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Error fetching project by ID: $e');
      return null;
    }
  }

  // Method to add a new project
  Future<void> addProject(Project project) async {
    try {
      await _firestore.collection('projects').add({
        'title': project.title,
        'description': project.description,
        'projectImagesUrl': project.projectImagesUrl,
        'projectVideosUrl': project.projectVideosUrl,
        'repoLink': project.repoLink,
        'technologies': project.technologies,
      });
    } catch (e) {
      print('Error adding project: $e');
    }
  }

  // Method to update an existing project
  Future<void> updateProject(String projectId, Project project) async {
    try {
      await _firestore.collection('projects').doc(projectId).update({
        'title': project.title,
        'description': project.description,
        'projectImagesUrl': project.projectImagesUrl,
        'projectVideosUrl': project.projectVideosUrl,
        'repoLink': project.repoLink,
        'technologies': project.technologies,
      });
    } catch (e) {
      print('Error updating project: $e');
    }
  }

  // Method to delete a project
  Future<void> deleteProject(String projectId) async {
    try {
      await _firestore.collection('projects').doc(projectId).delete();
    } catch (e) {
      print('Error deleting project: $e');
    }
  }
}