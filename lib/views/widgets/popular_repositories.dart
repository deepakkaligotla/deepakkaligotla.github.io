import 'package:flutter/material.dart';

class PopularRepositories extends StatelessWidget {
  final List<Map<String, dynamic>> repositories;

  const PopularRepositories({Key? key, required this.repositories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Popular Repositories",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: repositories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.5,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final repo = repositories[index];
            return Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repo['name'],
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      repo['description'],
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "🔴 ${repo['language']}",
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          "⭐ ${repo['stars']}",
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}