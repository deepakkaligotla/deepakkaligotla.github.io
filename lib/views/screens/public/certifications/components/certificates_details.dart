import 'package:deepakkaligotla/core/constants/constants.dart';
import 'package:deepakkaligotla/core/utils/format_date.dart';
import 'package:deepakkaligotla/view_models/getx_controllers/certification_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificateStack extends StatelessWidget {
  final int index;
  final controller = Get.find<CertificationController>();

  CertificateStack({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final certificate = controller.certifications[index];

    return InkWell(
      onHover: (value) {
        controller.onHover(index, value);
      },
      onTap: () {},
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        padding: const EdgeInsets.all(defaultPadding),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: bgColor,
        ),
        duration: const Duration(milliseconds: 500),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        certificate.certificateName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        certificate.issuingOrganization,
                        style: const TextStyle(color: Colors.amber),
                      ),
                    ],
                  ),
                  if (certificate.issuingOrgUrl.isNotEmpty)
                    Center(
                      child: SvgPicture.network(
                        certificate.issuingOrgUrl,
                        height: 50,
                        width: 50,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.broken_image,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 5 / 2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Skills:', style: TextStyle(color: Colors.white)),
                  Text(
                    certificate.skills.join(', '),
                    textScaler: TextScaler.linear(0.6),
                    style: const TextStyle(color: Colors.grey),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                // Centers the button horizontally
                child: InkWell(
                  onTap: () {
                    if (certificate.credentialUrl.isNotEmpty) {
                      launchUrl(Uri.parse(certificate.credentialUrl));
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.teal.shade900],
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue,
                          offset: Offset(0, -1),
                          blurRadius: 5,
                        ),
                        BoxShadow(
                          color: Colors.red,
                          offset: Offset(0, 1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Credentials',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          CupertinoIcons.arrow_turn_up_right,
                          color: Colors.white,
                          size: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
