import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';
import 'package:deepakkaligotla/view_models/certificationViewModel.dart';
import 'package:deepakkaligotla/views/widgets/components/glowing_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Certifications extends StatefulWidget {
  const Certifications({super.key});

  @override
  State<Certifications> createState() => _CertificationsState();
}

class _CertificationsState extends State<Certifications> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<CertificationViewModel>(
            context,
            listen: false,
          ).fetchCertifications(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final finalData = Provider.of<LocalStorageProvider>(context, listen: true).localStorage;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                end: Alignment.centerRight,
                begin: Alignment.centerLeft,
                colors: [Colors.purple, Colors.cyanAccent],
              ).createShader(bounds);
            },
            child: Text(
              "Certifications",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: Consumer<CertificationViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Card(
                elevation: 8.0,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        (finalData.deviceInfo.deviceWidth! / 360).toInt(),
                    childAspectRatio: 360 / 240,
                  ),
                  itemCount: viewModel.certifications.length,
                  itemBuilder: (context, index) {
                    final certificate = viewModel.certifications[index];
                    return GlowingContainer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    certificate.issuingOrganization,
                                    style: const TextStyle(color: Colors.amber),
                                  ),
                                ],
                              ),

                              if (certificate.issuingOrgUrl.isNotEmpty)
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: SvgPicture.network(
                                    certificate.issuingOrgUrl,
                                    fit: BoxFit.contain,
                                    placeholderBuilder:
                                        (context) => const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.broken_image,
                                              color: Colors.red,
                                              size: 40,
                                            ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Skills:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                certificate.skills.join(', '),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: InkWell(
                              onTap: () async {
                                if (certificate.credentialUrl.isNotEmpty) {
                                  final url = Uri.parse(
                                    certificate.credentialUrl,
                                  );
                                  if (await canLaunchUrl(url)) {
                                    launchUrl(url);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Could not open URL'),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Container(
                                height: 45,
                                width: 160,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.purple,
                                      Colors.teal.shade900,
                                    ],
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
                                      'View Credentials',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      CupertinoIcons.arrow_turn_up_right,
                                      color: Colors.white,
                                      size: 14, // Adjusted size
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
