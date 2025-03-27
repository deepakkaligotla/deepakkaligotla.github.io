import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/service.dart';

class ServicesViewModel extends ChangeNotifier{
  List<Service> _services = [];
  bool _isLoading = true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Service> get services => _services;
  bool get isLoading => _isLoading;

  Future<void> fetchServices() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('services')
          .get();
      _services = await Future.wait(querySnapshot.docs.map((doc) async {
        var service = Service.fromFirestore(doc);
        return service;
      }).toList());
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Error fetching services: $e');
    }
  }

  Future<void> addService(Service service) async {
    await _firestore.collection('services').add({
      'serviceName': service.serviceName,
      'serviceId': service.serviceId,
      'serviceUrl': service.serviceUrl,
      'media': service.media,
      'skills': service.skills,
    });
  }
}
