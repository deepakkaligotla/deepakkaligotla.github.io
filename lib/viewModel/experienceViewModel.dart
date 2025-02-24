import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../model/experience.dart';
import '../model/project.dart';

class ExperienceViewModel extends ChangeNotifier {
  List<Experience> _experiences = [];
  bool _isLoading = true;
  Map<String, List<Project>> _projectsByExperience = {};

  List<Experience> get experiences => _experiences;
  bool get isLoading => _isLoading;

  Future<void> fetchExperiences() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('experiences')
          .get();

      _experiences = await Future.wait(querySnapshot.docs.map((doc) async {
        var experience = Experience.fromFirestore(doc);
        var projects = await _fetchProjects(experience.projects);
        _projectsByExperience[experience.companyName] = projects;
        return experience;
      }).toList());

      _experiences.sort((a, b) {
        return b.dateOfJoining.compareTo(a.dateOfJoining);
      });

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Error fetching experiences: $e');
    }
  }

  Future<List<Project>> _fetchProjects(List<DocumentReference> projectRefs) async {
    List<Project> projects = [];
    for (var projectRef in projectRefs) {
      DocumentSnapshot doc = await projectRef.get();
      var project = Project.fromFirestore(doc);
      projects.add(project);
    }
    return projects;
  }

  List<Project> getProjectsForExperience(Experience experience) {
    return _projectsByExperience[experience.companyName] ?? [];
  }
}