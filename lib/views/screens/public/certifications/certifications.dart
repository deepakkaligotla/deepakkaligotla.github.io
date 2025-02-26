import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/certification_grid.dart';
import 'package:deepakkaligotla/view_models/responsive.dart';
import 'package:deepakkaligotla/view_models/getx_controllers/certification_controller.dart';
import 'package:deepakkaligotla/views/widgets/title_text.dart';
import 'package:deepakkaligotla/core/constants/constants.dart';

class Certifications extends StatelessWidget {
  final controller = Get.put(CertificationController());

  Certifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isLargeMobile(context))
              const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.all(5),
              child: TitleText(prefix: 'Certifications & ', title: 'License'),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: CertificateGridContainer(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CertificateGridContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Responsive(
          desktop: CertificateGrid(crossAxisCount: 3, ratio: 1.5),
          extraLargeScreen: CertificateGrid(crossAxisCount: 4, ratio: 1.6),
          largeMobile: CertificateGrid(crossAxisCount: 1, ratio: 1.8),
          mobile: CertificateGrid(crossAxisCount: 1, ratio: 1.4),
          tablet: CertificateGrid(crossAxisCount: 2, ratio: 1.7),
        ),
      ],
    );
  }
}