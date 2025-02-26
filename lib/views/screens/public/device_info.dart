import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';
import '../../../models/device_info.dart';

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

              /// General Device Info
              _buildInfoSection("General Info", DeviceInfo.toMap(finalData.deviceInfo)),

              /// Device Data
              _buildInfoSection("Device Data", finalData.deviceInfo.deviceData ?? {}),

              /// Network Info
              _buildInfoSection("Network Info", finalData.deviceInfo.deviceNetwork ?? {}),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper function to create a section for device info
  Widget _buildInfoSection(String title, Map<String, dynamic> data) {
    if (data.isEmpty) return const SizedBox(); // Hide section if no data

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