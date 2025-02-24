import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as mobile_map;
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart' as web_map;
import 'package:url_launcher/url_launcher.dart';
import '../../../viewModel/experienceViewModel.dart';

class Experiencetab extends StatefulWidget {
  final ColorScheme userTheme;
  final double screenHeight;
  final double screenWidth;

  const Experiencetab({
    super.key,
    required this.userTheme,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  _ExperienceTabContentState createState() => _ExperienceTabContentState();
}

class _ExperienceTabContentState extends State<Experiencetab> {
  late web_map.GoogleMapController _webMapController;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<ExperienceViewModel>(context, listen: false).fetchExperiences());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExperienceViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var experience in viewModel.experiences)
                  _buildExperienceCard(
                    logoUrl: experience.logoUrl,
                    companyName: experience.companyName,
                    jobTitle: experience.jobTitle,
                    roleDescription: experience.roleDescription,
                    technologies: experience.technologies,
                    skills: experience.skills,
                    projects: experience.projects,
                    currentlyWorking: experience.currentlyWorking,
                    dateOfJoining: experience.dateOfJoining,
                    lastWorkingDay: experience.lastWorkingDay,
                    location: experience.location,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExperienceCard({
    required String logoUrl,
    required String companyName,
    required String jobTitle,
    required String roleDescription,
    required List<String> technologies,
    required List<String> skills,
    required List<DocumentReference> projects,
    required bool currentlyWorking,
    required Timestamp dateOfJoining,
    required Timestamp? lastWorkingDay,
    required GeoPoint location,
  }) {
    // Convert the timestamp to a human-readable date string
    String formattedDateOfJoining = _formatDate(dateOfJoining);
    String formattedLastWorkingDay = lastWorkingDay != null
        ? _formatDate(lastWorkingDay)
        : "Present";

    // Determine if the location is valid (0.0, 0.0 means it's remote)
    bool isRemote = location.latitude == 0.0 && location.longitude == 0.0;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Company logo
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FractionallySizedBox(
                      alignment: Alignment.center,
                      widthFactor: 0.8,
                      heightFactor: 0.8,
                      child: Image.network(
                        logoUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Job details (Company Name, Role, etc.)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: widget.userTheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        companyName,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: widget.userTheme.onSurface,
                        ),
                      ),
                      Text(
                        roleDescription,
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.userTheme.error,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'DOJ: $formattedDateOfJoining',
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.userTheme.onSurfaceVariant,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'LWD: $formattedLastWorkingDay',
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.userTheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Currently Working: ${currentlyWorking ? "Yes" : "No"}',
                        style: TextStyle(
                          fontSize: 12,
                          color: widget.userTheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Projects:',
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.userTheme.onSurfaceVariant,
                        ),
                      ),
                      // Display the project titles (or any other field from the project)
                      ...projects.map((projectRef) {
                        return FutureBuilder<DocumentSnapshot>(
                          future: projectRef.get(),  // Fetch the project document
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            if (snapshot.hasError) {
                              return Text('Error loading project details');
                            }
                            var projectData = snapshot.data?.data() as Map<String, dynamic>;
                            return Text(projectData?['title'] ?? 'No Title');
                          },
                        );
                      }).toList(),
                      const SizedBox(height: 8),
                      Text(
                        'Technologies: ${technologies.join(', ')}',
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.userTheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Skills: ${skills.join(', ')}',
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.userTheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                isRemote
                    ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Work from Home',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: widget.userTheme.onSurfaceVariant,
                    ),
                  ),
                )
                    : Container(
                  height: 100,
                  width: 150,
                  margin: const EdgeInsets.only(left: 8.0),
                  child: _buildMap(location),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMap(GeoPoint location) {
    return mobile_map.GoogleMap(
      initialCameraPosition: mobile_map.CameraPosition(
        target: mobile_map.LatLng(location.latitude, location.longitude),
        zoom: 12,
      ),
      onTap: (mobile_map.LatLng tappedLocation) {
        _openGoogleMaps(tappedLocation.latitude, tappedLocation.longitude);
      },
      markers: {
        mobile_map.Marker(
          markerId: mobile_map.MarkerId("marker1"),
          position: mobile_map.LatLng(location.latitude, location.longitude),
          infoWindow: mobile_map.InfoWindow(title: "Location"),
        ),
      },
      onMapCreated: (mobile_map.GoogleMapController controller) {
        // Optional: Use controller to interact with the map
      },
    );
  }

  Future<void> _openGoogleMaps(double latitude, double longitude) async {
    final String googleMapsUrl = 'https://maps.google.com/?q=$latitude,$longitude';
    debugPrint('map link: $googleMapsUrl');
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  String _formatDate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return '${date.day}/${date.month}/${date.year}';
  }
}