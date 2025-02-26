import 'package:get/get.dart';
import 'package:deepakkaligotla/models/certification.dart';
import '../certificationViewModel.dart';

class CertificationController extends GetxController {
  final CertificationViewModel _viewModel = CertificationViewModel();

  var certifications = <Certification>[].obs;
  var isLoading = true.obs;
  RxList<bool> hovers = List.filled(20, false).obs;

  @override
  void onInit() {
    fetchCertifications();
    super.onInit();
  }

  Future<void> fetchCertifications() async {
    try {
      isLoading(true);
      certifications.value = await _viewModel.fetchCertifications();
      hovers = List.filled(certifications.length, false).obs;
    } finally {
      isLoading(false);
    }
  }

  void onHover(int index, bool value) {
    if (index < hovers.length) {
      hovers[index] = value;
    }
  }
}