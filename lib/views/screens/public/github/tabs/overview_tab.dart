import 'package:flutter/material.dart';
import 'package:deepakkaligotla/views/widgets/contribution_activity.dart';
import 'package:deepakkaligotla/views/widgets/popular_repositories.dart';
import 'package:deepakkaligotla/views/widgets/contributions_overview.dart';
import 'package:provider/provider.dart';
import 'package:deepakkaligotla/view_models/popularRepoViewModel.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<PopularRepositoriesViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.repositories.isEmpty && !viewModel.isLoading) {
                Future.microtask(() => viewModel.fetchRepositories());
              }
              if (viewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (viewModel.error != null) {
                return Center(child: Text(viewModel.error!));
              } else {
                return PopularRepositories(repositories: viewModel.repositories);
              }
            },
          ),
          ContributionsOverview(
            contributions: 23,
            contributionGraph: const Text(
              "GraphQL for contributions data",
            ),
          ),
          ContributionActivity()
        ],
      ),
    );
  }
}