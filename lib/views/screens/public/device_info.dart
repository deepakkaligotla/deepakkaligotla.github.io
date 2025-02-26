import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final finalData = Provider.of<LocalStorageProvider>(context, listen: true).localStorage;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Info'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Device Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildInfoSection("General Info", {
                'isLoggedIn': finalData.deviceInfo.isLoggedIn,
                'deviceChannel': finalData.deviceInfo.deviceChannel,
                'devicePlatform': finalData.deviceInfo.devicePlatform,
                'lastSignInTime': finalData.deviceInfo.lastSignInTime?.toIso8601String(),
                'deviceHeight': finalData.deviceInfo.deviceHeight,
                'deviceWidth': finalData.deviceInfo.deviceWidth,
                'deviceCategory': finalData.deviceInfo.deviceCategory,
              }),
              _buildInfoSection("Device Data", finalData.deviceInfo.deviceData ?? {}),
              _buildInfoSection("Network Info", finalData.deviceInfo.deviceNetwork ?? {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, Map<String, dynamic> data) {
    if (data.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue),
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: data.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${entry.value}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const Divider(),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}