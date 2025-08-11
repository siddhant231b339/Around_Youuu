import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Chats',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: scheme.secondary,
              ),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          6,
          (i) => Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: scheme.primary,
                child: Text('${i + 1}', style: TextStyle(color: scheme.onPrimary)),
              ),
              title: Text('Explorer ${i + 1}'),
              subtitle: const Text('Hey there!'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}