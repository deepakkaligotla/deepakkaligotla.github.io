import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';
import 'package:deepakkaligotla/view_models/experienceViewModel.dart';
import 'components/experience_item.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<ExperienceViewModel>(context, listen: false).fetchExperiences(),
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
                colors: [
                  Colors.purple,
                  Colors.cyanAccent,
                ],
              ).createShader(bounds);
            },
            child: Text(
              "Work Experience",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: Consumer<ExperienceViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return Center(child: CircularProgressIndicator());
              }

              return Card(
                elevation: 8.0,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (finalData.deviceInfo.deviceWidth! / 360).toInt(),
                    childAspectRatio: 360 / 240,
                  ),
                  itemCount: viewModel.experiences.length,
                  itemBuilder: (context, index) {
                    final experience = viewModel.experiences[index];
                    return ExperienceItem(experience: experience);
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