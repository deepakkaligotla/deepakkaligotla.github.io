import 'package:deepakkaligotla/core/constants/constants.dart';
import 'package:deepakkaligotla/view_models/getx_controllers/certification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'certificates_details.dart';

class CertificateGrid extends StatelessWidget {
  final int crossAxisCount;
  final double ratio;

  CertificateGrid({super.key, this.crossAxisCount = 3, this.ratio = 1.3});

  final controller = Get.put(CertificationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.certifications.isEmpty) {
        return Center(child: Text("No Certifications Available"));
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        itemCount: controller.certifications.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: ratio,
        ),
        itemBuilder: (context, index) {
          return Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(
                vertical: defaultPadding,
                horizontal: defaultPadding,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [Colors.pinkAccent, Colors.blue],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink,
                    offset: const Offset(-2, 0),
                    blurRadius: controller.hovers[index] ? 20 : 10,
                  ),
                  BoxShadow(
                    color: Colors.blue,
                    offset: const Offset(2, 0),
                    blurRadius: controller.hovers[index] ? 20 : 10,
                  ),
                ],
              ),
              child: CertificateStack(index: index),
            ),
          );
        },
      );
    });
  }
}
