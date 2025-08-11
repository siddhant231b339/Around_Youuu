import 'package:flutter/material.dart';

class AroundScreen extends StatefulWidget {
  const AroundScreen({super.key});

  @override
  State<AroundScreen> createState() => _AroundScreenState();
}

class _AroundScreenState extends State<AroundScreen> {
  bool _scanning = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            child: ListTile(
              leading: Icon(Icons.radar, color: scheme.secondary),
              title: const Text('Scan for nearby explorers'),
              subtitle: const Text('Privacy-first fuzzy presence within ~100m'),
              trailing: Switch(
                value: _scanning,
                onChanged: (v) => setState(() => _scanning = v),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _scanning ? 5 : 0,
            itemBuilder: (_, i) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: scheme.secondary,
                  child: const Icon(Icons.person, color: Colors.black),
                ),
                title: Text('Explorer ${i + 1}'),
                subtitle: const Text('~80m away'),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add Friend'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}