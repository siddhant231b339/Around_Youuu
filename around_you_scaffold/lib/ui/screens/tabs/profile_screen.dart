import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 12),
        Center(
          child: CircleAvatar(
            radius: 44,
            backgroundColor: scheme.secondary,
            child: Icon(Icons.person, color: scheme.onSecondary, size: 40),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            'Explorer',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(height: 24),
        Card(
          child: Column(
            children: const [
              ListTile(
                leading: Icon(Icons.emoji_events),
                title: Text('Achievements'),
                trailing: Icon(Icons.chevron_right),
              ),
              Divider(height: 0),
              ListTile(
                leading: Icon(Icons.map),
                title: Text('My Trails'),
                trailing: Icon(Icons.chevron_right),
              ),
              Divider(height: 0),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ],
    );
  }
}