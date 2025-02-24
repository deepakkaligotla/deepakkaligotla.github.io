import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deepakkaligotla/model/certificate_model.dart';
import 'package:deepakkaligotla/res/constants/constants.dart';
import 'package:deepakkaligotla/viewModel/getx_controllers/certification_controller.dart';
import 'certificates_details.dart';

class CertificateGrid extends StatelessWidget {
  final int crossAxisCount;
  final double ratio;
  CertificateGrid({super.key, this.crossAxisCount = 3,  this.ratio=1.3});
  final controller = Get.put(CertificationController());

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      itemCount: certificateList.length,
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount, childAspectRatio: ratio),
      itemBuilder: (context, index) {
        return Obx(() => AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(
                vertical: defaultPadding, horizontal: defaultPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(colors: [
                  Colors.purpleAccent,
                  Colors.teal,
                ]),
                boxShadow:  [
                  BoxShadow(
                    color: Colors.purple,
                    offset: const Offset(-2, 0),
                    blurRadius: controller.hovers[index] ? 20 : 10,
                  ),
                  BoxShadow(
                    color: Colors.blue,
                    offset: const Offset(2, 0),
                    blurRadius: controller.hovers[index] ? 20 : 10,),
                ]),
            child: CertificateStack(index: index)
        ));
      },
    );
  }
}