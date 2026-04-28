import 'package:flutter/material.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projets'),
      ),
      body: const Center(
        child: Text('Écran Projets'),
      ),
    );
  }
}

class ProjectDetailScreen extends StatelessWidget {
  final String projectId;

  const ProjectDetailScreen({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projet $projectId'),
      ),
      body: Center(
        child: Text('Détail du projet : $projectId'),
      ),
    );
  }
}