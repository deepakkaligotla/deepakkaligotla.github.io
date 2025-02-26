import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';

class SwitchDevice extends StatefulWidget {
  const SwitchDevice({super.key});

  @override
  State<SwitchDevice> createState() => _SwitchDevice();
}

class _SwitchDevice extends State<SwitchDevice> {
  Offset offset = Offset.zero;

  Future<void> launch(String url, {bool isNewTab = true}) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
  }

  @override
  Widget build(BuildContext context) {
    final finalData =
        Provider.of<LocalStorageProvider>(context, listen: true).localStorage;

    return Positioned(
        left: 0,
        right: 0,
        bottom: offset.dy,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'See this in...',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', width: 48, height: 48),
                  const Text('Kaligotla App'),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (finalData.deviceInfo.deviceData!['platform'] == "iPhone" || finalData.deviceInfo.deviceData!['platform'] == "iPad") {
                        js.context.callMethod('open', ['allcomponentsold://']);
                      }
                      if (finalData.deviceInfo.deviceData!['platform'] == "android") {
                        js.context.callMethod('open', ['https://play.google.com/store/apps/details?id=in.kaligotla.deepak']);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(78, 57, 175, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    label: const Text('Open'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.open_in_browser_outlined,
                      color: Colors.white, size: 48),
                  Text('${finalData.deviceInfo.deviceData!['browserName']['name']}'),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    label: const Text('Continue'),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
