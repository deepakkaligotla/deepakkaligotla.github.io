import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as mobile_map;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:deepakkaligotla/models/experience.dart';
import 'package:deepakkaligotla/models/final_model.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';
import 'package:deepakkaligotla/views/widgets/components/glowing_container.dart';

class ExperienceItem extends StatelessWidget {
  final Experience experience;
  const ExperienceItem({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    final finalData = Provider.of<LocalStorageProvider>(context, listen: true).localStorage;
    bool isRemote = experience.location.latitude == 0.0 && experience.location.longitude == 0.0;

    return GlowingContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildCompanyLogo(experience.logoUrl),
              const SizedBox(width: 10),
              Expanded(child: _buildExperienceDetails(finalData)),
              isRemote ? _buildRemoteText(finalData) : _buildMap(experience.location),
            ],
          ),
          _buildAdditionalDetails(finalData),
        ],
      ),
    );
  }

  Widget _buildCompanyLogo(String logoUrl) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(logoUrl, fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildExperienceDetails(FinalModel finalData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          experience.jobTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: finalData.userDetails.userColorScheme!.onSurfaceVariant),
        ),
        Text(
          experience.companyName,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: finalData.userDetails.userColorScheme!.onSurface),
        ),
        Text(
          experience.roleDescription,
          style: TextStyle(fontSize: 12, color: finalData.userDetails.userColorScheme!.error),
        ),
      ],
    );
  }

  Widget _buildRemoteText(FinalModel finalData) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        'Work from Home',
        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: finalData.userDetails.userColorScheme!.onSurfaceVariant),
      ),
    );
  }

  Widget _buildMap(GeoPoint location) {
    return Container(
      height: 60,
      width: 80,
      margin: const EdgeInsets.only(left: 8.0),
      child: mobile_map.GoogleMap(
        initialCameraPosition: mobile_map.CameraPosition(
          target: mobile_map.LatLng(location.latitude, location.longitude),
          zoom: 12,
        ),
        markers: {
          mobile_map.Marker(
            markerId: mobile_map.MarkerId("marker1"),
            position: mobile_map.LatLng(location.latitude, location.longitude),
            infoWindow: mobile_map.InfoWindow(title: "Location"),
          ),
        },
        onTap: (mobile_map.LatLng tappedLocation) {
          _openGoogleMaps(tappedLocation.latitude, tappedLocation.longitude);
        },
      ),
    );
  }

  Future<void> _openGoogleMaps(double latitude, double longitude) async {
    final String googleMapsUrl = 'https://maps.google.com/?q=$latitude,$longitude';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  Widget _buildAdditionalDetails(FinalModel finalData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Technologies: ${experience.technologies.join(', ')}', style: TextStyle(fontSize: 12, color: finalData.userDetails.userColorScheme!.onSurfaceVariant)),
        Text('Skills: ${experience.skills.join(', ')}', style: TextStyle(fontSize: 12, color: finalData.userDetails.userColorScheme!.onSurfaceVariant)),
      ],
    );
  }
}