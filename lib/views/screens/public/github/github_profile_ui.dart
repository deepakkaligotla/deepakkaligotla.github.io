import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class GitHubProfileUI extends StatefulWidget {
  const GitHubProfileUI({super.key});

  @override
  State<GitHubProfileUI> createState() => _GitHubProfileUIState();
}

class _GitHubProfileUIState extends State<GitHubProfileUI> {
  int followers = 1;
  int following = 7;
  bool isFollowersHovered = false;
  bool isFollowingHovered = false;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Profile Image
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: ClipOval(
            child: Image.network(
              "https://raw.githubusercontent.com/deepakkaligotla/deepakkaligotla.github.io/refs/heads/main/assets/images/logo.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),

        /// Name
        const Text(
          "Deepak Kaligotla",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),

        /// Email
        const Text(
          "deepak.kaligotla@gmail.com",
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        const SizedBox(height: 15),

        /// Follow Button
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap:
                () => _launchUrl(
              "https://github.com/deepakkaligotla",
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade700),
                borderRadius: BorderRadius.circular(6),
                color: Colors.transparent,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    FontAwesomeIcons.github,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Follow",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),

        /// Bio
        const Text(
          textAlign: TextAlign.center,
          "Mobile App Dev - Android & iOS\nTotal Experience: 6.3yr\nKotlin, Java, Swift, Node, GCP, Azure.",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 10),

        /// Followers & Following Links
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Followers
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter:
                  (_) =>
                  setState(() => isFollowersHovered = true),
              onExit:
                  (_) => setState(
                    () => isFollowersHovered = false,
              ),
              child: GestureDetector(
                onTap:
                    () => _launchUrl(
                  "https://github.com/deepakkaligotla?tab=followers",
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.android_sharp,
                      size: 16,
                      color:
                      isFollowersHovered
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "$followers follower",
                      style: TextStyle(
                        color:
                        isFollowersHovered
                            ? Colors.blue
                            : Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              " · ",
              style: TextStyle(
                fontSize: 14,
              ),
            ),

            /// Following
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter:
                  (_) =>
                  setState(() => isFollowingHovered = true),
              onExit:
                  (_) => setState(
                    () => isFollowingHovered = false,
              ),
              child: GestureDetector(
                onTap:
                    () => _launchUrl(
                  "https://github.com/deepakkaligotla?tab=followers",
                ),
                child: Row(
                  children: [
                    Text(
                      "$following following",
                      style: TextStyle(
                        color:
                        isFollowingHovered
                            ? Colors.blue
                            : Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.apple_sharp,
                      size: 16,
                      color:
                      isFollowingHovered
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _buildInfoRow(Icons.location_on, "Bangalore, India"),
        _buildInfoRow(Icons.access_time, "23:01 - same time"),
        const SizedBox(height: 10),
        _buildLink("Linkedin", "https://linkedin.com/in/deepakkaligotla", FontAwesomeIcons.linkedin),
        _buildLink("Google Play", "https://play.google.com/store/apps/dev?id=8089842178393161324", FontAwesomeIcons.googlePlay),
        _buildLink("Apple AppStore", "https://apps.apple.com/in/app/", FontAwesomeIcons.appStore),
        _buildLink("Medium", "https://deepakkaligotla.medium.com/", FontAwesomeIcons.medium),
        const SizedBox(height: 20),
        const Text(
          "Achievements",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        _buildAchievement(),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.grey, size: 16),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }

  Widget _buildLink(String linkName, String url, [IconData? icon]) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            FaIcon(icon, color: Colors.grey, size: 16)
          else
            Icon(Icons.link, color: Colors.grey, size: 16),
          const SizedBox(width: 8),
          Text(
            linkName,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievement() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          "https://github.githubassets.com/assets/quickdraw-default-39c6aec8ff89.png",
          width: 40,
          height: 40,
        ),
      ],
    );
  }
}