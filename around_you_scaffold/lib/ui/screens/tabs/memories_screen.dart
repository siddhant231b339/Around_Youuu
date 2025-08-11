import 'package:flutter/material.dart';

class MemoriesScreen extends StatelessWidget {
  const MemoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Nearby Memories',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: scheme.secondary,
              ),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          4,
          (i) => Card(
            child: ListTile(
              leading: Icon(Icons.place, color: scheme.tertiary),
              title: Text('Memory ${i + 1}'),
              subtitle: const Text('Tap to view in AR'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}