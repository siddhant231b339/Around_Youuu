import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/providers.dart';
import '../tabs/ar_view_screen.dart';
import '../tabs/around_screen.dart';
import '../tabs/memories_screen.dart';
import '../tabs/chat_list_screen.dart';
import '../tabs/profile_screen.dart';
import '../memory/create_memory_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _index = 0;

  final _tabs = const [
    ARViewScreen(),
    AroundScreen(),
    MemoriesScreen(),
    ChatListScreen(),
    ProfileScreen(),
  ];

  final _titles = const ['AR', 'Around', 'Memories', 'Chat', 'Profile'];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
        actions: [
          if (_index == 2)
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CreateMemoryScreen()),
                );
              },
            ),
          if (_index == 4)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => ref.read(authServiceProvider).signOut(),
            ),
        ],
      ),
      body: IndexedStack(index: _index, children: _tabs),
      floatingActionButton: _index == 0
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CreateMemoryScreen()),
              ),
              icon: const Icon(Icons.add),
              label: const Text('New Memory'),
            )
          : null,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: scheme.outline.withOpacity(0.3))),
        ),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.view_in_ar), label: 'AR'),
            BottomNavigationBarItem(icon: Icon(Icons.radar), label: 'Around'),
            BottomNavigationBarItem(icon: Icon(Icons.photo_album), label: 'Memories'),
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}